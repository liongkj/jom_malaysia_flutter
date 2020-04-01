// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authuser_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) {
  return AuthUser(
    json['userId'] as String,
    json['username'] as String,
    json['profileImage'] as String,
    json['email'] as String,
  );
}

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'email': instance.email,
      'userId': instance.userId,
      'username': instance.username,
      'profileImage': instance.profileImage,
    };
