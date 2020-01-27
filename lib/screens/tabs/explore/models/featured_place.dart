import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/address_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/contact_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/description_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/viewmodels/category_path_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'featured_place.g.dart';

@JsonSerializable()
class FeaturedPlaceModel {
  FeaturedPlaceModel(
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
  bool isFeatured;
  List<String> tags;
  ListingImageVM listingImages;
  ContactVM officialContact;
  DescriptionVM description;
  AddressVM address;

  List<OperatingHours> operatingHours;
  CategoryPathModel category;
  CategoryType categoryType;

  factory FeaturedPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$FeaturedPlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeaturedPlaceModelToJson(this);
}
