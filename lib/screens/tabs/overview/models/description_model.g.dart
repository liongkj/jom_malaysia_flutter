// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'description_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DescriptionVM _$DescriptionVMFromJson(Map<String, dynamic> json) {
  return DescriptionVM(
    ms: json['ms'] as String,
    zh: json['zh'] as String,
    en: json['en'] as String,
  );
}

Map<String, dynamic> _$DescriptionVMToJson(DescriptionVM instance) =>
    <String, dynamic>{
      'ms': instance.ms,
      'zh': instance.zh,
      'en': instance.en,
    };
