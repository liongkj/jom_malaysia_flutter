import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/screens/tabs/account/widgets/exit_dialog.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/click_item.dart';
import 'package:provider/provider.dart';

/// design/8设置/index.html
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LanguageProvider>(context, listen: false).locale;
    String preferredLang;
    switch (lang?.languageCode) {
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
        preferredLang = S.of(context).settingLanguageLabelSystemDefault;
        break;
    }

    return Scaffold(
      appBar: MyAppBar(
        centerTitle: S.of(context).appBarTitleSetting,
        isBack: false,
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
              title: '账号管理',
              onTap: () => NavigatorUtils.push(
                  context, AccountRouter.accountManagerPage)),
          ClickItem(
            title: S.of(context).appBarTitleSettingLanguage,
            content: preferredLang,
            onTap: () =>
                NavigatorUtils.push(context, AccountRouter.languagePage),
          ),
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
          ClickItem(
            title: '退出当前账号',
            onTap: () => _showExitDialog(),
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    showDialog(context: context, builder: (_) => ExitDialog());
  }
}
