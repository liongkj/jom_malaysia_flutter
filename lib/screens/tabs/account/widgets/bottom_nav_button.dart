import 'package:flutter/material.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/widgets/my_button.dart';
import 'package:provider/provider.dart';

class BottomNavButton extends StatelessWidget {
  BottomNavButton({
    @required this.logOut,
    @required this.title,
    this.danger = false,
  });

  final Function logOut;
  final String title;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    if (user != null)
      return Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 48),
        child: MyButton(
          onPressed: logOut,
          text: title,
          isDanger: danger,
        ),
      );
    else
      return Container(
        width: 0,
        height: 0,
      );
  }
}
