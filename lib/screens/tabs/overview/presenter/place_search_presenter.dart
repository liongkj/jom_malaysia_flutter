import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_search_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class PlaceSearchPresenter extends BasePagePresenter<PlaceSearchPageState> {
  Future search(String text, int page, bool isShowDialog,
      {Locale locale}) async {
    final Options options = new Options(extra: {"refresh": true});
    asyncRequestNetwork<List<ListingModel>, ListingModel>(Method.get,
        url: APIEndpoint.listingSearch,
        options: options,
        queryParameters: {
          QueryParam.keyword: text,
          QueryParam.language: "en",
          // locale.languageCode,
        },
        isShow: isShowDialog, onSuccess: (data) {
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
        view.provider.setStateType(StateType.places);
      }
    }, onError: (_, __) {
      view.provider.setHasMore(false);
      view.provider.setStateType(StateType.network);
      view.showToast(__);
    });
  }
}
