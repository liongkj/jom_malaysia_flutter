import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/explore/models/featured_place.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class FeaturedPlaceProvider extends BaseChangeNotifier {
  HttpService _httpService;
  FeaturedPlaceProvider({@required HttpService httpService})
      : _httpService = httpService;

  List<FeaturedPlaceModel> _featured = [];
  List<FeaturedPlaceModel> get featured {
    return [..._featured];
  }

  Future<void> fetchFeaturedListing({
    bool refresh = false,
  }) async {
    final Options options =
        buildCacheOptions(Duration(days: 7), forceRefresh: refresh);
    //queries
    Map<String, dynamic> queries = Map<String, dynamic>();
    queries[QueryParam.featured] = true;
    print("fetched");
    _featured.clear();
    // setStateType(StateType.loading);
    _httpService
        .asyncRequestNetwork<List<FeaturedPlaceModel>, FeaturedPlaceModel>(
      Method.get,
      url: APIEndpoint.listingQuery,
      options: options,
      queryParameters: queries,
      isShow: false,
      onSuccess: (data) {
        if (data != null) {
          if (data.length > 0) {
            _featured.addAll(data);
            setStateTypeWithoutNotify(StateType.places);
            notifyListeners();
            return;
          } else {
            setStateType(StateType.places);
            return;
          }
        } else {
          setStateType(StateType.network);
          return;
        }
      },
    );
  }
}
