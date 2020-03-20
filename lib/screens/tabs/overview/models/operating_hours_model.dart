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

  String openHour(Locale locale) {
    return _formattedTime(openTime, locale);
  }

  String closeHour(Locale locale) {
    return _formattedTime(closeTime, locale);
  }

  String _formattedTime(String raw, Locale locale) {
    DateTime h = DateUtils.apiHourParse(raw);
    return DateUtils.apiTimeFormat(h, locale?.languageCode ?? 'en');
  }

  bool get closingSoon {
    DateTime now = DateTime.now();
    DateTime ot = DateUtils.apiHourParse(closeTime);
    DateTime closingTime =
        new DateTime(now.year, now.month, now.day, ot.hour, ot.minute);

    return closingTime.difference(now).inMinutes <= 45 &&
        closingTime.isAfter(now);
  }

  bool get isOpen {
    DateTime now = DateTime.now();

    DateTime ot = DateUtils.apiHourParse(openTime);
    DateTime o = new DateTime(now.year, now.month, now.day, ot.hour, ot.minute);
    DateTime ct = DateUtils.apiHourParse(closeTime);
    DateTime c = new DateTime(now.year, now.month, now.day, ct.hour, ct.minute);

    return now.isAfter(o) && now.isBefore(c);
  }

  factory OperatingHours.fromJson(Map<String, dynamic> json) =>
      _$OperatingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$OperatingHoursToJson(this);
}
