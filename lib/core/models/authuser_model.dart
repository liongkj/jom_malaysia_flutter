import 'package:json_annotation/json_annotation.dart';

part 'authuser_model.g.dart';

@JsonSerializable()
class AuthUser {
  AuthUser(
    this.userId,
    this.username,
    this.profileImage,
    this.email,
  );

  String email;
  String userId;
  String username;
  String profileImage;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);

  String getSocialName() {
    return username ?? email;
  }
}
