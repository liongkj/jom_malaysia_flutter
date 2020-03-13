import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/new_review_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_detail_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_search_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/comments/comment_list.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import 'pages/overview_page.dart';

class OverviewRouter implements IRouterProvider {
  static String overviewPage = "/overview";
  static String placeDetailPage = "/overview/detail";
  static String placeSearchPage = "/overview/search";
  static String reviewPage = "/overview/place/review";

  static String commentPage = "/overview/place/comment";

  @override
  void initRouter(Router router) {
    router.define(overviewPage,
        handler: Handler(handlerFunc: (_, params) => OverviewPage()));
    router.define('$placeDetailPage/:id',
        handler: Handler(handlerFunc: (_, params) {
      var placeId = params["id"]?.first;
      return PlaceDetailPage(placeId: placeId);
    }));
    router.define(commentPage, handler: Handler(handlerFunc: (_, params) {
      var placeId = params["placeId"]?.first;
      return CommentList(placeId);
    }));
    router.define(reviewPage, handler: Handler(handlerFunc: (_, params) {
      var placeId = params["placeId"]?.first;
      var userId = params["userId"]?.first;
      var title = params["title"]?.first;
      return NewReviewPage(
        placeId: placeId,
        userId: userId,
        placeName: title,
      );
    }));
    router.define(placeSearchPage,
        handler: Handler(handlerFunc: (_, params) => PlaceSearchPage()));
  }
}
