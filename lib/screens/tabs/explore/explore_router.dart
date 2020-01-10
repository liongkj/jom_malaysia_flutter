import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import 'pages/explore_page.dart';

class ExploreRouter implements IRouterProvider {
  static String overviewPage = "/Explore";

  @override
  void initRouter(Router router) {
    router.define(overviewPage,
        handler: Handler(handlerFunc: (_, params) => ExplorePage()));
  }
}
