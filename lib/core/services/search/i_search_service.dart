import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';

abstract class ISearchService {
  Future<List<PlaceSearchResult>> search(String text,
      {int page, Locale locale});
}
