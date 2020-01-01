import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart' as flutter_stars;
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/constants/langauge.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  var _list = ["System Default", "English", "Bahasa Malaysia", "中文"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await flutter_stars.SpUtil.getInstance();
    });
  }

  @override
  Widget build(BuildContext context) {
    String lang = flutter_stars.SpUtil.getString(Constant.language);
    String preferredLang;
    switch (lang) {
      case "Ms":
        preferredLang = _list[2];
        break;
      case "Zh":
        preferredLang = _list[3];
        break;
      case "En":
        preferredLang = _list[1];
        break;
      default:
        preferredLang = _list[0];
        break;
    }
    return Scaffold(
      appBar: const MyAppBar(
        title: "Language",
      ),
      body: ListView.separated(
          shrinkWrap: true,
          itemCount: _list.length,
          separatorBuilder: (_, index) {
            return const Divider();
          },
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () => Provider.of<LanguageProvider>(context).setLanguage(
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
                        child: Icon(Icons.done, color: Colors.blue))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
