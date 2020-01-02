import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/constants/langauge.dart';
import 'package:jom_malaysia/generated/l10n.dart';

class LanguageProvider extends ChangeNotifier {
  static const Map<Language, String> languages = {
    Language.MS: "Ms",
    Language.ZH: "Zh",
    Language.EN: "En"
  };

  void setLanguage(Language lang) {
    SpUtil.putString(Constant.language, languages[lang]);
    const Locale locale = Locale('lang', '');
    S.load(locale);
    notifyListeners();
  }
}
