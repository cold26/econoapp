import 'dart:developer';

import 'package:econoapp/common/models/balances_model.dart';
import 'package:econoapp/common/models/transaction_model.dart';
import 'package:econoapp/data/exceptions.dart';

import '../common/constants/constants.dart';
import '../common/extensions/types_ext.dart';
import '../repositories/repositories.dart';
import 'services.dart';

class SyncService {
  const SyncService({
    required this.connectionService,
    required this.databaseService,
    required this.graphQLService,
    required this.secureStorageService,
  });

  final ConnectionService connectionService;
  final DatabaseService databaseService;
  final GraphQLService graphQLService;
  final SecureStorageService secureStorageService;

  Future<void> syncFromServer() async {
    log('syncFromServer called', name: 'INFO');
    await connectionService.checkConnection();
    if (!connectionService.isConnected) return;

    final needSync = await secureStorageService.readOne(key: 'NEED_SYNC');
    if (needSync != null && !needSync.toBool()) return;

    try {
      await databaseService.init();

      await _syncBalanceFromServer();
      await _syncTransactionsFromServer();

      await secureStorageService.write(
        key: 'NEED_SYNC',
        value: false.toString(),
      );
    } catch (e, stackTrace) {
      log('syncFromServer exception $e', name: 'ERROR');
      log('Stack trace: $stackTrace', name: 'ERROR');
      rethrow;
    }
  }

  Future<void> _syncTransactionsFromServer() async {
    final clock = Stopwatch();

    log('_syncTransactionsFromServer called', name: 'INFO');

    final localTransactions = await _getLocalTransactions();

    // Se existem mudanças locais pendentes, evita sobrescrever.
    if (localTransactions.isNotEmpty) {
      log('Local transactions pending, skipping sync from server.', name: 'INFO');
      return;
    }

    final transactionsFromServerResponse = await graphQLService.read(
      path: Queries.qGetTrasactions,
    );

    // Validar se resposta contem dados
    if (transactionsFromServerResponse['transaction'] == null) {
      log('No transactions data received from server.', name: 'ERROR');
      return;
    }

    final parsedTransactionsFromServer =
        List.from(transactionsFromServerResponse['transaction']);

    final transactionsFromServer = parsedTransactionsFromServer
        .map((e) => TransactionModel.fromMap(e))
        .toList();

    clock.start();

    for (var t in transactionsFromServer) {
      await saveLocalChanges(
        path: TransactionRepository.transactionsPath,
        params: t.copyWith(syncStatus: SyncStatus.synced).toDatabase(),
      );
    }

    clock.stop();
    log('Total sync time: ${clock.elapsed.inSeconds}s',
        name: 'Sync Transactions from Server');
  }

  Future<void> _syncBalanceFromServer() async {
    log('_syncBalanceFromServer called', name: 'INFO');

    final localBalanceResponse =
        (await databaseService.read(path: TransactionRepository.balancesPath));

    if ((localBalanceResponse['data'] as List).isNotEmpty) {
      log('Local balance data present, skipping sync from server.', name: 'INFO');
      return;
    }

    final remoteBalanceResponse =
        await graphQLService.read(path: Queries.qGetBalances);

    final balances = BalancesModel.fromMap(remoteBalanceResponse);

    await saveLocalChanges(
      path: TransactionRepository.balancesPath,
      params: balances.toMap(),
    );
  }

  Future<void> saveLocalChanges({
    required String path,
    required Map<String, Object?> params,
  }) async {
    final response = await databaseService.create(
      path: path,
      params: params,
    );

    if (!(response['data'] as bool? ?? false)) {
      throw const CacheException(code: 'write');
    }

    await secureStorageService.write(
      key: 'NEED_SYNC',
      value: true.toString(),
    );
  }

  Future<void> syncToServer() async {
    log('syncToServer called', name: 'INFO');
    await connectionService.checkConnection();

    if (!connectionService.isConnected) {
      log('No internet connection. Aborting syncToServer.', name: 'WARNING');
      return;
    }

    List<TransactionModel> localTransactions = await _getLocalTransactions();

    if (localTransactions.isEmpty) {
      log('No local transactions to sync.', name: 'INFO');
      return;
    }

    try {
      for (final t in localTransactions) {
        await _syncLocalTransactionsToServer(t);

        if (t.syncStatus == SyncStatus.delete) {
          await databaseService.delete(
              path: TransactionRepository.transactionsPath,
              params: {'id': t.id});
          continue;
        }

        await saveLocalChanges(
          path: TransactionRepository.transactionsPath,
          params: t.copyWith(syncStatus: SyncStatus.synced).toDatabase(),
        );
      }

      await secureStorageService.write(
        key: 'NEED_SYNC',
        value: false.toString(),
      );
    } catch (e, stackTrace) {
      log('Unexpected error during syncToServer: $e', name: 'ERROR');
      log('Stack trace: $stackTrace', name: 'ERROR');
      throw const SyncException(code: 'error');
    }
  }

  Future<List<TransactionModel>> _getLocalTransactions() async {
    final response = await databaseService.read(
        path: TransactionRepository.transactionsPath);

    final List<Map<String, dynamic>> transactions = response['data'] ?? [];

    final parsedTransactions = transactions.map((change) {
      return TransactionModel.fromMap(change);
    }).toList();

    final localChanges = parsedTransactions
        .where((t) => t.syncStatus != SyncStatus.synced)
        .toList();

    return localChanges;
  }

  Future<void> _syncLocalTransactionsToServer(
      TransactionModel localTransaction) async {
    log('_syncLocalTransactionsToServer called for transaction id: ${localTransaction.id}', name: 'INFO');
    try {
      var response = <String, dynamic>{};

      switch (localTransaction.syncStatus) {
        case SyncStatus.create:
          response = await graphQLService.create(
            path: Mutations.mAddNewTransaction,
            params: localTransaction.toMap(),
          );
          break;
        case SyncStatus.update:
          final transactionWithoutUserId = localTransaction.toMap();
          transactionWithoutUserId.removeWhere((key, value) => key == 'user_id');

          response = await graphQLService.update(
            path: Mutations.mUpdateTransaction,
            params: transactionWithoutUserId,
          );
          break;
        case SyncStatus.delete:
          response = await graphQLService.delete(
              path: Mutations.mDeleteTransaction,
              params: {'id': localTransaction.id});
          break;
        default:
          log('Unknown syncStatus: ${localTransaction.syncStatus}', name: 'ERROR');
          throw const SyncException(code: 'error');
      }

      // VERIFICAÇÃO EXTRA ajustada: só loga, não lança exceção
      if (response.isEmpty) {
        log('GraphQL response is empty for transaction ID: ${localTransaction.id}', name: 'WARNING');
        log('Transaction data sent: ${localTransaction.toMap()}', name: 'WARNING');
      }
    } catch (e, stackTrace) {
      log('_syncLocalTransactionsToServer exception $e', name: 'ERROR');
      log('Stack trace: $stackTrace', name: 'ERROR');
      rethrow;
    }
  }
}
