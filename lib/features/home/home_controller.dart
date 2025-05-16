import 'package:econoapp/common/models/transaction_model.dart';
import 'package:econoapp/features/home/home_state.dart';
import 'package:econoapp/repositories/transaction_repository.dart';
import 'package:flutter/foundation.dart';
//TODO: import states

class HomeController extends ChangeNotifier {
  final TransactionRepository _transactionRepository;
  HomeController(this._transactionRepository);

  HomeState _state = HomeStateInitial();
  
  HomeState get state => _state;

  List<TransactionModel> _transactions = [];
  List<TransactionModel>  get transactions => _transactions;
  
  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> getAllTransactions() async {
    _changeState(HomeStateLoading());
    try {

      throw Exception();
     _transactions = await _transactionRepository.getAllTransactions();
      _changeState(HomeStateSuccess());
    } catch (e) {
      _changeState(HomeStateError());
    }
  }
}