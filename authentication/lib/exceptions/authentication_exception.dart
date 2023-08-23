class AuthenticationException implements Exception {
  String message;
  AuthenticationException({required this.message});
}