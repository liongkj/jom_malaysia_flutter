// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operating_hours_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatingHours _$OperatingHoursFromJson(Map<String, dynamic> json) {
  return OperatingHours(
    dayofWeek: _$enumDecodeNullable(_$DayOfWeekEnumMap, json['dayofWeek']),
    openTime: json['openTime'] as String,
    closeTime: json['closeTime'] as String,
  );
}

Map<String, dynamic> _$OperatingHoursToJson(OperatingHours instance) =>
    <String, dynamic>{
      'dayofWeek': _$DayOfWeekEnumMap[instance.dayofWeek],
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$DayOfWeekEnumMap = {
  DayOfWeek.Sunday: 'Sunday',
  DayOfWeek.Monday: 'Monday',
  DayOfWeek.Tuesday: 'Tuesday',
  DayOfWeek.Wednesday: 'Wednesday',
  DayOfWeek.Thursday: 'Thursday',
  DayOfWeek.Friday: 'Friday',
  DayOfWeek.Saturday: 'Saturday',
};
