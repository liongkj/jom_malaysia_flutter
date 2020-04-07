import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/authentication/requests/auth_request.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/providers/timer_provider.dart';
import 'package:jom_malaysia/screens/tabs/account/providers/platform_provider.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class AuthUtils {
  static Function getUnlinkFunction({
    @required AuthProviderEnum type,
    @required Function(dynamic) errorHandler,
    @required PlatformProvider provider,
    @required BuildContext context,
    @required String label,
  }) {
    return () => provider.unlinkAccount(type).then((onValue) {
          showToast(S.of(context).labelUnlinkedYour(label));
          NavigatorUtils.goBack(context);
        }).catchError(errorHandler);
  }

  static Function getLinkFunction({
    @required AuthProviderEnum type,
    @required Function(dynamic) errorHandler,
    @required PlatformProvider provider,
    @required BuildContext context,
    @required String label,
  }) {
    return () => provider.linkAccount(type).then((onValue) {
          showToast(S.of(context).labelLinkedWith(label));
          NavigatorUtils.goBack(context);
        }).catchError(errorHandler);
  }

  static Function getSignInFunction({
    @required AuthOperationEnum type,
    @required Function(dynamic) errorHandler,
    @required AuthProvider loginProvider,
    @required BuildContext context,
    AuthRequest request,
  }) {
    Function _type;
    switch (type) {
      case AuthOperationEnum.GOOGLE:
        _type = () => loginProvider.signInWithGoogle().then((onValue) {
              showToast(
                  S.of(context).labelLoggedInWith(S.of(context).labelGoogle));
              NavigatorUtils.goBack(context);
            }).catchError(errorHandler,
                test: (e) => e is SignInCancelledException);
        break;
      case AuthOperationEnum.SIGNUP:
        _type = () => loginProvider.signUp(request).then(
              (onValue) {
                showToast(S.of(context).labelSignUpSuccess);
                NavigatorUtils.goBack(context);
              },
            ).catchError(errorHandler);
        break;
      case AuthOperationEnum.EMAIL:
        _type = () =>
            loginProvider.signInWithEmailPassword(request).then((onValue) {
              NavigatorUtils.goBack(context);
              showToast(
                  S.of(context).labelLoggedInWith(S.of(context).labelPassword));
            }).catchError(errorHandler);
        break;
      case AuthOperationEnum.CHANGEPASS:
        _type = () => loginProvider.changePassword(request).then((onValue) {
              Provider.of<TimerProvider>(context, listen: false).startTimer();
              showToast(
                S.of(context).msgEmailSent(request.email),
              );
            }).catchError(errorHandler);
        break;
      default:
    }
    return _type;
  }
}
