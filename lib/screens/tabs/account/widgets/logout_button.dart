import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:provider/provider.dart';

class LogOutButton extends StatelessWidget {
  LogOutButton({this.logOut});

  final Function logOut;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    if (user != null)
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
  }
}
