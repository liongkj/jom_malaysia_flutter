import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
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
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Color(0x80CACACA), //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
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
    print("main build");
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom,
      child: MultiProvider(
        providers: [
          InheritedProvider(
            create: (_) => HttpService(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (_) => LanguageProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider(),
          ),
          ChangeNotifierProxyProvider<LocationProvider, ListingProvider>(
            update: (ctx, location, listingProvider) =>
                listingProvider..fetchAndInitPlaces(city: location.selected),
            create: (BuildContext context) {
              return ListingProvider(
                  httpService:
                      Provider.of<HttpService>(context, listen: false));
            },
          ),
          ChangeNotifierProvider<UserCurrentLocationProvider>(
            create: (_) => UserCurrentLocationProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            print("set theme");
            return Consumer<LanguageProvider>(
              builder: (_, lang, __) {
                print("set language");
                return MaterialApp(
                  locale: lang.locale,
                  onGenerateTitle: (BuildContext context) =>
                      S.of(context).appTitle,
                  // title: 'Jom N9',
                  theme: provider.getTheme(),
                  // darkTheme: provider.getTheme(isDarkMode: true),
                  home: home ?? SplashPage(),

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
