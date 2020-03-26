class NetworkException implements Exception {
  NetworkException(this.code, this.status);
  final int code;
  final String status;
}
