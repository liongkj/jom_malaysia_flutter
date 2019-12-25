import 'package:fluro/fluro.dart';

import '../setting/routers/router_init.dart';
import 'tabs/overview/pages/place_detail_page.dart';

class PlaceDetailRouter implements IRouterProvider {
  static String placeDetailPage = "/overview/detail";

  @override
  void initRouter(Router router) {

    router.define(placeDetailPage,
        handler:Handler(handlerFunc: (_,params) => PlaceDetailPage()));
  }
}