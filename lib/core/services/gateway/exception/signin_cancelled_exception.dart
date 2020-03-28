class SignInCancelledException implements Exception {
  SignInCancelledException({this.code, this.status});
  final int code;
  final String status;
}
