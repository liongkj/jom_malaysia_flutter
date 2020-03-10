import 'dart:ui';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/constants/themes.dart';
import 'package:jom_malaysia/core/res/resources.dart';

class ThemeProvider with ChangeNotifier {
  static const Map<Themes, String> themes = {
    Themes.DARK: "Dark",
    Themes.LIGHT: "Light",
    Themes.SYSTEM: "System"
  };

  void syncTheme() {
    String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != themes[Themes.SYSTEM]) {
      notifyListeners();
    }
  }

  void setTheme(Themes theme) {
    SpUtil.putString(Constant.theme, themes[theme]);
    notifyListeners();
  }

  getTheme({bool isDarkMode: false, bool isChinese: false}) {
    String theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case "Dark":
        isDarkMode = true;
        break;
      case "Light":
        isDarkMode = false;
        break;
      default:
        break;
    }

    return ThemeData(
      fontFamily: isChinese
          ? GoogleFonts.notoSans().fontFamily
          : GoogleFonts.nunitoSans().fontFamily,
      errorColor: isDarkMode ? Colours.dark_red : Colours.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      accentColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
      // 页面背景色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.dark_bg_color : Colours.bg_color,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
      // 文字选择色（输入框复制粘贴菜单）
      textSelectionColor: Colours.app_main.withAlpha(70),
      textSelectionHandleColor: Colours.app_main,

      textTheme: TextTheme(
        // TextField输入文字颜色
        // Text文字样式
        //https://api.flutter.dev/flutter/material/TextTheme-class.html
        headline: isDarkMode ? TextStyles.textDark : TextStyles.headline,
        title: isDarkMode ? TextStyles.textDark : TextStyles.title,
        subhead: isDarkMode ? TextStyles.textDark : TextStyles.subhead,
        body2: isDarkMode ? TextStyles.textDark : TextStyles.body2,
        body1: isDarkMode ? TextStyles.textDark : TextStyles.body1,
        caption: isDarkMode ? TextStyles.textDark : TextStyles.caption,
        button: isDarkMode ? TextStyles.textDark : TextStyles.button,
        subtitle: isDarkMode ? TextStyles.textDark : TextStyles.subtitle,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? Colours.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
          color: isDarkMode ? Colours.dark_line : Colours.line,
          space: 0.6,
          thickness: 0.6),
    );
  }
}
