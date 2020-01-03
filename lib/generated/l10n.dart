// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S(this.localeName);
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S(localeName);
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  final String localeName;

  String get appTitle {
    return Intl.message(
      'JomN9',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  String get appBarTitleHome {
    return Intl.message(
      'Home',
      name: 'appBarTitleHome',
      desc: '',
      args: [],
    );
  }

  String get appBarTitleWiki {
    return Intl.message(
      'Wiki',
      name: 'appBarTitleWiki',
      desc: '',
      args: [],
    );
  }

  String get appBarTitleSetting {
    return Intl.message(
      'Setting',
      name: 'appBarTitleSetting',
      desc: '',
      args: [],
    );
  }

  String get appBarTitleSettingLanguage {
    return Intl.message(
      'Language',
      name: 'appBarTitleSettingLanguage',
      desc: '',
      args: [],
    );
  }

  String get placeDetailMerchantInfoLabel {
    return Intl.message(
      'Merchant Info',
      name: 'placeDetailMerchantInfoLabel',
      desc: '',
      args: [],
    );
  }

  String get placeDetailMerchantRegistrationNameLabel {
    return Intl.message(
      'Registration Name',
      name: 'placeDetailMerchantRegistrationNameLabel',
      desc: '',
      args: [],
    );
  }

  String get placeDetailMerchantSSMLabel {
    return Intl.message(
      'SSM ID',
      name: 'placeDetailMerchantSSMLabel',
      desc: '',
      args: [],
    );
  }

  String get placeDetailOperatingOpenLabel {
    return Intl.message(
      'OPEN',
      name: 'placeDetailOperatingOpenLabel',
      desc: '',
      args: [],
    );
  }

  String get placeDetailOperatingCloseLabel {
    return Intl.message(
      'CLOSED',
      name: 'placeDetailOperatingCloseLabel',
      desc: '',
      args: [],
    );
  }

  String get placeDetailOperatingSoonLabel {
    return Intl.message(
      'CLOSING SOON',
      name: 'placeDetailOperatingSoonLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', ''), Locale('ms', ''), Locale('zh', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}