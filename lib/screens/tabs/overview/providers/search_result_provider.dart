import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/interfaces/i_search_service.dart';
import 'package:jom_malaysia/setting/provider/base_change_notifier.dart';

class SearchResultProvider extends BaseChangeNotifier {
  final ISearchService _service;
  SearchResultProvider({@required ISearchService service}) : _service = service;

  var _result = [];
  List<dynamic> get result => [..._result];

  Future search(String text, int page, {Locale locale}) async {
    var data = await _service.search(text, page);
    if (data != null) _result = data;
  }
}
