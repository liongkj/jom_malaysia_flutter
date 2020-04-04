import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:provider/provider.dart';

class AccountManagerPage extends StatefulWidget {
  @override
  _AccountManagerPageState createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {
  List<Map<String, bool>> _accounts;

  AuthProvider authProvider;

  @override
  void initState() {
    _accounts = [
//      S.of(context).labelGoogle,
    ];
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).labelAccountSetting,
      ),
      body: Column(
        children: <Widget>[
          ClickItem(
              title: S.of(context).clickItemUpdatePassword,
              content: S
                  .of(context)
                  .clickItemUpdatePasswordHint(authProvider.user.email),
              onTap: () =>
                  NavigatorUtils.push(context, LoginRouter.updatePasswordPage)),
          ClickItem(
            title: S.of(context).clickItemLinkToHint(_accounts[0]),
            content: "Linked",
          ),
        ],
      ),
    );
  }
}
