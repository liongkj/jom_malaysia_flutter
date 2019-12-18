class ApiResponse {
  ApiResponse({this.data, this.success});

  factory ApiResponse.fromJson(dynamic parsedJson) {
    dynamic data = parsedJson["data"];
    bool success = parsedJson["success"];
    return ApiResponse(
      success: success,
      data: data,
    );
  }

  dynamic data;
  bool success;
}
