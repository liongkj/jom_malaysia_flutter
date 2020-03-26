class InvalidCredentialException implements Exception {
  InvalidCredentialException(this.status);
  final String status;
}
