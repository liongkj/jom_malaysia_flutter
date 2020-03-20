class ApiException implements Exception {
  ApiException(this.code, this.status);
  final int code;
  final String status;
}
