import '../model/transaction.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionLoaded extends TransactionState {
  final List<Transaction> transaction;

  TransactionLoaded({
    required this.transaction
  });
}

class TransactionCreated extends TransactionState {}
class TransactionFailure extends TransactionState {}