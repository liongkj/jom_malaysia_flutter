import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';
import './page/about_page.dart';
import './page/setting_page.dart';
import './page/theme_page.dart';

class SettingRouter implements IRouterProvider {
  static String settingPage = "/setting";
  static String aboutPage = "/setting/about";
  static String themePage = "/setting/theme";

  @override
  void initRouter(Router router) {
    router.define(settingPage,
        handler: Handler(handlerFunc: (_, params) => SettingPage()));
    router.define(aboutPage,
        handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(themePage,
        handler: Handler(handlerFunc: (_, params) => ThemePage()));
  }
}
