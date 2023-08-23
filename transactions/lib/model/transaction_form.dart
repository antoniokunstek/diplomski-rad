class TransactionFormModel{
  String transactionLabel;
  dynamic amount;
  String note;
  String accountId;
  int categoryId;
  int transactionType;

  TransactionFormModel({
    required this.transactionLabel,
    required this.amount,
    required this.note,
    required this.categoryId,
    required this.accountId,
    required this.transactionType
});

  static Map<String, dynamic> toJson(TransactionFormModel model) {
    return {
      'transactionLabel': model.transactionLabel,
      'amount': model.amount,
      'currency': 'EURO',
      'note': model.note,
      'accountId': model.accountId,
      'statusId': 1,
      'categoryId': model.categoryId,
      'transactionType': model.transactionType
    };
  }
}