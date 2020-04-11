import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/search/i_search_service.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

enum ResultType { search, history, suggestion }

class SearchResultProvider extends BaseChangeNotifier {
  final ISearchService _service;

  static const int _HISTORYMAXCOUNT = 5;

  ResultType resultType = ResultType.history;

  SearchResultProvider({@required ISearchService service}) : _service = service;

  var _result = [];

  List<PlaceSearchResult> get result => [..._result];

  List<PlaceSearchResult> _suggestions = [];

  List<PlaceSearchResult> get suggestions => [..._suggestions];

  Future search(String text, int page) async {
    _result.clear();
    setStateType(StateType.loading);
    _saveHistory(text);
    var data = await _service.search(text, page: page);
    if (data != null) {
      _result = data;
      resultType = ResultType.search;
    }
    setStateType(StateType.result);
  }

  Future getSuggestions(String value) async {
//    _service
//        .search(value, page: 1)
//        .then((value) => _suggestions = value)
//        .whenComplete(() {
//      resultType = ResultType.suggestion;
//      setStateType(StateType.result);
//    });
    ////TODO remove suggestion for now, looks same as search result
  }

  List<String> _history = [];

  List<String> get history => [..._history];

  void _saveHistory(String text) {
    if (!_history.contains(text)) {
      _history.insert(0, text);
      if (_history.length > _HISTORYMAXCOUNT) _history.removeLast();
      SpUtil.putStringList(Constant.historySearch, _history);
    }
  }

  void _loadHistory() {
    _history = SpUtil.getStringList(Constant.historySearch);
  }

  void clearOldResult() {
    _result.clear();
    resultType = ResultType.history;

    _loadHistory();
    setStateType(StateType.result);
  }

  void removeHistoryAt(int index) {
    _history.removeAt(index);
    SpUtil.putStringList(Constant.historySearch, _history);
    notifyListeners();
  }
}
