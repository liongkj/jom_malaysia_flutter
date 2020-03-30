import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/search/i_search_service.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class SearchResultProvider extends BaseChangeNotifier {
  final ISearchService _service;
  SearchResultProvider({@required ISearchService service}) : _service = service;

  var _result = [];
  List<PlaceSearchResult> get result => [..._result];

  Future search(String text, int page, {Locale locale}) async {
    var data = await _service.search(text, page);
    if (data != null) {
      _result = data;
      notifyListeners();
    } else
      setStateType(StateType.empty);
  }
}
