// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_path_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryPathModel _$CategoryPathModelFromJson(Map<String, dynamic> json) {
  return CategoryPathModel(
    categoryId: json['categoryId'] as String,
    category: json['category'] == null
        ? null
        : CategoryVM.fromJson(json['category'] as Map<String, dynamic>),
    subcategory: json['subcategory'] == null
        ? null
        : CategoryVM.fromJson(json['subcategory'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CategoryPathModelToJson(CategoryPathModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'category': instance.category,
      'subcategory': instance.subcategory,
    };

CategoryVM _$CategoryVMFromJson(Map<String, dynamic> json) {
  return CategoryVM(
    categoryName: json['categoryName'] as String,
    categoryNameMs: json['categoryNameMs'] as String,
    categoryNameZh: json['categoryNameZh'] as String,
  );
}

Map<String, dynamic> _$CategoryVMToJson(CategoryVM instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryNameMs': instance.categoryNameMs,
      'categoryNameZh': instance.categoryNameZh,
    };
