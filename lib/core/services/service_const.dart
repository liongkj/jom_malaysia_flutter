///endpoint for all api
class APIEndpoint {
  static const String categories = 'categories';
  static const String listings = 'listings';
  static const String listingQuery = 'listings/query';
  static const String listingSearch = 'listings/search';
  static const String getAdsRequest =
      "https://jomn9-ads.easybrother.workers.dev/";
}

///type of query parameters for api/search
class QueryParam {
  static const String listingType = 'type';
  static const String listingStatus = 'status';

  static const String locationBiasCity = 'selectedCity';
  static const String keyword = 'q';
  static const String language = 'lang';
  static const String featured = 'featured';
}

///endpoint for webview pages
class WebUrl {
  static const String _home = "https://www.jomn9.com";
  static const String reportPlaceError = "$_home/report-error/";

  static const String suggestAddPlace = "$_home/add-a-place/";

  static const String feedback = "$_home/feedback/";
}

class CloudinaryEndPoint {
  static const String upload =
      "https://api.cloudinary.com/v1_1/jomn9-com/image/upload";
}

class AlgoliaContants {
  static const String appId = "0CUJG6GNL8";
  static const String searchApiKey = "f5aff3f0495cfbf8577f0359b08ba2b4";

  static const String indexName = "prod_jomn9";
}
