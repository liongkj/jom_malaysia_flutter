// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    cityName: json['cityName'] as String,
    cityNameZh: json['cityNameZh'] as String,
    isHot: json['isHot'] as bool,
    firstChar: json['firstChar'] as String,
    firstCharZh: json['firstCharZh'] as String,
    tagIndex: json['tagIndex'] as String,
  )..isShowSuspension = json['isShowSuspension'] as bool;
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'isShowSuspension': instance.isShowSuspension,
      'cityName': instance.cityName,
      'cityNameZh': instance.cityNameZh,
      'firstChar': instance.firstChar,
      'firstCharZh': instance.firstCharZh,
      'tagIndex': instance.tagIndex,
      'isHot': instance.isHot,
    };
