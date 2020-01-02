import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'setting/layout/splash_page.dart';
import 'setting/provider/theme_provider.dart';
import 'setting/routers/application.dart';
import 'setting/routers/routers.dart';

void main() {
  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;
  // Logger.level = Level.;
  runApp(MyApp());
  //Portrait Mode only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
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
        providers: [
          ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<PlaceDetailProvider>(
            create: (_) => PlaceDetailProvider(),
          ),
          ChangeNotifierProvider<PlaceDetailProvider>(
            create: (_) => PlaceDetailProvider(),
          ),
        ],
        child: Consumer<LanguageProvider>(
          builder: (_, lang, __) {
            return Consumer<ThemeProvider>(
              builder: (_, provider, __) {
                return MaterialApp(
                  // showPerformanceOverlay: true, //显示性能标签
                  // debugShowCheckedModeBanner: false,
                  //checkerboardRasterCacheImages: true,
                  title: 'Jom N9',
                  theme: provider.getTheme(),
                  darkTheme: provider.getTheme(isDarkMode: true),
                  home: home ?? SplashPage(),
                  // home: home,
                  onGenerateRoute: Application.router.generator,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    S.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
