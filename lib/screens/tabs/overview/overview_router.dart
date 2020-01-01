import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_detail_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_search_page.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import 'pages/overview_page.dart';

class OverviewRouter implements IRouterProvider {
  static String overviewPage = "/overview";
  static String placeDetailPage = "/overview/detail";
  static String placeSearchPage = "/overview/search";

  @override
  void initRouter(Router router) {
    router.define(overviewPage,
        handler: Handler(handlerFunc: (_, params) => OverviewPage()));
    router.define('$placeDetailPage/:id',
        handler: Handler(handlerFunc: (_, params) {
      var placeId = params["id"]?.first;
      print("navigate to " + placeId);
      return PlaceDetailPage(placeId: placeId);
    }));
    router.define(placeSearchPage,
        handler: Handler(handlerFunc: (_, params) => PlaceSearchPage()));
  }
}
