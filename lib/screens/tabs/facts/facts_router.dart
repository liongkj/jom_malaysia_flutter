import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import 'pages/facts_page.dart';

class FactsRouter implements IRouterProvider {
  static String overviewPage = "/facts";

  @override
  void initRouter(Router router) {
    router.define(overviewPage,
        handler: Handler(handlerFunc: (_, params) => FactsPage()));
  }
}
