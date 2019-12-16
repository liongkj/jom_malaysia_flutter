import 'package:json_annotation/json_annotation.dart';

part 'category_path.g.dart';

@JsonSerializable()
class CategoryPath {
  CategoryPath(this.category, this.subcategory);
  String category;
  String subcategory;

  factory CategoryPath.fromJson(Map<String, dynamic> json) =>
      _$CategoryPathFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryPathToJson(this);
}
