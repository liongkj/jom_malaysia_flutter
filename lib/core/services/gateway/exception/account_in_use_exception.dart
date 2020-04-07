class AccountInUseException implements Exception {
  AccountInUseException({this.status});

  final String status;
}
