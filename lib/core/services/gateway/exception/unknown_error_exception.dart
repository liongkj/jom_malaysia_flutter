class UnknownErrorException implements Exception {
  UnknownErrorException(this.status);
  final String status;
}
