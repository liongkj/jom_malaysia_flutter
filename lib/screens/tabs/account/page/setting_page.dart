import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import '../setting_router.dart';

/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    String language = flutter_stars.SpUtil.getString(Constant.language);
    String preferredLang;
    switch (language) {
      case "ms":
        preferredLang = "Bahasa Malaysia";
        break;
      case "zh":
        preferredLang = "中文";
        break;
      case "en":
        preferredLang = "English";
        break;
      default:
        preferredLang = "System Default";
        break;
    }

    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).appBarTitleSettingLanguage,
        isBack: false,
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: S.of(context).appBarTitleSettingLanguage,
            content: preferredLang,
            onTap: () =>
                NavigatorUtils.push(context, AccountRouter.languagePage),
          ),
          ClickItem(
              title: S.of(context).clickItemSettingFeedbackTitle,
              content: S.of(context).clickItemSettingFeedbackDescription,
              onTap: () => {
                    NavigatorUtils.goWebViewPage(
                        context, "Feedback", "https://www.jomn9.com/feedback")
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
