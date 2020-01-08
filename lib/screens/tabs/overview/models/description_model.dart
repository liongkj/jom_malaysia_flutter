import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'description_model.g.dart';

@JsonSerializable()
class DescriptionVM {
  DescriptionVM({this.ms, this.zh, this.en});
  String ms;
  String zh;
  String en;

  factory DescriptionVM.fromJson(Map<String, dynamic> json) =>
      _$DescriptionVMFromJson(json);

  Map<String, dynamic> toJson() => _$DescriptionVMToJson(this);

  String getDefault() {
    return en != null ? en : ms != null ? ms : zh != null ? zh : "";
  }

  String getDescription(Locale lang) {
    switch (lang?.languageCode) {
      case "en":
        return en ?? "No description available";
        break;
      case "zh":
        return zh ?? "无详情";
        break;
      case "ms":
        return ms ?? "Tak ade info lain";
        break;
      default:
        return getDefault();
    }
  }
}
