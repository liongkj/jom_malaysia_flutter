import 'package:json_annotation/json_annotation.dart';

part 'cloudinary_upload_response.g.dart';

@JsonSerializable()
class CloudinaryUploadResponse {
  // ignore: non_constant_identifier_names
  CloudinaryUploadResponse({this.secure_url});
  // ignore: non_constant_identifier_names
  String secure_url;

  factory CloudinaryUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$CloudinaryUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CloudinaryUploadResponseToJson(this);
}
