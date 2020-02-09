// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdsModel _$AdsModelFromJson(Map<String, dynamic> json) {
  return AdsModel(
    imageUrl: json['imageUrl'] as String,
    linkTo: json['linkTo'] as String,
    title: json['title'] as String,
    titleMs: json['titleMs'] as String,
    titleZh: json['titleZh'] as String,
  );
}

Map<String, dynamic> _$AdsModelToJson(AdsModel instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'linkTo': instance.linkTo,
      'title': instance.title,
      'titleMs': instance.titleMs,
      'titleZh': instance.titleZh,
    };
