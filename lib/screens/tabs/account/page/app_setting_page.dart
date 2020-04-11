import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/account_router.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:provider/provider.dart';

class AppSettings extends StatelessWidget {
  final _menuImage = [
    'feedback',
    'language',
    'about',
    // 'credit'
  ];

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

    var _menuTitle = [
      S.of(context).clickItemSettingFeedbackTitle,
      preferredLang,
      S.of(context).clickItemSettingAboutTitle,
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MergeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              S.of(context).appBarTitleSetting,
              style: TextStyles.textBold18,
            ),
          ),
        ),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.18),
            itemCount: _menuTitle.length,
            itemBuilder: (_, index) {
              return InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LoadAssetImage('account/${_menuImage[index]}',
                          width: 32.0),
                      Gaps.vGap4,
                      Text(
                        _menuTitle[index],
                        style: TextStyles.textSize12,
                      )
                    ],
                  ),
                  onTap: () {
                    if (index == 0) {
                      NavigatorUtils.push(context, AccountRouter.feedbackPage);
                    }
                    if (index == 1)
                      NavigatorUtils.push(context, AccountRouter.languagePage);
                    if (index == 2)
                      NavigatorUtils.push(context, AccountRouter.aboutPage);
                  });
            },
          ),
        ),
        Container(
          height: 0.6,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 16.0),
          child: Gaps.line,
        ),
        Gaps.vGap24,
      ],
    );
  }
}
