import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      resizeToAvoidBottomInset: true,
      url: "https://www.jomn9.com/feedback",
      appBar: const MyAppBar(
        centerTitle: "账号管理",
      ),
    );
  }
}
