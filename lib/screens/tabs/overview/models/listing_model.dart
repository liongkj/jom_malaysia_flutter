import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/models/image_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/description_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/viewmodels/category_path_model.dart';
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
  DescriptionVM description;
  AddressVM address;

  List<OperatingHours> operatingHours;
  CategoryPathModel category;
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

  List<String> get getCarousel {
    var _images = [coverPhoto.url];
    _images.addAll(ads.map((x) => x.url).toList());
    return _images;
  }

  factory ListingImageVM.fromJson(Map<String, dynamic> json) =>
      _$ListingImageVMFromJson(json);

  Map<String, dynamic> toJson() => _$ListingImageVMToJson(this);
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
