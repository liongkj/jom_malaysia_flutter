import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:flutter/material.dart';
import '../../../setting/common/common.dart';
import '../../../setting/res/gaps.dart';
import '../../../setting/routers/fluro_navigator.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/click_item.dart';
import '../setting_router.dart';

/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    String theme = flutter_stars.SpUtil.getString(Constant.theme);
    String themeMode;
    switch (theme) {
      case "Dark":
        themeMode = "开启";
        break;
      case "Light":
        themeMode = "关闭";
        break;
      default:
        themeMode = "跟随系统";
        break;
    }

    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: "设置",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          // ClickItem(
          //     title: "账号管理",
          //     onTap: () => NavigatorUtils.push(
          //         context, SettingRouter.accountManagerPage)),
          // ClickItem(title: "清除缓存", content: "23.5MB", onTap: () {}),
          ClickItem(
              title: "夜间模式",
              content: themeMode,
              onTap: () =>
                  NavigatorUtils.push(context, SettingRouter.themePage)),
          ClickItem(
              title: "关于我们",
              onTap: () =>
                  NavigatorUtils.push(context, SettingRouter.aboutPage)),
        ],
      ),
    );
  }
}
