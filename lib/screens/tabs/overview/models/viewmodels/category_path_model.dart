import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/util/text_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_path_model.g.dart';

@JsonSerializable()
class CategoryPathModel {
  CategoryPathModel(
      {@required this.categoryId,
      @required this.category,
      @required this.subcategory});
  String categoryId;
  CategoryVM category;
  CategoryVM subcategory;

  factory CategoryPathModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryPathModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryPathModelToJson(this);

  String getCategory(Locale lang) {
    return category.getTranslated(lang);
  }

  String getSubcategory(Locale lang) {
    return subcategory.getTranslated(lang);
  }
}

@JsonSerializable()
class CategoryVM {
  CategoryVM(
      {@required this.categoryName,
      @required this.categoryNameMs,
      @required this.categoryNameZh});
  String categoryName;
  String categoryNameMs;
  String categoryNameZh;

  String getTranslated(Locale lang) {
    var category = categoryName;
    switch (lang.languageCode) {
      case 'ms':
        category = categoryNameMs;
        break;
      case 'zh':
        category = categoryNameZh;
        break;
      case 'en':
        category = categoryName;
        break;
      default:
        break;
    }
    return TextUtils.capitalize(category);
  }

  factory CategoryVM.fromJson(Map<String, dynamic> json) =>
      _$CategoryVMFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryVMToJson(this);
}
