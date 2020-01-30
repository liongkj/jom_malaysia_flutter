// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedPlaceModel _$FeaturedPlaceModelFromJson(Map<String, dynamic> json) {
  return FeaturedPlaceModel(
    json['listingId'] as String,
    json['merchant'] == null
        ? null
        : MerchantVM.fromJson(json['merchant'] as Map<String, dynamic>),
    json['listingName'] as String,
    json['description'] == null
        ? null
        : DescriptionVM.fromJson(json['description'] as Map<String, dynamic>),
    _$enumDecodeNullable(_$CategoryTypeEnumMap, json['categoryType']),
    json['address'] == null
        ? null
        : AddressVM.fromJson(json['address'] as Map<String, dynamic>),
    (json['operatingHours'] as List)
        ?.map((e) => e == null
            ? null
            : OperatingHours.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['category'] == null
        ? null
        : CategoryPathModel.fromJson(json['category'] as Map<String, dynamic>),
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    json['listingImages'] == null
        ? null
        : ListingImageVM.fromJson(
            json['listingImages'] as Map<String, dynamic>),
  )
    ..isFeatured = json['isFeatured'] as bool
    ..officialContact = json['officialContact'] == null
        ? null
        : ContactVM.fromJson(json['officialContact'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FeaturedPlaceModelToJson(FeaturedPlaceModel instance) =>
    <String, dynamic>{
      'listingId': instance.listingId,
      'merchant': instance.merchant,
      'listingName': instance.listingName,
      'isFeatured': instance.isFeatured,
      'tags': instance.tags,
      'listingImages': instance.listingImages,
      'officialContact': instance.officialContact,
      'description': instance.description,
      'address': instance.address,
      'operatingHours': instance.operatingHours,
      'category': instance.category,
      'categoryType': _$CategoryTypeEnumMap[instance.categoryType],
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

const _$CategoryTypeEnumMap = {
  CategoryType.Private: 'Private',
  CategoryType.Attraction: 'Attraction',
  CategoryType.Government: 'Government',
  CategoryType.Professional: 'Professional',
  CategoryType.Nonprofit: 'Nonprofit',
};
