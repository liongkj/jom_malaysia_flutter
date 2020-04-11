import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';

/// design/8设置/index.html
class AppSettingPage extends StatefulWidget {
  @override
  _AppSettingPageState createState() => _AppSettingPageState();
}

class _AppSettingPageState extends State<AppSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).appBarTitleSetting,
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
              title: S.of(context).clickItemSettingFeedbackTitle,
              content: S.of(context).clickItemSettingFeedbackDescription,
              onTap: () {
                return NavigatorUtils.goWebViewPage(
                    context,
                    S.of(context).clickItemSettingFeedbackTitle,
                    WebUrl.feedback);
              }),
          ClickItem(
              title: S.of(context).clickItemSettingAboutTitle,
              onTap: () =>
                  NavigatorUtils.push(context, AccountRouter.aboutPage)),
        ],
      ),
    );
  }
}
