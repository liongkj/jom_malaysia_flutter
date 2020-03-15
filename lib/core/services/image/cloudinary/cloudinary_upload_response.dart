import 'package:json_annotation/json_annotation.dart';

part 'cloudinary_upload_response.g.dart';

@JsonSerializable()
class CloudinaryUploadResponse {
  CloudinaryUploadResponse({this.secure_url});
  String secure_url;

  factory CloudinaryUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$CloudinaryUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CloudinaryUploadResponseToJson(this);
}
