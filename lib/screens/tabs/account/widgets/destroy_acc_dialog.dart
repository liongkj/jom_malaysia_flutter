import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/provider/auth_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/setting/routers/routers.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:provider/provider.dart';

class DestroyAccountDialog extends StatefulWidget {
  DestroyAccountDialog({
    Key key,
  }) : super(key: key);

  @override
  _DestroyAccountDialog createState() => _DestroyAccountDialog();
}

class _DestroyAccountDialog extends State<DestroyAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
        showCancel: true,
        title: S.of(context).labelLogout,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
              S.of(context).labelConfirmLogoutMsg, //TODO confirm destroy msg
              style: TextStyles.textSize16),
        ),
        onPressed: () async {
          await Provider.of<AuthProvider>(context, listen: false).destroy();
          NavigatorUtils.push(context, Routes.home);
        });
  }
}
