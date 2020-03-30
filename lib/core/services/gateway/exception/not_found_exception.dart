class NotFoundException implements Exception {
  NotFoundException(this.status);
  final String status;
}
