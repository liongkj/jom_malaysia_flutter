import 'package:jom_malaysia/core/models/ads_model.dart';
import 'package:jom_malaysia/core/services/gateway/exception/parse_error_exception.dart';
import 'package:jom_malaysia/core/services/image/cloudinary/cloudinary_upload_response.dart';
import 'package:jom_malaysia/screens/tabs/explore/models/featured_place.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';

import 'api_response.dart';

class JsonParser {
  // If T is a List, K is the subtype of the list.

  static T fromJson<T, K>(Map json) {
    final dynamic data = ApiResponse.fromJson(json).data;
    if (data is Iterable) {
      return _fromJsonList<K>(data) as T;
    }
    if (K == Null) return fromJson<T, T>(data);
    if (T == CategoryModel) {
      return CategoryModel.fromJson(json) as T;
    }
    if (T == ListingModel) {
      return ListingModel.fromJson(json) as T;
    }
    if (T == FeaturedPlaceModel) {
      return FeaturedPlaceModel.fromJson(json) as T;
    }
    if (T == AdsModel) {
      return AdsModel.fromJson(json) as T;
    }
    if (T == CloudinaryUploadResponse) {
      return CloudinaryUploadResponse.fromJson(json) as T;
    }

    throw ParseErrorException(status: "Error parsing" + T.toString());
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }

    return output;
  }
}
