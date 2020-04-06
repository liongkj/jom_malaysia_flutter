class ParseErrorException implements Exception {
  ParseErrorException({this.status});
  final String status;
}
