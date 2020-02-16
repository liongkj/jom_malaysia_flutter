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

  String get stateTitle {
    return Intl.message(
      'Negeri Sembilan',
      name: 'stateTitle',
      desc: '',
      args: [],
    );
  }

  String get stateSubtitle {
    return Intl.message(
      'Malaysian state',
      name: 'stateSubtitle',
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

  String get appBarTitleExplore {
    return Intl.message(
      'Explore',
      name: 'appBarTitleExplore',
      desc: '',
      args: [],
    );
  }

  String get tabTitleExploreOverview {
    return Intl.message(
      'Overview',
      name: 'tabTitleExploreOverview',
      desc: '',
      args: [],
    );
  }

  String get tabTitleExploreTodo {
    return Intl.message(
      'TODO',
      name: 'tabTitleExploreTodo',
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

  String get placeDetailInfoLabel {
    return Intl.message(
      'Detail',
      name: 'placeDetailInfoLabel',
      desc: '',
      args: [],
    );
  }

  String placeDetailCommentLabel(dynamic commentCount) {
    return Intl.message(
      'Comment ($commentCount)',
      name: 'placeDetailCommentLabel',
      desc: '',
      args: [commentCount],
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

  String get tabViewLabelShop {
    return Intl.message(
      'Shop',
      name: 'tabViewLabelShop',
      desc: '',
      args: [],
    );
  }

  String get tabViewLabelAttraction {
    return Intl.message(
      'Attraction',
      name: 'tabViewLabelAttraction',
      desc: '',
      args: [],
    );
  }

  String get tabViewLabelProfessional {
    return Intl.message(
      'Professional',
      name: 'tabViewLabelProfessional',
      desc: '',
      args: [],
    );
  }

  String get tabViewLabelGovernment {
    return Intl.message(
      'Government',
      name: 'tabViewLabelGovernment',
      desc: '',
      args: [],
    );
  }

  String get tabViewLabelNGO {
    return Intl.message(
      'NGO',
      name: 'tabViewLabelNGO',
      desc: '',
      args: [],
    );
  }

  String get settingLanguageLabelSystemDefault {
    return Intl.message(
      'System Default',
      name: 'settingLanguageLabelSystemDefault',
      desc: '',
      args: [],
    );
  }

  String get toastMessageTapToExit {
    return Intl.message(
      'Tap again to quit.',
      name: 'toastMessageTapToExit',
      desc: '',
      args: [],
    );
  }

  String get locationSelectCityMessage {
    return Intl.message(
      'Select a City',
      name: 'locationSelectCityMessage',
      desc: '',
      args: [],
    );
  }

  String get locationSelectTownMessage {
    return Intl.message(
      'Select a Town',
      name: 'locationSelectTownMessage',
      desc: '',
      args: [],
    );
  }

  String get labelSearch {
    return Intl.message(
      'Search',
      name: 'labelSearch',
      desc: '',
      args: [],
    );
  }

  String get labelNone {
    return Intl.message(
      'None',
      name: 'labelNone',
      desc: '',
      args: [],
    );
  }

  String get labelNoDetail {
    return Intl.message(
      'No more details',
      name: 'labelNoDetail',
      desc: '',
      args: [],
    );
  }

  String get labelNoNotification {
    return Intl.message(
      'No Notification',
      name: 'labelNoNotification',
      desc: '',
      args: [],
    );
  }

  String get labelSearchHint {
    return Intl.message(
      'Search for a name or keyword',
      name: 'labelSearchHint',
      desc: '',
      args: [],
    );
  }

  String get labelSearchHintNotEmpty {
    return Intl.message(
      'Keyword cannot be blank',
      name: 'labelSearchHintNotEmpty',
      desc: '',
      args: [],
    );
  }

  String get labelRatingStatus1 {
    return Intl.message(
      'Labbish',
      name: 'labelRatingStatus1',
      desc: '',
      args: [],
    );
  }

  String get labelRatingStatus2 {
    return Intl.message(
      'Better don\'t come',
      name: 'labelRatingStatus2',
      desc: '',
      args: [],
    );
  }

  String get labelRatingStatus3 {
    return Intl.message(
      'Ok Ok la',
      name: 'labelRatingStatus3',
      desc: '',
      args: [],
    );
  }

  String get labelRatingStatus4 {
    return Intl.message(
      'Not bad la',
      name: 'labelRatingStatus4',
      desc: '',
      args: [],
    );
  }

  String get labelRatingStatus5 {
    return Intl.message(
      'Sui!',
      name: 'labelRatingStatus5',
      desc: '',
      args: [],
    );
  }

  String get clickItemSettingAddAPlace {
    return Intl.message(
      'Recommend a place',
      name: 'clickItemSettingAddAPlace',
      desc: '',
      args: [],
    );
  }

  String get clickItemSettingFeedbackTitle {
    return Intl.message(
      'Feedback',
      name: 'clickItemSettingFeedbackTitle',
      desc: '',
      args: [],
    );
  }

  String get clickItemSettingFeedbackDescription {
    return Intl.message(
      'Let us serve you better',
      name: 'clickItemSettingFeedbackDescription',
      desc: '',
      args: [],
    );
  }

  String get clickItemSettingAboutTitle {
    return Intl.message(
      'About Us',
      name: 'clickItemSettingAboutTitle',
      desc: '',
      args: [],
    );
  }

  String get clickItemSettingShareTitle {
    return Intl.message(
      'Tell a friend',
      name: 'clickItemSettingShareTitle',
      desc: '',
      args: [],
    );
  }

  String get clickItemSettingRecommendPlaceTitle {
    return Intl.message(
      'Add a missing place',
      name: 'clickItemSettingRecommendPlaceTitle',
      desc: '',
      args: [],
    );
  }

  String cityPickerCurrentCity(dynamic selected) {
    return Intl.message(
      'Selected: $selected',
      name: 'cityPickerCurrentCity',
      desc: '',
      args: [selected],
    );
  }

  String get overviewSection1Para1 {
    return Intl.message(
      'Negeri Sembilan is a Malaysian state on the Malay Peninsula\'s southwest coast, known for its beaches, nature parks and palaces. To the west, on the Malacca Strait, the area around Port Dickson has seaside resorts, the Wan Loong Chinese Temple and the Kota Lukut hilltop fort. South along the coast, in the neighboring state of Malacca, is Cape Rachado (Tanjung Tuan), a nature reserve with a lighthouse.',
      name: 'overviewSection1Para1',
      desc: '',
      args: [],
    );
  }

  String get overviewSection1Para2 {
    return Intl.message(
      'Northeast from Port Dickson, the state capital of Seremban is known for its colonial architecture, Lake Garden park and wooden palaces of the Minangkabau people, an ethnic group with Indonesian roots. Their influence can also be seen in the town of Seri Menanti to the east, where a former palace is now the Sri Menanti Royal Museum. The nearby town of Kuala Pilah is home to the San Sheng Gong Chinese Temple and the colorful Hindu temple of Kuil Sri Kanthasamy. To the west, Ulu Bendul Recreational Park encompasses jungle, waterfalls and Gunung Angsi mountain.',
      name: 'overviewSection1Para2',
      desc: '',
      args: [],
    );
  }

  String get overviewSection2Title {
    return Intl.message(
      'The Name',
      name: 'overviewSection2Title',
      desc: '',
      args: [],
    );
  }

  String get overviewSection2Para1 {
    return Intl.message(
      'The name is believed to derive from the nine (sembilan) villages or nagari in the Minangkabau language (now known as luak) settled by the Minangkabau, a people originally from West Sumatra (in present-day Indonesia). Minangkabau features are still visible today in traditional architecture and the dialect of Malay spoken.',
      name: 'overviewSection2Para1',
      desc: '',
      args: [],
    );
  }

  String get overviewSection3Title {
    return Intl.message(
      'Negeri Sembilan Ruler',
      name: 'overviewSection3Title',
      desc: '',
      args: [],
    );
  }

  String get overviewSection3Para1 {
    return Intl.message(
      'Unlike the hereditary monarchs of the other royal Malay states, the ruler of Negeri Sembilan is known as Yang di-Pertuan Besar instead of Sultan. The election of the Ruler is also unique. He is selected by the council of Undangs who lead the four biggest territories of Sungai Ujong, Jelebu, Johol, and Rembau, making it one of the more democratic monarchies. The capital of Negeri Sembilan is Seremban. The royal capital is Seri Menanti in Kuala Pilah District. Other important towns are Port Dickson, Bahau and Nilai.',
      name: 'overviewSection3Para1',
      desc: '',
      args: [],
    );
  }

  String get overviewSection4Title {
    return Intl.message(
      'Capital (Seremban)',
      name: 'overviewSection4Title',
      desc: '',
      args: [],
    );
  }

  String get overviewSection4Para1 {
    return Intl.message(
      'Seremban is the capital of Negeri Sembilan and today the state has an economy based mainly in the agricultural sector with palm, rubber and fruit and vegetable farms taking up half the state\'s land area. They are also one of the leaders in the country in organic farming. Recently, residential growth demand has seen housing estates with affordable homes being built at a furious pace in and around Seremban which is just 40 minutes from Kuala Lumpur, a plus point for middle-class Malays who cannot afford the astronomical cost of living in the capital.',
      name: 'overviewSection4Para1',
      desc: '',
      args: [],
    );
  }

  String get overviewSection5Title {
    return Intl.message(
      'Demographic',
      name: 'overviewSection5Title',
      desc: '',
      args: [],
    );
  }

  String get overviewSection5Para1 {
    return Intl.message(
      'Negeri Sembilan has a collective population of 1,098,500 as of 2015; the ethnic composition consisting of Malay 622,000 (56.6%) (mostly are Minangkabau descent), other Bumiputras 20,700 (1.9%), Chinese 234,300 (21.3%), Indian 154,000 (14%), Others 4,200 (0.4%), and Non Citizens 63,300 (5.8%). The state has the highest percentage of Indians when compared to other Malaysian states.',
      name: 'overviewSection5Para1',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('en', ''), Locale('zh', ''), Locale('ms', ''),
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