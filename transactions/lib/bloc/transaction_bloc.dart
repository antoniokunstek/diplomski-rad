import 'package:bloc/bloc.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_events.dart';
import 'package:diplomski_rad_transactions_module/bloc/transaction_state.dart';
import 'package:diplomski_rad_transactions_module/model/transaction.dart';
import 'package:diplomski_rad_transactions_module/network/rest.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc(): super(TransactionInitial()) {
    on<GetAllTransactions>(_getAllTransactions);
    on<GetAllIncomes>(_getAllIncomes);
    on<GetAllExpenses>(_getAllExpenses);
    on<AddTransaction>(_addTransaction);
  }

  Future<void> _getAllTransactions(GetAllTransactions event, Emitter<TransactionState> state) async {
    emit(TransactionLoading());
    try {
      List<Transaction> listOfTransaction = await getAllTransactions(event.authJwtToken, event.accountId);
      emit(TransactionLoaded(transaction: listOfTransaction));
    } catch (e) {
      emit(TransactionFailure());
    }
  }

  Future<void> _getAllIncomes(GetAllIncomes event, Emitter<TransactionState> state) async {
    emit(TransactionLoading());
    try {
      List<Transaction> listOfTransaction = await getAllIncomes(event.authJwtToken, event.accountId);
      emit(TransactionLoaded(transaction: listOfTransaction));
    } catch (e) {
      emit(TransactionFailure());
    }
  }

  Future<void> _getAllExpenses(GetAllExpenses event, Emitter<TransactionState> state) async {
    emit(TransactionLoading());
    try {
      List<Transaction> listOfTransaction = await getAllExpenses(event.authJwtToken, event.accountId);
      emit(TransactionLoaded(transaction: listOfTransaction));
    } catch (e) {
      emit(TransactionFailure());
    }
  }

  Future<void> _addTransaction(AddTransaction event, Emitter<TransactionState> state) async {
    emit(TransactionLoading());
    try {
      bool isCreated = await addTransaction(event.model, event.authJwtToken);
      emit(TransactionCreated());
    } catch (e) {
      emit(TransactionFailure());
    }
  }
}