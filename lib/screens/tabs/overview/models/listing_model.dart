import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/enums/day_of_week_enum.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';
import 'contact_model.dart';
import 'operating_hours_model.dart';

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
  ContactVM officialContact;

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
class MerchantVM {
  MerchantVM(this.merchantId, this.ssmId, this.registrationName);
  String merchantId;
  String ssmId;
  String registrationName;

  factory MerchantVM.fromJson(Map<String, dynamic> json) =>
      _$MerchantVMFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantVMToJson(this);
}
