import 'package:fluro/fluro.dart';
import 'package:jom_malaysia/setting/routers/router_init.dart';

import 'page/login_page.dart';
import 'page/register_page.dart';
import 'page/reset_password_email_page.dart';
import 'page/reset_password_otp_page.dart';
import 'page/sms_login_page.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = "/login";
  static String registerPage = "/login/register";
  static String smsLoginPage = "/login/smsLogin";
  static String resetPasswordViaOtpPage = "/login/otp/resetPassword";
  static String resetPasswordViaEmailPage = "/login/email/updatePassword";

  @override
  void initRouter(Router router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(registerPage,
        handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(smsLoginPage,
        handler: Handler(handlerFunc: (_, params) => SMSLoginPage()));
    router.define(resetPasswordViaOtpPage,
        handler:
            Handler(handlerFunc: (_, params) => ResetPasswordViaOtpPage()));
    router.define(resetPasswordViaEmailPage,
        handler:
            Handler(handlerFunc: (_, params) => ResetPasswordViaEmailPage()));
  }
}
