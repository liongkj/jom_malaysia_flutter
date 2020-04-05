class OperationCancelledException implements Exception {
  OperationCancelledException(this.code);

  final String code;
}
