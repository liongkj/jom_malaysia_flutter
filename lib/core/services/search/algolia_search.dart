import 'package:algolia/algolia.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';

class AlgoliaSearch {
  static final Algolia _algolia = Algolia.init(
      applicationId: AlgoliaContants.appId,
      apiKey: AlgoliaContants.searchApiKey);

  Future<AlgoliaQuerySnapshot> query(String keyword) async {
    Future<AlgoliaQuerySnapshot> query = _algolia.instance
        .index(AlgoliaContants.indexName)
        .search(keyword)
        .getObjects();
    return query;
  }
}
