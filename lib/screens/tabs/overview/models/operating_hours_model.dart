import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/day_of_week_enum.dart';
import 'package:jom_malaysia/util/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operating_hours_model.g.dart';

@JsonSerializable()
class OperatingHours {
  OperatingHours(
      {@required this.dayOfWeek,
      @required this.openTime,
      @required this.closeTime});
  // https://github.com/flutter/flutter/issues/18748
  DayOfWeek dayOfWeek;
  String openTime;
  String closeTime;

  String get openHour {
    DateTime h = DateUtils.apiHourParse(openTime);
    return DateUtils.apiTimeFormat(h);
  }

  String get closeHour {
    DateTime h = DateUtils.apiHourParse(closeTime);
    return DateUtils.apiTimeFormat(h);
  }

  bool get closingSoon {
    DateTime h = DateUtils.apiHourParse(closeTime);

    return h.difference(DateTime.now()).inHours <= 1;
  }

  factory OperatingHours.fromJson(Map<String, dynamic> json) =>
      _$OperatingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OperatingHoursToJson(this);
}
