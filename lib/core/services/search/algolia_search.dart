import 'package:algolia/algolia.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/core/services/search/i_search_service.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';

class AlgoliaSearch extends ISearchService {
  static final Algolia _algolia = Algolia.init(
          applicationId: AlgoliaContants.appId,
          apiKey: AlgoliaContants.searchApiKey)
      .instance;

  static Future<AlgoliaQuerySnapshot> _query(
    String keyword,
  ) async {
    var query = _algolia
        .index(AlgoliaContants.indexName)
        .search(keyword)
        .setHighlightPreTag("**")
        .setHighlightPostTag("**")
        .setHitsPerPage(5);

    var snap = await query.getObjects();
    return snap;
  }

  @override
  Future<List<PlaceSearchResult>> search(String text, {int page = 1}) async {
    var snapshot = await _query(text);

    List<PlaceSearchResult> data = [];
    snapshot.hits.forEach((result) {
      data.add(PlaceSearchResult.fromJson(
          result.objectID, result.data, result.highlightResult));
    });

    return data;
  }
}
