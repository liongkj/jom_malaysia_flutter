import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:logger/logger.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

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
    print("main run");
    return OKToast(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(),
            ),
          ],
          child: Consumer<ThemeProvider>(
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
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en'),
                  const Locale('zh'),
                  const Locale('ms'),
                ],
              );
            },
          ),
        ),
        backgroundColor: Colors.black54,
        textPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom);
  }
}
