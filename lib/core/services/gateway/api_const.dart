class APIEndpoint {
  static const String categories = 'categories';
  static const String listings = 'listings';
  static const String listingQuery = 'listings/query';
  static const String listingSearch = 'listings/search';
  static const String getAdsRequest =
      "https://jomn9-ads.easybrother.workers.dev/";
}

class CloudinaryEndPoint {
  static const String upload =
      "https://api.cloudinary.com/v1_1/jom-n9/image/upload";
}

class QueryParam {
  static const String listingType = 'type';
  static const String listingStatus = 'status';

  static const String locationBiasCity = 'selectedCity';
  static const String keyword = 'q';
  static const String language = 'lang';
  static const String featured = 'featured';
}

class WebUrl {
  static const String home = "https://www.jomn9.com";
  static const String reportPlaceError = "$home/report-error/";

  static const String suggestAddPlace = "$home/add-a-place/";
}
