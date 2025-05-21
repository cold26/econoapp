import 'package:econoapp/features/home/widgets/balance_card.dat/balance_card_widget.state.dart';
import 'package:econoapp/repositories/transaction_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../../common/models/balances_model.dart';


class BalanceCardWidgetController extends ChangeNotifier {
  final TransactionRepository transactionRepository;
  BalanceCardWidgetController({
    required this.transactionRepository,
  });

  BalanceCardWidgetState _state = BalanceCardWidgetStateInitial();

  BalanceCardWidgetState get state => _state;

  BalancesModel _balances = BalancesModel(
    totalIncome: 0,
    totalOutcome: 0,
    totalBalance: 0,
  );
  BalancesModel get balances => _balances;

  void _changeState(BalanceCardWidgetState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getBalances() async {
    _changeState(BalanceCardWidgetStateLoading());
    try {
      _balances = await transactionRepository.getBalances();
      _changeState(BalanceCardWidgetStateSuccess());
    } catch (e) {
      _changeState(BalanceCardWidgetStateError());
    }
  }
}