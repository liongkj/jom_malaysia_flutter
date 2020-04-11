import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class VerifyStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var loggedUser = authProvider.user;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ColorFiltered(
            colorFilter: loggedUser.verified
                ? ColorFilter.mode(Colors.transparent, BlendMode.srcATop)
                : ColorFilter.matrix(_filterMatrix),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/account/verified.png"),
              radius: 10,
            ),
          ),
          Gaps.hGap8,
          loggedUser.verified
              ? Text(S.of(context).labelVerified)
              : FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    authProvider.verify().then((_) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Email sent to xxx. Please check your spam folder too"),
                      ));
                    });
                  },
                  child: Text(
                    S.of(context).labelNotVerified,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
        ],
      ),
    );
  }

  var _filterMatrix = <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0
  ];
}
