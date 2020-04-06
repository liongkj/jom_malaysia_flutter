import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/ads_model.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';

class AdsService {
  HttpService _httpService;

  AdsService({@required HttpService httpService}) : _httpService = httpService;

  Future<List<AdsModel>> fetchAndInitAds({
    bool refresh = true,
  }) async {
    List<AdsModel> data;
    final Options options = buildCacheOptions(Duration(days: 7),
        forceRefresh: refresh,
        options: new RequestOptions(baseUrl: APIEndpoint.getAdsRequest));
    try {
      data = await _httpService.asyncRequestNetwork<List<AdsModel>, AdsModel>(
        Method.get,
        url: "",
        options: options,
        isShow: false,
      );
    } on Exception {
      return null;
    }
    return data;
  }
}
