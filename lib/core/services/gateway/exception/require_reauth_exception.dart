class RequireReauthException implements Exception {
  RequireReauthException({this.status});

  final String status;
}
