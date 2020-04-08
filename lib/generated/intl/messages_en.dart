// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(selected) => "Selected: ${selected}";

  static m1(provider) => "Link to ${provider}";

  static m2(email) => "A password reset email will be sent to ${email}";

  static m3(field) => "${field} cannot be empty";

  static m4(operationName) => "Link ${operationName} operation cancelled.";

  static m5(len) => "Password must be at least ${len} characters";

  static m6(item) => "Please enter your ${item}";

  static m7(provider) => "Success! Linked with your ${provider} account";

  static m8(provider) => "Success! Logged in to ${provider} account";

  static m9(timer) => "Resend (${timer})";

  static m10(item) => "Adding your ${item}";

  static m11(provider) => "Success! Your ${provider} account is removed";

  static m12(email) => "An Email is sent to ${email}. Please follow the instructions.";

  static m13(text) => "Awww... No result found for \'${text}\'";

  static m14(uname) => "Nice to meet you ${uname}";

  static m15(commentCount) => "${Intl.plural(commentCount, one: 'Comment (1)', other: 'Comments (${commentCount})')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appBarTitleExplore" : MessageLookupByLibrary.simpleMessage("Discover"),
    "appBarTitleHome" : MessageLookupByLibrary.simpleMessage("Jomn9"),
    "appBarTitleMe" : MessageLookupByLibrary.simpleMessage("Me"),
    "appBarTitleNotification" : MessageLookupByLibrary.simpleMessage("Notification"),
    "appBarTitleSetting" : MessageLookupByLibrary.simpleMessage("Setting"),
    "appBarTitleSettingLanguage" : MessageLookupByLibrary.simpleMessage("Language"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("JomN9"),
    "cityPickerCurrentCity" : m0,
    "clickItemLinkToHint" : m1,
    "clickItemSettingAboutTitle" : MessageLookupByLibrary.simpleMessage("About Us"),
    "clickItemSettingAddAPlace" : MessageLookupByLibrary.simpleMessage("Recommend a place"),
    "clickItemSettingFeedbackDescription" : MessageLookupByLibrary.simpleMessage("Let us serve you better"),
    "clickItemSettingFeedbackTitle" : MessageLookupByLibrary.simpleMessage("Feedback"),
    "clickItemSettingRecommendPlaceTitle" : MessageLookupByLibrary.simpleMessage("Add a missing place"),
    "clickItemSettingShareTitle" : MessageLookupByLibrary.simpleMessage("Tell a friend"),
    "clickItemUpdatePassword" : MessageLookupByLibrary.simpleMessage("Reset Password"),
    "clickItemUpdatePasswordHint" : m2,
    "errorMessageNetworkFailure" : MessageLookupByLibrary.simpleMessage("Unknown error, Please check your network!"),
    "errorMsgAccountExist" : MessageLookupByLibrary.simpleMessage("Email Address is Already Registered"),
    "errorMsgEmailPasswordIncorrect" : MessageLookupByLibrary.simpleMessage("Email / Password is incorrect"),
    "errorMsgFieldCannotEmpty" : m3,
    "errorMsgInvalidFormatEmail" : MessageLookupByLibrary.simpleMessage("Email is Invalid"),
    "errorMsgLinkOperationCancelled" : m4,
    "errorMsgPasswordPolicy" : m5,
    "errorMsgPasswordTooWeak" : MessageLookupByLibrary.simpleMessage("Password is too weak"),
    "errorMsgRequireRelog" : MessageLookupByLibrary.simpleMessage("Try logout and login before linking your email"),
    "errorMsgSignInCancelled" : MessageLookupByLibrary.simpleMessage("Login cancelled"),
    "errorMsgTooManyRequest" : MessageLookupByLibrary.simpleMessage("Too much operation. Please try again later."),
    "errorMsgUnknownError" : MessageLookupByLibrary.simpleMessage("Unknown error try again later"),
    "errorMsgUserNotRegistered" : MessageLookupByLibrary.simpleMessage("User not registered"),
    "labelAccount" : MessageLookupByLibrary.simpleMessage("Account"),
    "labelAccountDisconnect" : MessageLookupByLibrary.simpleMessage("Disconnect"),
    "labelAccountLinkNow" : MessageLookupByLibrary.simpleMessage("Link Now"),
    "labelAccountSetting" : MessageLookupByLibrary.simpleMessage("Connected Accounts"),
    "labelAppSettings" : MessageLookupByLibrary.simpleMessage("App Settings"),
    "labelAskFirstReview" : MessageLookupByLibrary.simpleMessage("Submit first review"),
    "labelAskReview" : MessageLookupByLibrary.simpleMessage("Say Something"),
    "labelAveragePaxPrefix" : MessageLookupByLibrary.simpleMessage("RM "),
    "labelAveragePaxSuffix" : MessageLookupByLibrary.simpleMessage("PAX"),
    "labelAveragePaxTitle" : MessageLookupByLibrary.simpleMessage("Spending"),
    "labelChangeHintText" : m6,
    "labelCityNotInServiceArea" : MessageLookupByLibrary.simpleMessage("City not in service area"),
    "labelClickToAddImage" : MessageLookupByLibrary.simpleMessage("Add a image to let other know more about this place"),
    "labelConfirmLogoutMsg" : MessageLookupByLibrary.simpleMessage("Confirm log out?"),
    "labelCreditManager" : MessageLookupByLibrary.simpleMessage("Credit Setting"),
    "labelDialogCancel" : MessageLookupByLibrary.simpleMessage("CANCEL"),
    "labelDialogFriday" : MessageLookupByLibrary.simpleMessage("fri"),
    "labelDialogMonday" : MessageLookupByLibrary.simpleMessage("mon"),
    "labelDialogOkay" : MessageLookupByLibrary.simpleMessage("OKAY"),
    "labelDialogSaturday" : MessageLookupByLibrary.simpleMessage("sat"),
    "labelDialogSunday" : MessageLookupByLibrary.simpleMessage("sun"),
    "labelDialogThursday" : MessageLookupByLibrary.simpleMessage("thu"),
    "labelDialogTuesday" : MessageLookupByLibrary.simpleMessage("tue"),
    "labelDialogWednesday" : MessageLookupByLibrary.simpleMessage("wed"),
    "labelDisplayName" : MessageLookupByLibrary.simpleMessage("Your username"),
    "labelEdit" : MessageLookupByLibrary.simpleMessage("Edit"),
    "labelEmailSignIn" : MessageLookupByLibrary.simpleMessage("Email Sign In"),
    "labelForgetPassword" : MessageLookupByLibrary.simpleMessage("Forget Password"),
    "labelGoogle" : MessageLookupByLibrary.simpleMessage("Google Account"),
    "labelImageChosen" : MessageLookupByLibrary.simpleMessage("Image Chosen"),
    "labelImageRemoved" : MessageLookupByLibrary.simpleMessage("Image Removed"),
    "labelInputCostAmount" : MessageLookupByLibrary.simpleMessage("Please enter your spending"),
    "labelInputFieldEmail" : MessageLookupByLibrary.simpleMessage("Please enter your email"),
    "labelInputFieldPassword" : MessageLookupByLibrary.simpleMessage("Please enter your password"),
    "labelLinkedWith" : m7,
    "labelLogIn" : MessageLookupByLibrary.simpleMessage("Click to sign in"),
    "labelLoggedInWith" : m8,
    "labelLogout" : MessageLookupByLibrary.simpleMessage("Log Out"),
    "labelMapChooser" : MessageLookupByLibrary.simpleMessage("\'Choose a map"),
    "labelNewCommentPageComment" : MessageLookupByLibrary.simpleMessage("Add your comment"),
    "labelNewCommentPageCommentErrorMessage" : MessageLookupByLibrary.simpleMessage("Please enter some comment"),
    "labelNewCommentPageTitle" : MessageLookupByLibrary.simpleMessage("Add a title"),
    "labelNewCommentPageTitleErrorMessage" : MessageLookupByLibrary.simpleMessage("Please enter a interesting title"),
    "labelNoDetail" : MessageLookupByLibrary.simpleMessage("No more details"),
    "labelNoRating" : MessageLookupByLibrary.simpleMessage("N/A"),
    "labelNone" : MessageLookupByLibrary.simpleMessage("None"),
    "labelOtpLogin" : MessageLookupByLibrary.simpleMessage("OTP Sign In"),
    "labelPageComment" : MessageLookupByLibrary.simpleMessage("Comment"),
    "labelPassword" : MessageLookupByLibrary.simpleMessage("Email/Password"),
    "labelPasswordlessSignIn" : MessageLookupByLibrary.simpleMessage("Passwordless Sign In"),
    "labelProfileManager" : MessageLookupByLibrary.simpleMessage("Profile Setting"),
    "labelRatePlace" : MessageLookupByLibrary.simpleMessage("Rate"),
    "labelRatingStatus1" : MessageLookupByLibrary.simpleMessage("Labbish"),
    "labelRatingStatus2" : MessageLookupByLibrary.simpleMessage("Better don\'t come"),
    "labelRatingStatus3" : MessageLookupByLibrary.simpleMessage("Ok Ok la"),
    "labelRatingStatus4" : MessageLookupByLibrary.simpleMessage("Not bad la"),
    "labelRatingStatus5" : MessageLookupByLibrary.simpleMessage("Sui!"),
    "labelRegister" : MessageLookupByLibrary.simpleMessage("Register"),
    "labelRegisterYourAccount" : MessageLookupByLibrary.simpleMessage("Start your jomn9 journey"),
    "labelRememberMe" : MessageLookupByLibrary.simpleMessage("Remember me"),
    "labelResendEmail" : m9,
    "labelResetLoginPassword" : MessageLookupByLibrary.simpleMessage("Change password"),
    "labelReview" : MessageLookupByLibrary.simpleMessage("Review"),
    "labelSearch" : MessageLookupByLibrary.simpleMessage("Search"),
    "labelSearchHint" : MessageLookupByLibrary.simpleMessage("Search for a name or keyword"),
    "labelSearchHintNotEmpty" : MessageLookupByLibrary.simpleMessage("Keyword cannot be blank"),
    "labelSendEmail" : MessageLookupByLibrary.simpleMessage("Send"),
    "labelSignUpSuccess" : MessageLookupByLibrary.simpleMessage("Sign up success! Logging in now.."),
    "labelStatusPublish" : m10,
    "labelStranger" : MessageLookupByLibrary.simpleMessage("Stranger"),
    "labelSubmitReview" : MessageLookupByLibrary.simpleMessage("Publish"),
    "labelTagMustTry" : MessageLookupByLibrary.simpleMessage("JOM Must Try"),
    "labelThirdPartyLogin" : MessageLookupByLibrary.simpleMessage("Third party login"),
    "labelUndoAction" : MessageLookupByLibrary.simpleMessage("Undo"),
    "labelUnlinkedYour" : m11,
    "labelUsernameTitle" : MessageLookupByLibrary.simpleMessage("Username"),
    "labelVerifyEmail" : MessageLookupByLibrary.simpleMessage("Verify your email"),
    "labelWelcomeUser" : MessageLookupByLibrary.simpleMessage("Hi,"),
    "locationSelectCityMessage" : MessageLookupByLibrary.simpleMessage("Select a City"),
    "locationSelectTownMessage" : MessageLookupByLibrary.simpleMessage("Select a Town"),
    "locationServiceLocating" : MessageLookupByLibrary.simpleMessage("Locating city . . ."),
    "locationServiceNoGps" : MessageLookupByLibrary.simpleMessage("No GPS"),
    "locationServicePromptEnableGps" : MessageLookupByLibrary.simpleMessage("Please grant location service permission from setting"),
    "locationServicePromptPermission" : MessageLookupByLibrary.simpleMessage("Please enable your GPS"),
    "locationServiceRetryOperation" : MessageLookupByLibrary.simpleMessage("Retry"),
    "msgEmailSent" : m12,
    "msgMustHaveAtLeastOneAccount" : MessageLookupByLibrary.simpleMessage("You will always need to have at least one account connected"),
    "msgNoResultFor" : m13,
    "msgPleaseFillRequiredField" : MessageLookupByLibrary.simpleMessage("Please fill in highlighted fields"),
    "msgRegistrationSuccess" : MessageLookupByLibrary.simpleMessage("Registration completed. Loggin in..."),
    "msgUpdatePhotoSuccess" : MessageLookupByLibrary.simpleMessage("Updated your profile pic"),
    "msgUpdateUsernameSuccess" : m14,
    "overviewSection1Para1" : MessageLookupByLibrary.simpleMessage("Negeri Sembilan is a Malaysian state on the Malay Peninsula\'s southwest coast, known for its beaches, nature parks and palaces. To the west, on the Malacca Strait, the area around Port Dickson has seaside resorts, the Wan Loong Chinese Temple and the Kota Lukut hilltop fort. South along the coast, in the neighboring state of Malacca, is Cape Rachado (Tanjung Tuan), a nature reserve with a lighthouse."),
    "overviewSection1Para2" : MessageLookupByLibrary.simpleMessage("Northeast from Port Dickson, the state capital of Seremban is known for its colonial architecture, Lake Garden park and wooden palaces of the Minangkabau people, an ethnic group with Indonesian roots. Their influence can also be seen in the town of Seri Menanti to the east, where a former palace is now the Sri Menanti Royal Museum. The nearby town of Kuala Pilah is home to the San Sheng Gong Chinese Temple and the colorful Hindu temple of Kuil Sri Kanthasamy. To the west, Ulu Bendul Recreational Park encompasses jungle, waterfalls and Gunung Angsi mountain."),
    "overviewSection2Para1" : MessageLookupByLibrary.simpleMessage("The name is believed to derive from the nine (sembilan) villages or nagari in the Minangkabau language (now known as luak) settled by the Minangkabau, a people originally from West Sumatra (in present-day Indonesia). Minangkabau features are still visible today in traditional architecture and the dialect of Malay spoken."),
    "overviewSection2Title" : MessageLookupByLibrary.simpleMessage("The Name"),
    "overviewSection3Para1" : MessageLookupByLibrary.simpleMessage("Unlike the hereditary monarchs of the other royal Malay states, the ruler of Negeri Sembilan is known as Yang di-Pertuan Besar instead of Sultan. The election of the Ruler is also unique. He is selected by the council of Undangs who lead the four biggest territories of Sungai Ujong, Jelebu, Johol, and Rembau, making it one of the more democratic monarchies. The capital of Negeri Sembilan is Seremban. The royal capital is Seri Menanti in Kuala Pilah District. Other important towns are Port Dickson, Bahau and Nilai."),
    "overviewSection3Title" : MessageLookupByLibrary.simpleMessage("Negeri Sembilan Ruler"),
    "overviewSection4Para1" : MessageLookupByLibrary.simpleMessage("Seremban is the capital of Negeri Sembilan and today the state has an economy based mainly in the agricultural sector with palm, rubber and fruit and vegetable farms taking up half the state\'s land area. They are also one of the leaders in the country in organic farming. Recently, residential growth demand has seen housing estates with affordable homes being built at a furious pace in and around Seremban which is just 40 minutes from Kuala Lumpur, a plus point for middle-class Malays who cannot afford the astronomical cost of living in the capital."),
    "overviewSection4Title" : MessageLookupByLibrary.simpleMessage("Capital (Seremban)"),
    "overviewSection5Para1" : MessageLookupByLibrary.simpleMessage("Negeri Sembilan has a collective population of 1,098,500 as of 2015; the ethnic composition consisting of Malay 622,000 (56.6%) (mostly are Minangkabau descent), other Bumiputras 20,700 (1.9%), Chinese 234,300 (21.3%), Indian 154,000 (14%), Others 4,200 (0.4%), and Non Citizens 63,300 (5.8%). The state has the highest percentage of Indians when compared to other Malaysian states."),
    "overviewSection5Title" : MessageLookupByLibrary.simpleMessage("Demographic"),
    "password" : MessageLookupByLibrary.simpleMessage("password"),
    "placeDetailCommentCountLabel" : m15,
    "placeDetailInfoLabel" : MessageLookupByLibrary.simpleMessage("Detail"),
    "placeDetailMerchantInfoLabel" : MessageLookupByLibrary.simpleMessage("Merchant Info"),
    "placeDetailMerchantRegistrationNameLabel" : MessageLookupByLibrary.simpleMessage("Registration Name"),
    "placeDetailMerchantSSMLabel" : MessageLookupByLibrary.simpleMessage("SSM ID"),
    "placeDetailOpeningHoursLabel" : MessageLookupByLibrary.simpleMessage("Opening hours"),
    "placeDetailOperatingCloseLabel" : MessageLookupByLibrary.simpleMessage("CLOSED"),
    "placeDetailOperatingOpenLabel" : MessageLookupByLibrary.simpleMessage("OPEN"),
    "placeDetailOperatingSoonLabel" : MessageLookupByLibrary.simpleMessage("CLOSING SOON"),
    "settingLanguageLabelSystemDefault" : MessageLookupByLibrary.simpleMessage("System Default"),
    "stateSubtitle" : MessageLookupByLibrary.simpleMessage("Malaysian state"),
    "stateTitle" : MessageLookupByLibrary.simpleMessage("Negeri Sembilan"),
    "stateTypeNoNetwork" : MessageLookupByLibrary.simpleMessage("Network error"),
    "stateTypeNotFound" : MessageLookupByLibrary.simpleMessage("awww... can\'t find what you want"),
    "stateTypeNotification" : MessageLookupByLibrary.simpleMessage("Awww...No Notification"),
    "stateTypePlace" : MessageLookupByLibrary.simpleMessage("More places coming soon"),
    "tabTitleExploreOverview" : MessageLookupByLibrary.simpleMessage("Overview"),
    "tabTitleExploreTodo" : MessageLookupByLibrary.simpleMessage("TODO"),
    "tabViewLabelAttraction" : MessageLookupByLibrary.simpleMessage("Attraction"),
    "tabViewLabelGovernment" : MessageLookupByLibrary.simpleMessage("Government"),
    "tabViewLabelNGO" : MessageLookupByLibrary.simpleMessage("NGO"),
    "tabViewLabelProfessional" : MessageLookupByLibrary.simpleMessage("Professional"),
    "tabViewLabelShop" : MessageLookupByLibrary.simpleMessage("Shop"),
    "toastMessageTapToExit" : MessageLookupByLibrary.simpleMessage("Tap again to quit.")
  };
}
