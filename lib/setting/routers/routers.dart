import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/screens/tabs/explore/explore_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/layout/home_page.dart';
import 'package:jom_malaysia/setting/layout/webview_native_page.dart';
import './404.dart';
import 'router_init.dart';

class Routes {
  static String home = "/home";
  static String webViewPage = "/webview";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint("route not found");
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    Home()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebviewNativePage(title: title, url: url);
    }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(OverviewRouter());
    _listRouter.add(ExploreRouter());
    _listRouter.add(LoginRouter());
    _listRouter.add(AccountRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
