class APIEndpoint {
  static const String categories = 'categories';
  static const String listings = 'listings';
  static const String listingQuery = 'listings/query';
  static const String listingSearch = 'listings/search';
}

class QueryParam {
  static const String listingType = 'type';
  static const String listingStatus = 'status';

  static const String locationBiasCity = 'selectedCity';
  static const String keyword = 'q';
  static const String language = 'lang';
  static const String featured = 'featured';
}
