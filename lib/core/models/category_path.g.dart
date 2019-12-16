// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPath _$CategoryPathFromJson(Map<String, dynamic> json) {
  return CategoryPath(
    json['category'] as String,
    json['subcategory'] as String,
  );
}

Map<String, dynamic> _$CategoryPathToJson(CategoryPath instance) =>
    <String, dynamic>{
      'category': instance.category,
      'subcategory': instance.subcategory,
    };
