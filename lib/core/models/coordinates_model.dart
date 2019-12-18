import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coordinates_model.g.dart';

@JsonSerializable()
class CoordinatesModel {
  double longitude;

  double latitude;

  CoordinatesModel({
    @required this.longitude,
    @required this.latitude,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}
