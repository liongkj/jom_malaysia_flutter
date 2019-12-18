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
    json['description'] as String,
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
        : CategoryVM.fromJson(json['category'] as Map<String, dynamic>),
    (json['tags'] as List)?.map((e) => e as String)?.toList(),
    json['listingImages'] == null
        ? null
        : ListingImageVM.fromJson(
            json['listingImages'] as Map<String, dynamic>),
  );
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
  CategoryType.Professional: 'Professional',
  CategoryType.Government: 'Government',
  CategoryType.Private: 'Private',
  CategoryType.Nonprofit: 'Nonprofit',
  CategoryType.Attraction: 'Attraction',
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

CategoryVM _$CategoryVMFromJson(Map<String, dynamic> json) {
  return CategoryVM(
    categoryId: json['categoryId'] as String,
    category: json['category'] as String,
    subcategory: json['subcategory'] as String,
  );
}

Map<String, dynamic> _$CategoryVMToJson(CategoryVM instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'category': instance.category,
      'subcategory': instance.subcategory,
    };

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

const _$DayOfWeekEnumMap = {
  DayOfWeek.Sunday: 'Sunday',
  DayOfWeek.Monday: 'Monday',
  DayOfWeek.Tuesday: 'Tuesday',
  DayOfWeek.Wednesday: 'Wednesday',
  DayOfWeek.Thursday: 'Thursday',
  DayOfWeek.Friday: 'Friday',
  DayOfWeek.Saturday: 'Saturday',
};

AddressVM _$AddressVMFromJson(Map<String, dynamic> json) {
  return AddressVM(
    add1: json['add1'] as String,
    add2: json['add2'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    postalCode: json['postalCode'] as String,
    coordinates: json['coordinates'] == null
        ? null
        : CoordinatesModel.fromJson(
            json['coordinates'] as Map<String, dynamic>),
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$AddressVMToJson(AddressVM instance) => <String, dynamic>{
      'add1': instance.add1,
      'add2': instance.add2,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
      'coordinates': instance.coordinates,
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
