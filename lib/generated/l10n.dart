// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

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
      'Jomn9',
      name: 'appBarTitleHome',
      desc: '',
      args: [],
    );
  }

  String get appBarTitleExplore {
    return Intl.message(
      'Discover',
      name: 'appBarTitleExplore',
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

  String get appBarTitleMe {
    return Intl.message(
      'Me',
      name: 'appBarTitleMe',
      desc: '',
      args: [],
    );
  }

  String get appBarTitleNotification {
    return Intl.message(
      'Notification',
      name: 'appBarTitleNotification',
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

  String get placeDetailInfoLabel {
    return Intl.message(
      'Detail',
      name: 'placeDetailInfoLabel',
      desc: '',
      args: [],
    );
  }

  String placeDetailCommentCountLabel(num commentCount) {
    return Intl.plural(
      commentCount,
      one: 'Comment (1)',
      other: 'Comments ($commentCount)',
      name: 'placeDetailCommentCountLabel',
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

  String get placeDetailOpeningHoursLabel {
    return Intl.message(
      'Opening hours',
      name: 'placeDetailOpeningHoursLabel',
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

  String get labelNewCommentPageTitle {
    return Intl.message(
      'Add a title',
      name: 'labelNewCommentPageTitle',
      desc: '',
      args: [],
    );
  }

  String get labelNewCommentPageTitleErrorMessage {
    return Intl.message(
      'Please enter a interesting title',
      name: 'labelNewCommentPageTitleErrorMessage',
      desc: '',
      args: [],
    );
  }

  String get labelNewCommentPageComment {
    return Intl.message(
      'Add your comment',
      name: 'labelNewCommentPageComment',
      desc: '',
      args: [],
    );
  }

  String get labelNewCommentPageCommentErrorMessage {
    return Intl.message(
      'Please enter some comment',
      name: 'labelNewCommentPageCommentErrorMessage',
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

  String get labelImageChosen {
    return Intl.message(
      'Image Chosen',
      name: 'labelImageChosen',
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

  String msgNoResultFor(Object text) {
    return Intl.message(
      'Awww... No result found for \'$text\'',
      name: 'msgNoResultFor',
      desc: '',
      args: [text],
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

  String get labelImageRemoved {
    return Intl.message(
      'Image Removed',
      name: 'labelImageRemoved',
      desc: '',
      args: [],
    );
  }

  String get labelRatePlace {
    return Intl.message(
      'Rate',
      name: 'labelRatePlace',
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

  String get labelClickToAddImage {
    return Intl.message(
      'Add a image to let other know more about this place',
      name: 'labelClickToAddImage',
      desc: '',
      args: [],
    );
  }

  String get labelReview {
    return Intl.message(
      'Review',
      name: 'labelReview',
      desc: '',
      args: [],
    );
  }

  String get labelSubmitReview {
    return Intl.message(
      'Publish',
      name: 'labelSubmitReview',
      desc: '',
      args: [],
    );
  }

  String get labelAskFirstReview {
    return Intl.message(
      'Submit first review',
      name: 'labelAskFirstReview',
      desc: '',
      args: [],
    );
  }

  String get labelAskReview {
    return Intl.message(
      'Say Something',
      name: 'labelAskReview',
      desc: '',
      args: [],
    );
  }

  String get labelPageComment {
    return Intl.message(
      'Comment',
      name: 'labelPageComment',
      desc: '',
      args: [],
    );
  }

  String get labelUndoAction {
    return Intl.message(
      'Undo',
      name: 'labelUndoAction',
      desc: '',
      args: [],
    );
  }

  String labelStatusPublish(Object item) {
    return Intl.message(
      'Adding your $item',
      name: 'labelStatusPublish',
      desc: '',
      args: [item],
    );
  }

  String get labelAveragePaxPrefix {
    return Intl.message(
      'RM ',
      name: 'labelAveragePaxPrefix',
      desc: '',
      args: [],
    );
  }

  String get labelAveragePaxTitle {
    return Intl.message(
      'Spending',
      name: 'labelAveragePaxTitle',
      desc: '',
      args: [],
    );
  }

  String get labelAveragePaxSuffix {
    return Intl.message(
      'PAX',
      name: 'labelAveragePaxSuffix',
      desc: '',
      args: [],
    );
  }

  String get labelInputCostAmount {
    return Intl.message(
      'Please enter your spending',
      name: 'labelInputCostAmount',
      desc: '',
      args: [],
    );
  }

  String get labelTagMustTry {
    return Intl.message(
      'JOM Must Try',
      name: 'labelTagMustTry',
      desc: '',
      args: [],
    );
  }

  String get labelDialogOkay {
    return Intl.message(
      'OKAY',
      name: 'labelDialogOkay',
      desc: '',
      args: [],
    );
  }

  String get labelDialogCancel {
    return Intl.message(
      'CANCEL',
      name: 'labelDialogCancel',
      desc: '',
      args: [],
    );
  }

  String get labelMapChooser {
    return Intl.message(
      '\'Choose a map',
      name: 'labelMapChooser',
      desc: '',
      args: [],
    );
  }

  String get labelDialogSunday {
    return Intl.message(
      'sun',
      name: 'labelDialogSunday',
      desc: '',
      args: [],
    );
  }

  String get labelDialogMonday {
    return Intl.message(
      'mon',
      name: 'labelDialogMonday',
      desc: '',
      args: [],
    );
  }

  String get labelDialogTuesday {
    return Intl.message(
      'tue',
      name: 'labelDialogTuesday',
      desc: '',
      args: [],
    );
  }

  String get labelDialogWednesday {
    return Intl.message(
      'wed',
      name: 'labelDialogWednesday',
      desc: '',
      args: [],
    );
  }

  String get labelDialogThursday {
    return Intl.message(
      'thu',
      name: 'labelDialogThursday',
      desc: '',
      args: [],
    );
  }

  String get labelDialogFriday {
    return Intl.message(
      'fri',
      name: 'labelDialogFriday',
      desc: '',
      args: [],
    );
  }

  String get labelDialogSaturday {
    return Intl.message(
      'sat',
      name: 'labelDialogSaturday',
      desc: '',
      args: [],
    );
  }

  String get msgPleaseFillRequiredField {
    return Intl.message(
      'Please fill in highlighted fields',
      name: 'msgPleaseFillRequiredField',
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

  String cityPickerCurrentCity(Object selected) {
    return Intl.message(
      'Selected: $selected',
      name: 'cityPickerCurrentCity',
      desc: '',
      args: [selected],
    );
  }

  String get labelAccountSetting {
    return Intl.message(
      'Connected Accounts',
      name: 'labelAccountSetting',
      desc: '',
      args: [],
    );
  }

  String get msgMustHaveAtLeastOneAccount {
    return Intl.message(
      'You will always need to have at least one account connected',
      name: 'msgMustHaveAtLeastOneAccount',
      desc: '',
      args: [],
    );
  }

  String get clickItemUpdatePassword {
    return Intl.message(
      'Reset Password',
      name: 'clickItemUpdatePassword',
      desc: '',
      args: [],
    );
  }

  String clickItemUpdatePasswordHint(Object email) {
    return Intl.message(
      'A password reset email will be sent to $email',
      name: 'clickItemUpdatePasswordHint',
      desc: '',
      args: [email],
    );
  }

  String clickItemLinkToHint(Object provider) {
    return Intl.message(
      'Link to $provider',
      name: 'clickItemLinkToHint',
      desc: '',
      args: [provider],
    );
  }

  String get labelResetLoginPassword {
    return Intl.message(
      'Change password',
      name: 'labelResetLoginPassword',
      desc: '',
      args: [],
    );
  }

  String get labelThirdPartyLogin {
    return Intl.message(
      'Third party login',
      name: 'labelThirdPartyLogin',
      desc: '',
      args: [],
    );
  }

  String get labelGoogle {
    return Intl.message(
      'Google Account',
      name: 'labelGoogle',
      desc: '',
      args: [],
    );
  }

  String get labelPassword {
    return Intl.message(
      'Email/Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  String get labelSignUpSuccess {
    return Intl.message(
      'Sign up success! Logging in now..',
      name: 'labelSignUpSuccess',
      desc: '',
      args: [],
    );
  }

  String get labelAccountDisconnect {
    return Intl.message(
      'Disconnect',
      name: 'labelAccountDisconnect',
      desc: '',
      args: [],
    );
  }

  String get labelAccountLinkNow {
    return Intl.message(
      'Link Now',
      name: 'labelAccountLinkNow',
      desc: '',
      args: [],
    );
  }

  String labelLinkedWith(Object provider) {
    return Intl.message(
      'Success! Linked with your $provider account',
      name: 'labelLinkedWith',
      desc: '',
      args: [provider],
    );
  }

  String labelUnlinkedYour(Object provider) {
    return Intl.message(
      'Success! Your $provider account is removed',
      name: 'labelUnlinkedYour',
      desc: '',
      args: [provider],
    );
  }

  String labelLoggedInWith(Object provider) {
    return Intl.message(
      'Success! Logged in to $provider account',
      name: 'labelLoggedInWith',
      desc: '',
      args: [provider],
    );
  }

  String get labelCityNotInServiceArea {
    return Intl.message(
      'City not in service area',
      name: 'labelCityNotInServiceArea',
      desc: '',
      args: [],
    );
  }

  String get stateTypePlace {
    return Intl.message(
      'More places coming soon',
      name: 'stateTypePlace',
      desc: '',
      args: [],
    );
  }

  String get stateTypeNoNetwork {
    return Intl.message(
      'Network error',
      name: 'stateTypeNoNetwork',
      desc: '',
      args: [],
    );
  }

  String get stateTypeNotFound {
    return Intl.message(
      'awww... can\'t find what you want',
      name: 'stateTypeNotFound',
      desc: '',
      args: [],
    );
  }

  String get stateTypeNotification {
    return Intl.message(
      'Awww...No Notification',
      name: 'stateTypeNotification',
      desc: '',
      args: [],
    );
  }

  String get errorMessageNetworkFailure {
    return Intl.message(
      'Unknown error, Please check your network!',
      name: 'errorMessageNetworkFailure',
      desc: '',
      args: [],
    );
  }

  String get errorMsgSignInCancelled {
    return Intl.message(
      'Login cancelled',
      name: 'errorMsgSignInCancelled',
      desc: '',
      args: [],
    );
  }

  String get locationServicePromptEnableGps {
    return Intl.message(
      'Please grant location service permission from setting',
      name: 'locationServicePromptEnableGps',
      desc: '',
      args: [],
    );
  }

  String get locationServicePromptPermission {
    return Intl.message(
      'Please enable your GPS',
      name: 'locationServicePromptPermission',
      desc: '',
      args: [],
    );
  }

  String get locationServiceRetryOperation {
    return Intl.message(
      'Retry',
      name: 'locationServiceRetryOperation',
      desc: '',
      args: [],
    );
  }

  String get locationServiceLocating {
    return Intl.message(
      'Locating city . . .',
      name: 'locationServiceLocating',
      desc: '',
      args: [],
    );
  }

  String get locationServiceNoGps {
    return Intl.message(
      'No GPS',
      name: 'locationServiceNoGps',
      desc: '',
      args: [],
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

  String get labelLogout {
    return Intl.message(
      'Log Out',
      name: 'labelLogout',
      desc: '',
      args: [],
    );
  }

  String get labelLogIn {
    return Intl.message(
      'Click to sign in',
      name: 'labelLogIn',
      desc: '',
      args: [],
    );
  }

  String get labelProfileManager {
    return Intl.message(
      'Profile Setting',
      name: 'labelProfileManager',
      desc: '',
      args: [],
    );
  }

  String get labelCreditManager {
    return Intl.message(
      'Credit Setting',
      name: 'labelCreditManager',
      desc: '',
      args: [],
    );
  }

  String get labelWelcomeUser {
    return Intl.message(
      'Hi,',
      name: 'labelWelcomeUser',
      desc: '',
      args: [],
    );
  }

  String get labelAccount {
    return Intl.message(
      'Account',
      name: 'labelAccount',
      desc: '',
      args: [],
    );
  }

  String get labelAppSettings {
    return Intl.message(
      'App Settings',
      name: 'labelAppSettings',
      desc: '',
      args: [],
    );
  }

  String get labelDisplayName {
    return Intl.message(
      'Your username',
      name: 'labelDisplayName',
      desc: '',
      args: [],
    );
  }

  String get labelUsernameTitle {
    return Intl.message(
      'Username',
      name: 'labelUsernameTitle',
      desc: '',
      args: [],
    );
  }

  String labelChangeHintText(Object item) {
    return Intl.message(
      'Please enter your $item',
      name: 'labelChangeHintText',
      desc: '',
      args: [item],
    );
  }

  String get labelConfirmLogoutMsg {
    return Intl.message(
      'Confirm log out?',
      name: 'labelConfirmLogoutMsg',
      desc: '',
      args: [],
    );
  }

  String get labelStranger {
    return Intl.message(
      'Stranger',
      name: 'labelStranger',
      desc: '',
      args: [],
    );
  }

  String get labelEdit {
    return Intl.message(
      'Edit',
      name: 'labelEdit',
      desc: '',
      args: [],
    );
  }

  String get labelNoRating {
    return Intl.message(
      'N/A',
      name: 'labelNoRating',
      desc: '',
      args: [],
    );
  }

  String get msgUpdatePhotoSuccess {
    return Intl.message(
      'Updated your profile pic',
      name: 'msgUpdatePhotoSuccess',
      desc: '',
      args: [],
    );
  }

  String msgEmailSent(Object email) {
    return Intl.message(
      'An Email is sent to $email. Please follow the instructions.',
      name: 'msgEmailSent',
      desc: '',
      args: [email],
    );
  }

  String get labelSendEmail {
    return Intl.message(
      'Send',
      name: 'labelSendEmail',
      desc: '',
      args: [],
    );
  }

  String labelResendEmail(Object timer) {
    return Intl.message(
      'Resend ($timer)',
      name: 'labelResendEmail',
      desc: '',
      args: [timer],
    );
  }

  String msgUpdateUsernameSuccess(Object uname) {
    return Intl.message(
      'Nice to meet you $uname',
      name: 'msgUpdateUsernameSuccess',
      desc: '',
      args: [uname],
    );
  }

  String get errorMsgEmailPasswordIncorrect {
    return Intl.message(
      'Email / Password is incorrect',
      name: 'errorMsgEmailPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  String get errorMsgUserNotRegistered {
    return Intl.message(
      'User not registered',
      name: 'errorMsgUserNotRegistered',
      desc: '',
      args: [],
    );
  }

  String get errorMsgUnknownError {
    return Intl.message(
      'Unknown error try again later',
      name: 'errorMsgUnknownError',
      desc: '',
      args: [],
    );
  }

  String errorMsgLinkOperationCancelled(Object operationName) {
    return Intl.message(
      'Link $operationName operation cancelled.',
      name: 'errorMsgLinkOperationCancelled',
      desc: '',
      args: [operationName],
    );
  }

  String get labelOtpLogin {
    return Intl.message(
      'OTP Sign In',
      name: 'labelOtpLogin',
      desc: '',
      args: [],
    );
  }

  String get labelPasswordlessSignIn {
    return Intl.message(
      'Passwordless Sign In',
      name: 'labelPasswordlessSignIn',
      desc: '',
      args: [],
    );
  }

  String get labelEmailSignIn {
    return Intl.message(
      'Email Sign In',
      name: 'labelEmailSignIn',
      desc: '',
      args: [],
    );
  }

  String get labelInputFieldEmail {
    return Intl.message(
      'Please enter your email',
      name: 'labelInputFieldEmail',
      desc: '',
      args: [],
    );
  }

  String get labelInputFieldPassword {
    return Intl.message(
      'Please enter your password',
      name: 'labelInputFieldPassword',
      desc: '',
      args: [],
    );
  }

  String get errorMsgInvalidFormatEmail {
    return Intl.message(
      'Email is Invalid',
      name: 'errorMsgInvalidFormatEmail',
      desc: '',
      args: [],
    );
  }

  String get labelRememberMe {
    return Intl.message(
      'Remember me',
      name: 'labelRememberMe',
      desc: '',
      args: [],
    );
  }

  String get labelForgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'labelForgetPassword',
      desc: '',
      args: [],
    );
  }

  String get labelRegister {
    return Intl.message(
      'Register',
      name: 'labelRegister',
      desc: '',
      args: [],
    );
  }

  String get errorMsgPasswordTooWeak {
    return Intl.message(
      'Password is too weak',
      name: 'errorMsgPasswordTooWeak',
      desc: '',
      args: [],
    );
  }

  String get errorMsgAccountExist {
    return Intl.message(
      'Email Address is Already Registered',
      name: 'errorMsgAccountExist',
      desc: '',
      args: [],
    );
  }

  String get msgRegistrationSuccess {
    return Intl.message(
      'Registration completed. Loggin in...',
      name: 'msgRegistrationSuccess',
      desc: '',
      args: [],
    );
  }

  String get labelRegisterYourAccount {
    return Intl.message(
      'Start your jomn9 journey',
      name: 'labelRegisterYourAccount',
      desc: '',
      args: [],
    );
  }

  String errorMsgPasswordPolicy(Object len) {
    return Intl.message(
      'Password must be at least $len characters',
      name: 'errorMsgPasswordPolicy',
      desc: '',
      args: [len],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'ms'),
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
