// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'highlight_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HighLightResultsModel _$HighLightResultsModelFromJson(
    Map<String, dynamic> json) {
  return HighLightResultsModel(
    json['value'] as String,
    _$enumDecodeNullable(_$QueryMatchedLevelEnumMap, json['matchLevel']),
    (json['matchedWords'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$HighLightResultsModelToJson(
        HighLightResultsModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'matchLevel': _$QueryMatchedLevelEnumMap[instance.matchLevel],
      'matchedWords': instance.matchedWords,
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

const _$QueryMatchedLevelEnumMap = {
  QueryMatchedLevel.none: 'none',
  QueryMatchedLevel.full: 'full',
};
