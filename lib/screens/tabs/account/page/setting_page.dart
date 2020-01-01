import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
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
    // String theme = flutter_stars.SpUtil.getString(Constant.theme);
    // String themeMode;
    // switch (theme) {
    //   case "Dark":
    //     themeMode = "开启";
    //     break;
    //   case "Light":
    //     themeMode = "关闭";
    //     break;
    //   default:
    //     themeMode = "跟随系统";
    //     break;
    // }

    String language = flutter_stars.SpUtil.getString(Constant.language);
    String preferredLang;
    switch (language) {
      case "Ms":
        preferredLang = "Bahasa Malaysia";
        break;
      case "Zh":
        preferredLang = "中文";
        break;
      default:
        preferredLang = "System Default";
        break;
    }

    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "Settings",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: "Language",
            content: preferredLang,
            onTap: () =>
                NavigatorUtils.push(context, AccountRouter.languagePage),
          ),
          ClickItem(
              title: "About JomN9",
              onTap: () =>
                  NavigatorUtils.push(context, AccountRouter.aboutPage)),
        ],
      ),
    );
  }
}
