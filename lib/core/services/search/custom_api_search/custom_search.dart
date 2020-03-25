import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/interfaces/i_search_service.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';

class CustomSearch extends ISearchService {
  HttpService _httpService;
  CustomSearch({@required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<List<PlaceSearchResult>> search(String text, int page,
      {Locale locale}) async {
    final Options options = new Options(extra: {"refresh": true});
    try {
      var result = await _httpService
          .asyncRequestNetwork<List<ListingModel>, ListingModel>(Method.get,
              url: APIEndpoint.listingSearch,
              options: options,
              queryParameters: {
            QueryParam.keyword: text,
            QueryParam.language: "en",
            // locale.languageCode,
          });
    } on Exception catch (e) {}
  }
}
