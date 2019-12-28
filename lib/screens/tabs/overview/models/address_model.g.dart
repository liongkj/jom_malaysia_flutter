// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressVM _$AddressVMFromJson(Map<String, dynamic> json) {
  return AddressVM(
    add1: json['add1'] as String,
    add2: json['add2'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    postalCode: json['postalCode'] as String,
    coordinates: json['coordinates'] == null
        ? null
        : CoordinatesModel.fromJson(
            json['coordinates'] as Map<String, dynamic>),
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$AddressVMToJson(AddressVM instance) => <String, dynamic>{
      'add1': instance.add1,
      'add2': instance.add2,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'coordinates': instance.coordinates,
    };
