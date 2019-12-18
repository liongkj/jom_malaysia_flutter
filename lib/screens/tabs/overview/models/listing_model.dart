import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/enums/day_of_week_enum.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:json_annotation/json_annotation.dart';

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

class ListingImageVM {
  ImageModel listingLogo;
  ImageModel coverPhoto;
  List<ImageModel> ads;
}

class CategoryVM {
  String categoryId;
  String category;
  String subcategory;
}

class OperatingHours {
  DayOfWeek dayofWeek;
  TimeOfDayFormat openTime;
  TimeOfDayFormat closeTime;
}

class AddressVM {
  String add1;
  String add2;
  String city;
  String state;
  String portalCode;
  String country;
  CoordinatesModel coordinates;
}

class MerchantVM {
  String merchantId;
  String ssmId;
  String registrationName;
}
