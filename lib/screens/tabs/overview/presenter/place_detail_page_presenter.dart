import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/api_const.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_detail_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class PlaceDetailPagePresenter extends BasePagePresenter<PlaceDetailPageState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDetail("5df090ab8430e205883f71db");
    });
  }

  Future fetchDetail(String placeId) async {
    asyncRequestNetwork<ListingModel, Null>(Method.get,
        url: APIEndpoint.listings, params: placeId, onSuccess: (data) {
      view.provider.setStateType(StateType.loading);
      if (data != null) {
        view.setPlace(data);
      } else {
        view.provider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      view.provider.setStateType(StateType.network);
    });
  }
}
