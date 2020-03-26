class InvalidEmailException implements Exception {
  InvalidEmailException(this.status);
  final String status;
}
