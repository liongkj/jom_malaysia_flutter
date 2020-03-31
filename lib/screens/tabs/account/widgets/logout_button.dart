import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:provider/provider.dart';

class LogOutButton extends StatelessWidget {
  LogOutButton({this.logOut});

  final Function logOut;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseUser>(builder: (_, provider, __) {
      if (provider != null)
        return Container(
          padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 48),
          child: MyButton(
            onPressed: logOut,
            text: S.of(context).labelLogout,
          ),
        );
      else
        return Container(
          width: 0,
          height: 0,
        );
    });
  }
}
