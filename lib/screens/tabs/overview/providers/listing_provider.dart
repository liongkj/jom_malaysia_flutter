import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/services/gateway/api_const.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class ListingProvider with ChangeNotifier {
  HttpService _httpService;
  ListingProvider({@required HttpService httpService})
      : _httpService = httpService;

  StateType _stateType = StateType.loading;

  StateType get stateType => _stateType;
  void setStateType(StateType value) {
    _stateType = value;
    notifyListeners();
  }

  List<ListingModel> _listing = [];
  List<ListingModel> get listing {
    return [..._listing];
  }

  List<ListingModel> fetchListingByType(int index) {
    var cat = CategoryType.values[index];
    var list = _listing.where((x) => x.categoryType == cat).toList();
    // if (list.isEmpty) setStateType(StateType.places);
    // notifyListeners();
    return list;
  }

  Future<void> fetchAndInitPlaces({
    String city,
    bool refresh = false,
  }) async {
    setStateType(StateType.loading);
    if (city != "") print("fetching " + city + " from API");
    final Options options =
        buildCacheOptions(Duration(days: 7), forceRefresh: refresh);
    //queries
    Map<String, dynamic> queries = Map<String, dynamic>();

    if (city != "") queries[QueryParam.locationBiasCity] = city;

    _httpService.asyncRequestNetwork<List<ListingModel>, ListingModel>(
        Method.get,
        url: APIEndpoint.listingQuery,
        options: options,
        queryParameters: queries,
        isShow: false, onSuccess: (data) {
      // view.listingProvider.clear();
      _listing.clear();
      if (data != null) {
        if (data.length > 0) {
          _listing.addAll(data);
          notifyListeners();
        } else {
          setStateType(StateType.places);
        }
      } else {
        // setStateType(StateType.network);

      }
    }, onError: (_, __) {
      setStateType(StateType.network);
      // notifyListeners();
    });
  }

  ListingModel findById(String placeId) {
    return _listing.firstWhere((x) => x.listingId == placeId);
  }
}
