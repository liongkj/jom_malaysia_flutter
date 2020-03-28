import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/login/login_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/setting/routers/routers.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:provider/provider.dart';

class ExitDialog extends StatefulWidget {
  ExitDialog({
    Key key,
  }) : super(key: key);

  @override
  _ExitDialog createState() => _ExitDialog();
}

class _ExitDialog extends State<ExitDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
        title: '提示',
        child: const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: const Text('您确定要退出登录吗？', style: TextStyles.textSize16),
        ),
        onPressed: () async {
          await Provider.of<AuthProvider>(context, listen: false).logOut();
          NavigatorUtils.push(context, Routes.home);
        });
  }
}
