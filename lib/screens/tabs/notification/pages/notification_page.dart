import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).appBarTitleNotification,
        isBack: false,
      ),
      body: Container(
        child: Center(
          child: Text(S.of(context).labelNoNotification),
        ),
      ),
    );
  }
}
