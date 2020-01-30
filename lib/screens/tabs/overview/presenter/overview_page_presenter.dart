import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        fetchListingByType(
          CategoryType.Private,
        );
      },
    );
  }

  void onPageChange(int index) {
    final type = CategoryType.values[index];
    fetchListingByType(type);
  }

  Future fetchListingByType(
    CategoryType type, {
    bool refresh = false,
  }) async {
    final String cityFilter =
        Provider.of<LocationProvider>(view.context, listen: false).selected;
    print(cityFilter);
    final String listingType = type.toString().split('.').last;
    final Options options =
        buildCacheOptions(Duration(days: 7), forceRefresh: refresh);
    //queries
    Map<String, dynamic> queries = Map<String, dynamic>();
    if (listingType != "" || listingType != null)
      queries[QueryParam.listingType] = listingType;
    if (cityFilter != "" || cityFilter != null)
      queries[QueryParam.locationBiasCity] = cityFilter;

    view.listingProvider.setStateType(StateType.loading);
    asyncRequestNetwork<List<ListingModel>, ListingModel>(Method.get,
        url: APIEndpoint.listingQuery,
        options: options,
        queryParameters: queries,
        isShow: false, onSuccess: (data) {
      view.listingProvider.clear();

      if (data != null) {
        view.listingProvider.setHasMore(false);
        if (data.length > 0) {
          view.listingProvider.addAll(data);
        } else {
          view.listingProvider.setStateType(StateType.places);
        }
      } else {
        view.listingProvider.setHasMore(false);
        view.listingProvider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      view.listingProvider.setHasMore(false);
      view.listingProvider.setStateType(StateType.network);
    });
  }

  void refresh(int index) {
    fetchListingByType(
      CategoryType.values[index],
      refresh: true,
    );
  }
}
