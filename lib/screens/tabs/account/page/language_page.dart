import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/constants/langauge.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final _list = [
      S.of(context).settingLanguageLabelSystemDefault,
      "English",
      "Bahasa Malaysia",
      "中文"
    ];
    String lang = langProvider.locale.languageCode;
    String preferredLang;
    switch (lang) {
      case "ms":
        preferredLang = _list[2];
        break;
      case "zh":
        preferredLang = _list[3];
        break;
      case "en":
        preferredLang = _list[1];
        break;
      default:
        preferredLang = _list[0];
        break;
    }
    return Scaffold(
      appBar: MyAppBar(
        title: S.of(context).appBarTitleSettingLanguage,
      ),
      body: ListView.separated(
          shrinkWrap: true,
          itemCount: _list.length,
          separatorBuilder: (_, index) {
            return const Divider();
          },
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () => Provider.of<LanguageProvider>(context, listen: false)
                  .setLanguage(
                index == 0
                    ? Language.SYSTEM
                    : (index == 1
                        ? Language.EN
                        : (index == 2 ? Language.MS : Language.ZH)),
              ),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                height: 50.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_list[index]),
                    ),
                    Opacity(
                        opacity: preferredLang == _list[index] ? 1 : 0,
                        child: const Icon(Icons.done, color: Colors.blue))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
