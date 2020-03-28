import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/setting/routers/routers.dart';
import 'package:provider/provider.dart';

class AuthUtils {
  static Function getSignInFunction(
      {@required SignInTypeEnum type,
      @required Function(dynamic) errorHandler,
      @required AuthProvider loginProvider,
      @required BuildContext context}) {
    Function _type;
    switch (type) {
      case SignInTypeEnum.GOOGLE:
        _type = () => loginProvider
            .signInWithGoogle()
            .then(
              (onValue) =>
                  NavigatorUtils.push(context, Routes.home, clearStack: true),
              //TODO change to previous path
            )
            .catchError(errorHandler,
                test: (e) => e is SignInCancelledException);
        break;
      default:
    }
    return _type;
  }
}
