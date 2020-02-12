import 'package:json_annotation/json_annotation.dart';

part 'ads_model.g.dart';

@JsonSerializable()
class AdsModel {
  AdsModel({
    this.imageUrl,
    this.linkTo,
    this.title,
    this.titleMs,
    this.titleZh,
  });
  String imageUrl;
  String linkTo;
  String title;

  String titleMs;
  String titleZh;

  factory AdsModel.fromJson(Map<String, dynamic> json) =>
      _$AdsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdsModelToJson(this);
}
