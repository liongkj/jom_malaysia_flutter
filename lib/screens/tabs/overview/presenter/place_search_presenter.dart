import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/dio_utils.dart';
import 'package:jom_malaysia/core/services/gateway/json_parser.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/core/services/search/algolia_search.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_search_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class PlaceSearchPresenter extends BasePagePresenter<PlaceSearchPageState> {
  Future search(String text, int page, bool isShowDialog,
      {Locale locale}) async {
    final Options options = new Options(extra: {"refresh": true});

    var snapshot = await AlgoliaSearch.query(text);
    List<PlaceSearchResult> data = [];
    snapshot.hits
        .forEach((result) => data.add(PlaceSearchResult.fromJson(result.data)));

    // JsonParser.fromJson<List<ListingModel>, ListingModel>(results);
    view.provider.clear();
  }
}
