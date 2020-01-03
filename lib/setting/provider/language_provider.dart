import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/constants/langauge.dart';
import 'package:jom_malaysia/generated/l10n.dart';

class LanguageProvider extends ChangeNotifier {
  static const Map<Language, String> languages = {
    Language.MS: "ms",
    Language.ZH: "zh",
    Language.EN: "en"
  };

  Locale _locale;
  Locale get locale => _locale;

  void setLanguage(Language lang) {
    final String _l = languages[lang];

    SpUtil.putString(Constant.language, _l);
    _locale = Locale(_l, null);

    // Locale locale = Locale(languages[lang], '');
    // S.load(locale);
    notifyListeners();
  }

  void syncLang() {
    String lang = SpUtil.getString(Constant.language);
    if (lang.isNotEmpty && lang != languages[Language.SYSTEM]) {
      notifyListeners();
    }
  }
}
