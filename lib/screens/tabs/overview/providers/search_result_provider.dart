import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/search/algolia_search.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';

class SearchResultProvider extends BaseChangeNotifier {
  var _result = [];
  List<dynamic> get result => _result;

  Future search(String text, int page, {Locale locale}) async {
    var snapshot = await AlgoliaSearch.query(text);
    List<PlaceSearchResult> data = [];
    snapshot.hits
        .forEach((result) => data.add(PlaceSearchResult.fromJson(result.data)));
  }
}
