import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/api_const.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_detail_page.dart';

class PlaceDetailPagePresenter extends BasePagePresenter<PlaceDetailPageState> {
  @override
  void initState() {}

  Future fetchDetail(String placeId) async {
    asyncRequestNetwork<ListingModel, Null>(Method.get,
        url: APIEndpoint.listings, params: placeId, onSuccess: (data) {
      if (data != null) {
        view.provider.setPlace(data);
      } else {
        // view.provider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      // view.provider.setHasMore(false);
      // view.provider.setStateType(StateType.network);
    });
  }
}
