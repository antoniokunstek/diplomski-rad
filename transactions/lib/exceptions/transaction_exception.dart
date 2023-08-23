class TransactionException implements Exception {
  String message;
  TransactionException({
    required this.message
});
}