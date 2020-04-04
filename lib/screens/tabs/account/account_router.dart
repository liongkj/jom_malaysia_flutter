import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/screens/tabs/account/page/about_page.dart';
import 'package:jom_malaysia/screens/tabs/account/page/account_setting_page.dart';
import 'package:jom_malaysia/screens/tabs/account/page/app_setting_page.dart';
import 'package:jom_malaysia/screens/tabs/account/page/language_page.dart';
import 'package:jom_malaysia/screens/tabs/account/page/notification_page.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/input_text_page.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

class AccountRouter implements IRouterProvider {
  static String settingPage = "/account";
  static String aboutPage = "/account/about";
  static String languagePage = "/account/language";
  static String accountManagerPage = "/setting/accountManager";
  static String notificationPage = "/setting/notification";
  static String inputTextPage = "/setting/inputTextPage";

  @override
  void initRouter(Router router) {
    router.define(settingPage,
        handler: Handler(handlerFunc: (_, params) => AppSettingPage()));
    router.define(aboutPage,
        handler: Handler(handlerFunc: (_, params) => AboutPage()));
    router.define(languagePage,
        handler: Handler(handlerFunc: (_, params) => LanguagePage()));
    router.define(accountManagerPage,
        handler: Handler(handlerFunc: (_, params) => AccountSettingPage()));
    router.define(inputTextPage,
        handler: Handler(
            handlerFunc: (_, params) => InputTextPage(
                  title: params["title"]?.first,
                  content: params["content"]?.first,
                  hintText: params["hintText"]?.first,
                )));
    router.define(notificationPage,
        handler: Handler(handlerFunc: (_, params) => NotificationPage()));
  }
}
