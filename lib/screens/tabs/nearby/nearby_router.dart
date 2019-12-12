import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/nearby/pages/nearby_page.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

class NearbyRouter implements IRouterProvider {
  static String overviewPage = "/nearby";

  @override
  void initRouter(Router router) {
    router.define(overviewPage,
        handler: Handler(handlerFunc: (_, params) => NearbyPage()));
  }
}
