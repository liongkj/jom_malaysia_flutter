import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/account/page/account_manager_page.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';
import './page/about_page.dart';
import './page/setting_page.dart';
import './page/theme_page.dart';

class AccountRouter implements IRouterProvider {
  static String settingPage = "/account";
  static String aboutPage = "/account/about";
  static String themePage = "/account/theme";
  static String accountManagerPage = "/setting/accountManager";

  @override
  void initRouter(Router router) {
    router.define(settingPage,
        handler: Handler(handlerFunc: (_, params) => SettingPage()));
    router.define(aboutPage,
        handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(themePage,
        handler: Handler(handlerFunc: (_, params) => ThemePage()));
    router.define(accountManagerPage,
        handler: Handler(handlerFunc: (_, params) => AccountManagerPage()));
  }
}
