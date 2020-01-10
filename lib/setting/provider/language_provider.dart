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

  // Locale _locale;
  Locale get locale {
    String preference = SpUtil.getString(Constant.language);
    return preference == "" ? null : Locale(preference, null);
  }

  void setLanguage(Language lang) {
    final String _l = languages[lang];
    if (_l == null) {
      SpUtil.remove(Constant.language);
      // _locale = null;
    } else {
      SpUtil.putString(Constant.language, _l);
      // _locale = Locale(_l, null);
    }
    notifyListeners();
  }

  void syncLang() {
    String lang = SpUtil.getString(Constant.language);
    if (lang.isNotEmpty && lang != languages[Language.SYSTEM]) {
      notifyListeners();
    }
  }
}
