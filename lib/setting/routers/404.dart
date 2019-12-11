import 'package:flutter/material.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/state_layout.dart';

class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: "This page does not exist yet..",
      ),
      body: StateLayout(
        type: StateType.account,
        hintText: "This page does not exist yet..",
      ),
    );
  }
}
