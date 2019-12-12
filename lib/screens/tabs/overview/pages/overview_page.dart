import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage({Key key}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends BasePageState<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Overviewpage"),
    );
  }
}
