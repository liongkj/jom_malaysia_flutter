import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchListings(CategoryType.Private, 1);
    });
  }

  Future fetchListings(CategoryType type, int page) async {
    String listingType = type.toString().split('.').last;
    asyncRequestNetwork<List<ListingModel>, ListingModel>(Method.get,
        url: APIEndpoint.listingQuery,
        queryParameters: {QueryParam.listingType: listingType}, onSuccess: (data) {
      if (data != null) {
        view.listingProvider.setHasMore(false);
        view.listingProvider.addAll(data);
      } else {
        view.listingProvider.setHasMore(false);
        view.listingProvider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      view.listingProvider.setHasMore(false);
      view.listingProvider.setStateType(StateType.empty);
    });
  }
}
