import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/account/page/account_manager_page.dart';
import 'package:jom_malaysia/screens/tabs/account/page/language_page.dart';
import 'package:jom_malaysia/setting/layout/webview_native_page.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';
import './page/about_page.dart';
import './page/setting_page.dart';

class AccountRouter implements IRouterProvider {
  static String settingPage = "/account";
  static String aboutPage = "/account/about";
  static String languagePage = "/account/language";
  // static String feedbackPage = "/account/feedback";
  static String accountManagerPage = "/setting/accountManager";
  static String webviewparam = "/nativewebview";
  static String webview = "$webviewparam/:title/:url";

  @override
  void initRouter(Router router) {
    router.define(settingPage,
        handler: Handler(handlerFunc: (_, params) => SettingPage()));
    router.define(aboutPage,
        handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(languagePage,
        handler: Handler(handlerFunc: (_, params) => LanguagePage()));
    // router.define(webviewparam, handler: Handler(handlerFunc: (_, params) {
    //   var url = params["url"]?.first;
    //   var title = params["title"]?.first;
    //   return WebviewNativePage(title: title, url: url);
    // }));
    router.define(accountManagerPage,
        handler: Handler(handlerFunc: (_, params) => AccountManagerPage()));
  }
}
