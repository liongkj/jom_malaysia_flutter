// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) {
  return CoordinatesModel(
    longtitude: json['longtitude'] as String,
    latitude: json['latitude'] as String,
  );
}

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'longtitude': instance.longtitude,
      'latitude': instance.latitude,
    };
