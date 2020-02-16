import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/account/page/account_manager_page.dart';
import 'package:jom_malaysia/screens/tabs/account/page/language_page.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import './page/about_page.dart';
import './page/setting_page.dart';

class AccountRouter implements IRouterProvider {
  static String settingPage = "/account";
  static String aboutPage = "/account/about";
  static String languagePage = "/account/language";
  static String accountManagerPage = "/setting/accountManager";

  @override
  void initRouter(Router router) {
    router.define(settingPage,
        handler: Handler(handlerFunc: (_, params) => SettingPage()));
    router.define(aboutPage,
        handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(languagePage,
        handler: Handler(handlerFunc: (_, params) => LanguagePage()));
    router.define(accountManagerPage,
        handler: Handler(handlerFunc: (_, params) => AccountManagerPage()));
  }
}
