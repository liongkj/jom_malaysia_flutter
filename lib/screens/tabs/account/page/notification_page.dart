import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).appBarTitleNotification,
      ),
      body: Container(
        child: StateLayout(
            type: StateType.message,
            hintText: S.of(context).labelNoNotification),
      ),
    );
  }
}
