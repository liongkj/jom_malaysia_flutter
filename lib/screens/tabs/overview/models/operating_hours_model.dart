import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/day_of_week_enum.dart';
import 'package:jom_malaysia/util/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operating_hours_model.g.dart';

@JsonSerializable()
class OperatingHours {
  OperatingHours(
      {@required this.dayofWeek,
      @required this.openTime,
      @required this.closeTime});
  // https://github.com/flutter/flutter/issues/18748
  DayOfWeek dayofWeek;
  String openTime;
  String closeTime;

  DateTime get openHour {
    return DateUtils.apiTimeFormat(openTime);
  }

  DateTime get closeHour {
    return DateUtils.apiTimeFormat(closeTime);
  }

  factory OperatingHours.fromJson(Map<String, dynamic> json) =>
      _$OperatingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OperatingHoursToJson(this);
}
