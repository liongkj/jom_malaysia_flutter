import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/explore/models/featured_place.dart';
import 'package:jom_malaysia/screens/tabs/explore/pages/todo_tab.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class FeaturedPagePresenter extends BasePagePresenter<TodoTabState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        fetchFeaturedListing();
      },
    );
  }

  Future fetchFeaturedListing({
    bool refresh = false,
  }) async {
    final Options options =
        buildCacheOptions(Duration(days: 7), forceRefresh: refresh);
    view.provider.setStateType(StateType.loading);
    asyncRequestNetwork<List<FeaturedPlaceModel>, FeaturedPlaceModel>(
        Method.get,
        url: APIEndpoint.listingQuery,
        options: options,
        queryParameters: {
          QueryParam.featured: true,
        },
        isShow: false, onSuccess: (data) {
      view.provider.clear();

      if (data != null) {
        view.provider.setHasMore(false);
        if (data.length > 0) {
          view.provider.addAll(data);
        } else {
          view.provider.setStateType(StateType.places);
        }
      } else {
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      view.provider.setHasMore(false);
      view.provider.setStateType(StateType.network);
    });
  }

  void refresh() {
    fetchFeaturedListing(
      refresh: true,
    );
  }
}
