import 'package:jom_malaysia/screens/tabs/overview/models/listingImages_ads_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listingImages_coverphoto.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listingImages_listinglogo_model.dart';
import 'address_model.dart';
import 'category_model.dart';
import 'merchant_model.dart';
import 'operating_hours_list_model.dart';
import 'tags_model.dart';

class PlaceDetails {
  final String listingId;
  Merchant merchant;
  final String listingName;
  final String description;
  Address address;
  OperatingHoursList operatingHours;
  Category category;
  final int categoryType;
  Tags tags;
  //ListingImages
  ListingImageListingLogo listinglogo;
  ListingImageCoverPhoto coverPhoto;
  ListingImagesAds ads;

  PlaceDetails(
      this.listingId,
      this.merchant,
      this.listingName,
      this.description,
      this.address,
      this.operatingHours,
      this.category,
      this.categoryType,
      this.tags,
      this.listinglogo,
      this.coverPhoto,
      this.ads);

  PlaceDetails.fromJson(Map<String, dynamic> json)
      : listingId = json['listingId'],
        merchant = Merchant.fromJson(json['merchant']),
        listingName = json['listingName'],
        description = json['description'],
        address = Address.fromJson(json['address']),
        operatingHours = OperatingHoursList.fromJson(json['operatingHours']),
        category = Category.fromJson(json['category']),
        categoryType = json['categoryType'],
        tags = Tags.fromJson(json['tags']),
        listinglogo = ListingImageListingLogo.fromJson(
            json['listingImages']['listingLogo']),
        coverPhoto = ListingImageCoverPhoto.fromJson(
            json['listingImages']['coverPhoto']),
        ads = ListingImagesAds.fromJson(json['listingImages']['ads']);
}
