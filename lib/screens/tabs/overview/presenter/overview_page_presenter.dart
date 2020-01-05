import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchListingByType(CategoryType.Private);
    });
  }

  void onPageChange(int index) {
    final type = CategoryType.values[index];
    fetchListingByType(type);
  }

  Future fetchListingByType(CategoryType type, {bool refresh = false}) async {
    final String listingType = type.toString().split('.').last;
    final Options options = new Options(extra: {"refresh": refresh});
    view.listingProvider.setStateType(StateType.loading);
    asyncRequestNetwork<List<ListingModel>, ListingModel>(Method.get,
        url: APIEndpoint.listingQuery,
        options: options,
        queryParameters: {QueryParam.listingType: listingType},
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
