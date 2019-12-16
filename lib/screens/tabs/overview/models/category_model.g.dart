// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    json['categoryId'] as String,
    json['categoryName'] as String,
    json['categoryNameMs'] as String,
    json['categoryNameZh'] as String,
    json['categoryPath'] == null
        ? null
        : CategoryPath.fromJson(json['categoryPath'] as Map<String, dynamic>),
    json['categoryThumbnail'] == null
        ? null
        : ImageModel.fromJson(
            json['categoryThumbnail'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$CategoryTypeEnumMap, json['categoryType']),
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryNameMs': instance.categoryNameMs,
      'categoryNameZh': instance.categoryNameZh,
      'categoryType': _$CategoryTypeEnumMap[instance.categoryType],
      'categoryPath': instance.categoryPath,
      'categoryThumbnail': instance.categoryThumbnail,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CategoryTypeEnumMap = {
  CategoryType.Professional: 'Professional',
  CategoryType.Government: 'Government',
  CategoryType.Private: 'Private',
  CategoryType.Nonprofit: 'Nonprofit',
  CategoryType.Attraction: 'Attraction',
};
