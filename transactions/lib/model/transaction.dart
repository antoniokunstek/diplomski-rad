class Transaction {
  String transactionLabel;
  String amount;
  String currency;
  String dateOfTransaction;
  String note;
  String categoryId;
  String transactionType;

  Transaction({
    required this.transactionLabel,
    required this.amount,
    required this.currency,
    required this.dateOfTransaction,
    required this.note,
    required this.categoryId,
    required this.transactionType
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(transactionLabel: json['transactionLabel'],
        amount: json['amount'],
        currency: json['currency'],
        dateOfTransaction: json['dateOfTransaction'],
        note: json['note'],
        categoryId: json['categoryId'],
        transactionType: json['transactionType']);
  }
}