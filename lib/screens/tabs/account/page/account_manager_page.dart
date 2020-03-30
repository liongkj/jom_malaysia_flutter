import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:provider/provider.dart';

/// design/8设置/index.html#artboard1
class AccountManagerPage extends StatefulWidget {
  @override
  _AccountManagerPageState createState() => _AccountManagerPageState();
}

class _AccountManagerPageState extends State<AccountManagerPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final loggedInUser = Provider.of<FirebaseUser>(context, listen: false);
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "账号管理",
      ),
      body: Column(
        children: <Widget>[
          ClickItem(
              title: "修改密码",
              content: "用于密码登录",
              onTap: () =>
                  NavigatorUtils.push(context, LoginRouter.updatePasswordPage)),
          ClickItem(
            title: "绑定账号",
            content: "15000000000",
          ),
        ],
      ),
    );
  }
}
