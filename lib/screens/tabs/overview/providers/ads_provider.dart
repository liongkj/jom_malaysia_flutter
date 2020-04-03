import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/models/ads_model.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class AdsProvider extends BaseChangeNotifier {
  HttpService _httpService;

  AdsProvider({@required HttpService httpService}) : _httpService = httpService;

  List<AdsModel> _adList = [];

  List<AdsModel> get adList {
    return [..._adList];
  }

  Future<void> fetchAndInitAds({
    bool refresh = true,
  }) async {
    final Options options = buildCacheOptions(Duration(days: 7),
        forceRefresh: refresh,
        options: new RequestOptions(baseUrl: APIEndpoint.getAdsRequest));
    //change base url by adding new request option
    Map<String, dynamic> queries = Map<String, dynamic>();
    try {
      var data =
          await _httpService.asyncRequestNetwork<List<AdsModel>, AdsModel>(
        Method.get,
        url: "",
        options: options,
        queryParameters: queries,
        isShow: false,
      );
      if (data != null) {
        if (data.length > 0) {
          _adList = data;
          notifyListeners();
          return;
        } else {
          setStateType(StateType.empty);
          return;
        }
      } else {
        setStateType(StateType.empty);
        return;
      }
    } on Exception {
      setStateType(StateType.network);
    }
  }
}
