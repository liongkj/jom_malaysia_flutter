import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';

/// design/8设置/index.html
class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).clickItemSettingFeedbackTitle,
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
            title: S.of(context).clickItemSettingRecommendPlaceTitle,
            onTap: () => NavigatorUtils.goWebViewPage(
                context,
                S.of(context).clickItemSettingAddAPlace,
                WebUrl.suggestAddPlace),
          ),
        ],
      ),
    );
  }
}
