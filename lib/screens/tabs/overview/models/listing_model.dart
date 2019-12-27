import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/enums/day_of_week_enum.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/util/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sprintf/sprintf.dart';

part 'listing_model.g.dart';

@JsonSerializable()
class ListingModel {
  ListingModel(
    this.listingId,
    this.merchant,
    this.listingName,
    this.description,
    this.categoryType,
    this.address,
    this.operatingHours,
    this.category,
    this.tags,
    this.listingImages,
  );
  String listingId;
  MerchantVM merchant;
  String listingName;
  String description;
  AddressVM address;

  List<OperatingHours> operatingHours;
  CategoryVM category;
  CategoryType categoryType;
  List<String> tags;
  ListingImageVM listingImages;

  factory ListingModel.fromJson(Map<String, dynamic> json) =>
      _$ListingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListingModelToJson(this);
}

@JsonSerializable()
class ListingImageVM {
  ListingImageVM({this.listingLogo, this.coverPhoto, this.ads});
  ImageModel listingLogo;
  ImageModel coverPhoto;
  List<ImageModel> ads;

  factory ListingImageVM.fromJson(Map<String, dynamic> json) =>
      _$ListingImageVMFromJson(json);

  Map<String, dynamic> toJson() => _$ListingImageVMToJson(this);
}

@JsonSerializable()
class CategoryVM {
  CategoryVM(
      {@required this.categoryId, @required this.category, this.subcategory});
  String categoryId;
  String category;
  String subcategory;

  factory CategoryVM.fromJson(Map<String, dynamic> json) =>
      _$CategoryVMFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryVMToJson(this);

  String getCategory() {
    if (category.length == 0) {
      return category.toUpperCase();
    }
    return category[0].toUpperCase() + category.substring(1);
  }

  @override
  String toString() {
    return "$category ${subcategory ?? subcategory}";
  }
}

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

@JsonSerializable()
class AddressVM {
  AddressVM(
      {@required this.add1,
      this.add2,
      @required this.city,
      @required this.state,
      @required this.postalCode,
      @required this.coordinates,
      @required this.country});
  String add1;
  String add2;
  String city;
  String state;
  String postalCode;
  String country;
  CoordinatesModel coordinates;

  factory AddressVM.fromJson(Map<String, dynamic> json) =>
      _$AddressVMFromJson(json);

  Map<String, dynamic> toJson() => _$AddressVMToJson(this);
}

@JsonSerializable()
class MerchantVM {
  MerchantVM(this.merchantId, this.ssmId, this.registrationName);
  String merchantId;
  String ssmId;
  String registrationName;

  factory MerchantVM.fromJson(Map<String, dynamic> json) =>
      _$MerchantVMFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantVMToJson(this);
}
