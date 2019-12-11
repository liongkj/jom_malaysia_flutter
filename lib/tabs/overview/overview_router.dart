import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import 'pages/overview_page.dart';

class OverviewRouter implements IRouterProvider {
  static String overViewPage = "/overview";

  @override
  void initRouter(Router router) {
    router.define(overViewPage,
        handler: Handler(handlerFunc: (_, params) => OverviewPage()));
  }
}
