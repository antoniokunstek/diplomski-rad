import 'package:diplomski_rad_transactions_module/model/transaction_form.dart';

abstract class TransactionEvent {

}

class GetAllTransactions extends TransactionEvent {
  final String? accountId;
  final String? authJwtToken;

  GetAllTransactions({
    required this.accountId,
    required this.authJwtToken
  });
}

class GetAllIncomes extends TransactionEvent {
  final String? accountId;
  final String? authJwtToken;

  GetAllIncomes({
    required this.accountId,
    required this.authJwtToken
  });
}

class GetAllExpenses extends TransactionEvent {
  final String? accountId;
  final String? authJwtToken;

  GetAllExpenses({
    required this.accountId,
    required this.authJwtToken
  });
}

class AddTransaction extends TransactionEvent {
  final String? authJwtToken;
  final TransactionFormModel model;

  AddTransaction({
    required this.authJwtToken,
    required this.model
  });
}
