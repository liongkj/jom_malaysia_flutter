// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListingModel _$ListingModelFromJson(Map<String, dynamic> json) {
  return ListingModel(
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
  )..officialContact = json['officialContact'] == null
      ? null
      : ContactVM.fromJson(json['officialContact'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ListingModelToJson(ListingModel instance) =>
    <String, dynamic>{
      'listingId': instance.listingId,
      'merchant': instance.merchant,
      'listingName': instance.listingName,
      'description': instance.description,
      'address': instance.address,
      'operatingHours': instance.operatingHours,
      'category': instance.category,
      'categoryType': _$CategoryTypeEnumMap[instance.categoryType],
      'tags': instance.tags,
      'listingImages': instance.listingImages,
      'officialContact': instance.officialContact,
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

ListingImageVM _$ListingImageVMFromJson(Map<String, dynamic> json) {
  return ListingImageVM(
    listingLogo: json['listingLogo'] == null
        ? null
        : ImageModel.fromJson(json['listingLogo'] as Map<String, dynamic>),
    coverPhoto: json['coverPhoto'] == null
        ? null
        : ImageModel.fromJson(json['coverPhoto'] as Map<String, dynamic>),
    ads: (json['ads'] as List)
        ?.map((e) =>
            e == null ? null : ImageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListingImageVMToJson(ListingImageVM instance) =>
    <String, dynamic>{
      'listingLogo': instance.listingLogo,
      'coverPhoto': instance.coverPhoto,
      'ads': instance.ads,
    };

MerchantVM _$MerchantVMFromJson(Map<String, dynamic> json) {
  return MerchantVM(
    json['merchantId'] as String,
    json['ssmId'] as String,
    json['registrationName'] as String,
  );
}

Map<String, dynamic> _$MerchantVMToJson(MerchantVM instance) =>
    <String, dynamic>{
      'merchantId': instance.merchantId,
      'ssmId': instance.ssmId,
      'registrationName': instance.registrationName,
    };
