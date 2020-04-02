import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/search/i_search_service.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class SearchResultProvider extends BaseChangeNotifier {
  final ISearchService _service;

  static const int _HISTORYMAXCOUNT = 5;

  bool showResult = false;

  SearchResultProvider({@required ISearchService service}) : _service = service;

  var _result = [];

  List<PlaceSearchResult> get result => [..._result];

  var _suggestions = [];

  List<PlaceSearchResult> get suggestions => [..._suggestions];

  List<String> _history = [];

  List<String> get history => [..._history];

  Future search(String text, int page, {Locale locale}) async {
    _saveHistory(text);
    var data = await _service.search(text, page);
    if (data != null) {
      _result = data;
      showResult = true;
    }
    setStateType(StateType.goods);
  }

  Future getSuggestions(String value) async {
    _service
        .search(value, 1)
        .then((value) => _suggestions = value)
        .whenComplete(() => this.notifyListeners());
  }

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
    showResult = false;
    _loadHistory();
    notifyListeners();
  }
}
