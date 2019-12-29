import "package:intl/intl.dart";

import 'date_utils_.dart';

/// @Author: aleksanderwozniak
/// @GitHub: https://github.com/aleksanderwozniak/table_calendar
/// @Description: Date Util.
class DateUtils {
  static final DateFormat _apiDayFormat = new DateFormat("yy.MM.dd");
  static String apiDayFormat(DateTime d) => _apiDayFormat.format(d);

  static final DateFormat _apiHourParse = new DateFormat('Hms');
  static DateTime apiHourParse(String t) => _apiHourParse.parse(t);

  static final DateFormat _apiTimeFormat = new DateFormat.jm();
  static String apiTimeFormat(DateTime t) => _apiTimeFormat.format(t);

  static String previousWeek(DateTime w) {
    return apiDayFormat(w.subtract(new Duration(days: 6)));
  }

  ///get date of next day
  static DateTime nextDay(DateTime w) {
    return w.add(new Duration(days: 1));
  }

  ///given a list of datetime in that week
  static List<DateTime> daysInWeek(DateTime week) {
    final first = _firstDayOfWeek(week);
    final last = _lastDayOfWeek(week);

    final days = Utils.daysInRange(first, last);
    return days.map((day) => DateTime(day.year, day.month, day.day)).toList();
  }

  static DateTime _firstDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final decreaseNum = day.weekday - 1;
    return day.subtract(Duration(days: decreaseNum));
  }

  static DateTime _lastDayOfWeek(DateTime day) {
    day = DateTime.utc(day.year, day.month, day.day, 12);

    final increaseNum = day.weekday - 1;
    return day.add(Duration(days: 7 - increaseNum));
  }

  static bool isExtraDay(DateTime day, DateTime now) {
    return _isExtraDayBefore(day, now) || _isExtraDayAfter(day, now);
  }

  static bool _isExtraDayBefore(DateTime day, DateTime now) {
    return day.month < now.month;
  }

  static bool _isExtraDayAfter(DateTime day, DateTime now) {
    return day.month > now.month;
  }

  /// 周一开始
  static List<DateTime> daysInMonth(DateTime month) {
    final first = Utils.firstDayOfMonth(month);
    final daysBefore = first.weekday - 1;
    var firstToDisplay = first.subtract(Duration(days: daysBefore));

    if (firstToDisplay.hour == 23) {
      firstToDisplay = firstToDisplay.add(Duration(hours: 1));
    }

    var last = Utils.lastDayOfMonth(month);

    if (last.hour == 23) {
      last = last.add(Duration(hours: 1));
    }

    var daysAfter = 7 - last.weekday;

    daysAfter++;

    var lastToDisplay = last.add(Duration(days: daysAfter));

    if (lastToDisplay.hour == 1) {
      lastToDisplay = lastToDisplay.subtract(Duration(hours: 1));
    }

    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }
}
