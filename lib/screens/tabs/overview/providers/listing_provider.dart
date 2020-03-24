import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class ListingProvider extends BaseChangeNotifier {
  HttpService _httpService;
  ListingProvider({@required HttpService httpService})
      : _httpService = httpService;

  List<ListingModel> _listing = [];
  List<ListingModel> get listing {
    return [..._listing];
  }

  List<ListingModel> fetchListingByType(int index) {
    var cat = CategoryType.values[index];
    var list = _listing.where((x) => x.categoryType == cat).toList();

    // notifyListeners();
    return list;
  }

  void clear() {
    _listing.clear();
    notifyListeners();
  }

  Future<void> fetchAndInitPlaces({
    String city,
    bool refresh = false,
  }) async {
    // setStateType(StateType.loading);
    final Options options =
        buildCacheOptions(Duration(days: 7), forceRefresh: refresh);
    clear();

    //queries
    Map<String, dynamic> queries = Map<String, dynamic>();
    if (city != "") queries[QueryParam.locationBiasCity] = city;
    try {
      var result = await _httpService
          .asyncRequestNetwork<List<ListingModel>, ListingModel>(
        Method.get,
        url: APIEndpoint.listingQuery,
        options: options,
        queryParameters: queries,
        isShow: false,
      );
      if (result != null) {
        if (result.length > 0) {
          _listing = result;
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
    } on Exception catch (e) {
      setStateType(StateType.network);
    }
  }

  ListingModel findById(String placeId) {
    return _listing.firstWhere((x) => x.listingId == placeId) ?? null;
  }
}
