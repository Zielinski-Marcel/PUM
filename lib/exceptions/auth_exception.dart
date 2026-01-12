class AuthException implements Exception {
  final String message;

  AuthException([this.message = 'Auth error occurred.']);

  @override
  String toString() => 'AuthException: $message';
}
