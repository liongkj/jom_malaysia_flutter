import 'package:algolia/algolia.dart';

class AlgoliaSearch {
  static final Algolia algolia =
      Algolia.init(applicationId: "APPLICATION_ID", apiKey: null);
}
