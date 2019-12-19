import 'address_model.dart';
import 'category_model.dart';
import 'listingImages_model.dart';
import 'merchant_model.dart';
import 'operating_hours_list_model.dart';
import 'tags_model.dart';

class PlaceDetails {
  final String listingId;
  Merchant merchant;
  final String listingName;
  final String description;
  Address address;
  OperatingHours operatingHours;
  Category category;
  final int categoryType;
  //Tags tags;
  // ListingImages listingImages;

  PlaceDetails(this.listingId, this.merchant,this.listingName,this.description,this.address,this.operatingHours,this.category,this.categoryType);

  PlaceDetails.fromJson(Map<String, dynamic> json)
      : listingId = json['listingId'],
       merchant = Merchant.fromJson(json['merchant']),
       listingName = json['listingName'],
       description = json['description'],
       address = Address.fromJson(json['address']),
       operatingHours = OperatingHours.fromJson(json['operatingHours'][0]),
       category = Category.fromJson(json['category']),
       categoryType = json['categoryType'];
       //tags = Tags.fromJson(json['tags']);
}
