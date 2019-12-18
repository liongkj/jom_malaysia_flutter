// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinates_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) {
  return CoordinatesModel(
    longitude: (json['longitude'] as num)?.toDouble(),
    latitude: (json['latitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordinatesModelToJson(CoordinatesModel instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
