import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jom_malaysia/setting/layout/home_page.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/provider_setup.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'setting/provider/theme_provider.dart';
import 'setting/routers/application.dart';
import 'setting/routers/routers.dart';

void main() {
  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;
  // Logger.level = Level.;c
  runApp(MyApp());
  //Portrait Mode only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Color(0x90CACACA), //top bar color
      statusBarIconBrightness: Brightness.dark, //top bar icons
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home}) {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      child: MultiProvider(
        providers: providers,
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return Consumer<LanguageProvider>(
              builder: (_, lang, __) {
                return MaterialApp(
                  locale: lang.locale,
                  onGenerateTitle: (BuildContext context) =>
                      S.of(context).appTitle,
                  theme: provider.getTheme(
                    isChinese: lang.locale == Locale("zh"),
                  ),
                  // darkTheme: provider.getTheme(isDarkMode: true),
                  home: Home(),
//                      ?? SplashPage(),

                  onGenerateRoute: Application.router.generator,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    S.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  // showPerformanceOverlay: true, //显示性能标签
                  debugShowCheckedModeBanner: false,
                  //checkerboardRasterCacheImages: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
