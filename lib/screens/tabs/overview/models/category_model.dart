import 'package:jom_malaysia/core/constants/category_type_enum.dart';
import 'package:jom_malaysia/core/models/category_path.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  CategoryModel(
      this.categoryId,
      this.categoryName,
      this.categoryNameMs,
      this.categoryNameZh,
      this.categoryPath,
      this.categoryThumbnail,
      this.categoryType);
  String categoryId;
  String categoryName;
  String categoryNameMs;
  String categoryNameZh;
  CategoryType categoryType;
  CategoryPath categoryPath;
  ImageModel categoryThumbnail;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
