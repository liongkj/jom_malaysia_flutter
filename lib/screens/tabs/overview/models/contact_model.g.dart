// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactVM _$ContactVMFromJson(Map<String, dynamic> json) {
  return ContactVM(
    mobileNumber: json['mobileNumber'] as String,
    officeNumber: json['officeNumber'] as String,
    website: json['website'] as String,
    fax: json['fax'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$ContactVMToJson(ContactVM instance) => <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'officeNumber': instance.officeNumber,
      'website': instance.website,
      'fax': instance.fax,
      'email': instance.email,
    };
