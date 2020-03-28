import 'package:flutter/material.dart';
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
