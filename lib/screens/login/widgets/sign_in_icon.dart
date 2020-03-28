import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/exception/signin_cancelled_exception.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/setting/routers/routers.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class SignInIcon extends StatelessWidget {
  SignInIcon({
    this.iconString,
    this.signInAction,
  });
  final Function signInAction;
  final String iconString;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: signInAction,
      icon: LoadAssetImage('login/providers/$iconString'),
    );
  }
}
