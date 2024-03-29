// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  static m0(selected) => "当前城市: ${selected}";

  static m1(provider) => "绑定${provider}";

  static m2(email) => "电子邮件：${email}";

  static m3(field) => "${field}不可为空";

  static m5(len) => "密码必须至少为${len}个字符";

  static m6(item) => "输入您的${item}";

  static m8(provider) => "成功登入您的${provider}帐号";

  static m10(item) => "正火速上传您的${item}";

  static m12(ver) => "版本号: ${ver}";

  static m15(uname) => "${uname},很高兴认识您";

  static m16(commentCount) => "点评 (${commentCount})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appBarTitleExplore" : MessageLookupByLibrary.simpleMessage("探索"),
    "appBarTitleHome" : MessageLookupByLibrary.simpleMessage("JomN9"),
    "appBarTitleMe" : MessageLookupByLibrary.simpleMessage("我"),
    "appBarTitleNotification" : MessageLookupByLibrary.simpleMessage("通知"),
    "appBarTitleSetting" : MessageLookupByLibrary.simpleMessage("设置"),
    "appBarTitleSettingLanguage" : MessageLookupByLibrary.simpleMessage("语言"),
    "appTitle" : MessageLookupByLibrary.simpleMessage("走森州"),
    "cityPickerCurrentCity" : m0,
    "clickItemLinkToHint" : m1,
    "clickItemSettingAboutTitle" : MessageLookupByLibrary.simpleMessage("关于JomN9"),
    "clickItemSettingAddAPlace" : MessageLookupByLibrary.simpleMessage("推荐景点/美食"),
    "clickItemSettingFeedbackDescription" : MessageLookupByLibrary.simpleMessage("让我们更好"),
    "clickItemSettingFeedbackTitle" : MessageLookupByLibrary.simpleMessage("意见反馈"),
    "clickItemSettingRecommendPlaceTitle" : MessageLookupByLibrary.simpleMessage("添加商户"),
    "clickItemSettingShareTitle" : MessageLookupByLibrary.simpleMessage("告诉朋友"),
    "clickItemUpdatePassword" : MessageLookupByLibrary.simpleMessage("修改密码"),
    "clickItemUpdatePasswordHint" : m2,
    "errorMessageNetworkFailure" : MessageLookupByLibrary.simpleMessage("网络异常，请检查您的网络！"),
    "errorMsgAccountExist" : MessageLookupByLibrary.simpleMessage("电子邮件地址已经注册"),
    "errorMsgEmailIsRegistered" : MessageLookupByLibrary.simpleMessage("此电子邮件地址不可用"),
    "errorMsgEmailPasswordIncorrect" : MessageLookupByLibrary.simpleMessage("电子邮件/密码不正确"),
    "errorMsgFieldCannotEmpty" : m3,
    "errorMsgInvalidFormatEmail" : MessageLookupByLibrary.simpleMessage("电子邮件格式错误"),
    "errorMsgPasswordPolicy" : m5,
    "errorMsgPasswordTooWeak" : MessageLookupByLibrary.simpleMessage("密码强度太弱"),
    "errorMsgRequireRelog" : MessageLookupByLibrary.simpleMessage("尝试登出后再登录"),
    "errorMsgSignInCancelled" : MessageLookupByLibrary.simpleMessage("取消登录"),
    "errorMsgTooManyRequest" : MessageLookupByLibrary.simpleMessage("操作过于频繁，请稍后再试！"),
    "errorMsgUnknownError" : MessageLookupByLibrary.simpleMessage("未知错误,请稍后再试"),
    "errorMsgUserNotRegistered" : MessageLookupByLibrary.simpleMessage("用户未注册"),
    "labelAccount" : MessageLookupByLibrary.simpleMessage("帐户"),
    "labelAccountDisconnect" : MessageLookupByLibrary.simpleMessage("断开链接"),
    "labelAccountLinkNow" : MessageLookupByLibrary.simpleMessage("链接"),
    "labelAccountSetting" : MessageLookupByLibrary.simpleMessage("连接现有账号"),
    "labelAppSettings" : MessageLookupByLibrary.simpleMessage("系统设置"),
    "labelAskFirstReview" : MessageLookupByLibrary.simpleMessage("快来做第一个点评吧"),
    "labelAskReview" : MessageLookupByLibrary.simpleMessage("说点什么"),
    "labelAveragePaxPrefix" : MessageLookupByLibrary.simpleMessage(""),
    "labelAveragePaxSuffix" : MessageLookupByLibrary.simpleMessage(" 令吉"),
    "labelAveragePaxTitle" : MessageLookupByLibrary.simpleMessage("人均"),
    "labelChangeHintText" : m6,
    "labelCityNotInServiceArea" : MessageLookupByLibrary.simpleMessage("您所在城市不在服务区域"),
    "labelClickToAddImage" : MessageLookupByLibrary.simpleMessage("点击添加商品图片"),
    "labelConfirmLogoutMsg" : MessageLookupByLibrary.simpleMessage("确认退出？"),
    "labelCreditManager" : MessageLookupByLibrary.simpleMessage("资金管理"),
    "labelDialogCancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "labelDialogFriday" : MessageLookupByLibrary.simpleMessage("五"),
    "labelDialogMonday" : MessageLookupByLibrary.simpleMessage("一"),
    "labelDialogOkay" : MessageLookupByLibrary.simpleMessage("确定"),
    "labelDialogSaturday" : MessageLookupByLibrary.simpleMessage("六"),
    "labelDialogSunday" : MessageLookupByLibrary.simpleMessage("日"),
    "labelDialogThursday" : MessageLookupByLibrary.simpleMessage("四"),
    "labelDialogTuesday" : MessageLookupByLibrary.simpleMessage("二"),
    "labelDialogWednesday" : MessageLookupByLibrary.simpleMessage("三"),
    "labelDisplayName" : MessageLookupByLibrary.simpleMessage("您的用户名"),
    "labelEdit" : MessageLookupByLibrary.simpleMessage("编辑"),
    "labelEmailSignIn" : MessageLookupByLibrary.simpleMessage("电子邮件登录"),
    "labelForgetPassword" : MessageLookupByLibrary.simpleMessage("忘记密码"),
    "labelGoogle" : MessageLookupByLibrary.simpleMessage("谷歌帐号"),
    "labelImageRemoved" : MessageLookupByLibrary.simpleMessage("成功删除"),
    "labelInputCostAmount" : MessageLookupByLibrary.simpleMessage("请输入消费金额"),
    "labelInputFieldEmail" : MessageLookupByLibrary.simpleMessage("请输入您的电子邮件"),
    "labelInputFieldPassword" : MessageLookupByLibrary.simpleMessage("请输入您的密码"),
    "labelLeaveAReview" : MessageLookupByLibrary.simpleMessage("为我们评分"),
    "labelLogIn" : MessageLookupByLibrary.simpleMessage("点击登录"),
    "labelLoggedInWith" : m8,
    "labelLogout" : MessageLookupByLibrary.simpleMessage("退出登出"),
    "labelMapChooser" : MessageLookupByLibrary.simpleMessage("选择地图"),
    "labelNewCommentPageComment" : MessageLookupByLibrary.simpleMessage("您有什么要说?"),
    "labelNewCommentPageCommentErrorMessage" : MessageLookupByLibrary.simpleMessage("点评不可为空"),
    "labelNewCommentPageTitle" : MessageLookupByLibrary.simpleMessage("标题"),
    "labelNewCommentPageTitleErrorMessage" : MessageLookupByLibrary.simpleMessage("标题不可为空"),
    "labelNoDetail" : MessageLookupByLibrary.simpleMessage("无详情"),
    "labelNone" : MessageLookupByLibrary.simpleMessage("无"),
    "labelNotVerified" : MessageLookupByLibrary.simpleMessage("进行认证"),
    "labelOtpLogin" : MessageLookupByLibrary.simpleMessage(" OTP登录"),
    "labelPageComment" : MessageLookupByLibrary.simpleMessage("全部点评"),
    "labelPassword" : MessageLookupByLibrary.simpleMessage("电子邮件/密码"),
    "labelProfileManager" : MessageLookupByLibrary.simpleMessage("账户管理"),
    "labelRatePlace" : MessageLookupByLibrary.simpleMessage("打分"),
    "labelRatingStatus1" : MessageLookupByLibrary.simpleMessage("垃圾"),
    "labelRatingStatus2" : MessageLookupByLibrary.simpleMessage("给狗吃"),
    "labelRatingStatus3" : MessageLookupByLibrary.simpleMessage("还可以"),
    "labelRatingStatus4" : MessageLookupByLibrary.simpleMessage("好吃"),
    "labelRatingStatus5" : MessageLookupByLibrary.simpleMessage("会再来"),
    "labelRegister" : MessageLookupByLibrary.simpleMessage("还没有帐号？快去注册"),
    "labelRegisterYourAccount" : MessageLookupByLibrary.simpleMessage("开始您的jomn9之旅"),
    "labelRememberMe" : MessageLookupByLibrary.simpleMessage("记住我"),
    "labelResetLoginPassword" : MessageLookupByLibrary.simpleMessage("重置登录密码"),
    "labelReview" : MessageLookupByLibrary.simpleMessage("评论"),
    "labelSearch" : MessageLookupByLibrary.simpleMessage("搜索"),
    "labelSearchHint" : MessageLookupByLibrary.simpleMessage("请输入关键词查询"),
    "labelSearchHintNotEmpty" : MessageLookupByLibrary.simpleMessage("搜索关键词不能为空！"),
    "labelSignUpSuccess" : MessageLookupByLibrary.simpleMessage("注册成功！正在登入。。"),
    "labelStatusPublish" : m10,
    "labelStranger" : MessageLookupByLibrary.simpleMessage("陌生人"),
    "labelSubmitReview" : MessageLookupByLibrary.simpleMessage("发布"),
    "labelTagMustTry" : MessageLookupByLibrary.simpleMessage("必打卡"),
    "labelThirdPartyLogin" : MessageLookupByLibrary.simpleMessage("第三方登入"),
    "labelUndoAction" : MessageLookupByLibrary.simpleMessage("撤消"),
    "labelUsernameTitle" : MessageLookupByLibrary.simpleMessage("用户名"),
    "labelVerified" : MessageLookupByLibrary.simpleMessage("已认证"),
    "labelVerifyEmail" : MessageLookupByLibrary.simpleMessage("验证您的邮件"),
    "labelVersionNo" : m12,
    "labelWelcomeUser" : MessageLookupByLibrary.simpleMessage("嗨,"),
    "locationSelectCityMessage" : MessageLookupByLibrary.simpleMessage("选择城市"),
    "locationSelectTownMessage" : MessageLookupByLibrary.simpleMessage("选择区"),
    "locationServiceLocating" : MessageLookupByLibrary.simpleMessage("定位中..."),
    "locationServiceNoGps" : MessageLookupByLibrary.simpleMessage("没有GPS"),
    "locationServicePromptEnableGps" : MessageLookupByLibrary.simpleMessage("请在设置中提供位置服务权限"),
    "locationServicePromptPermission" : MessageLookupByLibrary.simpleMessage("手机定位服务未开启"),
    "locationServiceRetryOperation" : MessageLookupByLibrary.simpleMessage("重试"),
    "msgMustHaveAtLeastOneAccount" : MessageLookupByLibrary.simpleMessage("您始终需要至少连接一个帐户"),
    "msgPleaseFillRequiredField" : MessageLookupByLibrary.simpleMessage("栏位不能为空"),
    "msgRegistrationSuccess" : MessageLookupByLibrary.simpleMessage("完成注册。正在登录..."),
    "msgUpdatePhotoSuccess" : MessageLookupByLibrary.simpleMessage("已更新您的个人资料图片"),
    "msgUpdateUsernameSuccess" : m15,
    "overviewSection1Para1" : MessageLookupByLibrary.simpleMessage("森美兰州是马来半岛西南海岸的马来西亚州，以其海滩，自然公园和宫殿而闻名。在西部，马六甲海峡，波德申港附近的地区有海滨度假胜地，万隆华人圣殿和哥打卢库特山顶堡垒。在沿海南部，在邻近的马六甲州，是拉查多角（Tanjung Tuan），这是一座带有灯塔的自然保护区。"),
    "overviewSection1Para2" : MessageLookupByLibrary.simpleMessage("芙蓉市首府东北部的迪克森港以其殖民时期的建筑，湖花园公园和Minangkabau人的木宫殿而闻名，Minangkabau人是印尼裔。他们的影响力也可见于东部的Seri Menanti，以前的宫殿现在是Sri Menanti皇家博物馆，附近的瓜拉皮拉镇（Kuala Pilah）是San Sheng Gong Chinese Temple和五颜六色的印度教寺庙Kuil Sri Kanthasamy的所在地，向西是Ulu Bendul Recreational公园包括丛林，瀑布和Gunung Angsi山。"),
    "overviewSection2Para1" : MessageLookupByLibrary.simpleMessage("该名称被认为是由Minangkabau居住的Minangkabau语言（现在称为luak）中的9个（森比亚人）村庄或nagari所居住的，Minangkabau是最初来自西苏门答腊（现今印度尼西亚）的人。Minangkabau如今，在传统建筑和马来语方言中，功能仍然很明显。"),
    "overviewSection2Title" : MessageLookupByLibrary.simpleMessage("森州名称的由来"),
    "overviewSection3Para1" : MessageLookupByLibrary.simpleMessage("与其他皇家马来国家的世袭君主不同，森美兰的统治者被称为扬·迪·普尔图安·贝萨尔，而不是苏丹。统治者的选举也很独特。他是由昂当斯理事会选出的他领导着双溪Ujong，Jelebu，Johol和Rembau四个最大领土，使其成为民主制君主制之一。森美兰的首都是芙蓉，皇家首都是瓜拉皮拉区的Seri Menanti，其他重要城镇是港口迪克森，巴豪和汝来。"),
    "overviewSection3Title" : MessageLookupByLibrary.simpleMessage("森美兰统治者"),
    "overviewSection4Para1" : MessageLookupByLibrary.simpleMessage("芙蓉市是森美兰州的首府，如今该州的经济主要以农业部门为基础，棕榈，橡胶以及果蔬农场占该州土地面积的一半。它们也是该州的领导者之一。最近，随着住宅增长的需求，芙蓉市及其周边地区兴建了可负担房屋的住宅，发展迅猛，距吉隆坡仅40分钟路程，这对那些无法负担天文数字的中产马来人来说是一个加分首都的生活费用。"),
    "overviewSection4Title" : MessageLookupByLibrary.simpleMessage("首都（芙蓉市）"),
    "overviewSection5Para1" : MessageLookupByLibrary.simpleMessage("截至2015年，森美兰州的总人口为1,098,500；族裔构成为马来人622,000（56.6％）（主要是Minangkabau血统），其他土著20,700（1.9％），华裔234,300（21.3％），印度是154,000（14％），其他4,200（0.4％）和非公民63,300（5.8％）。与马来西亚其他州相比，该州的印度人比例最高。"),
    "overviewSection5Title" : MessageLookupByLibrary.simpleMessage("人口统计"),
    "password" : MessageLookupByLibrary.simpleMessage("密码"),
    "placeDetailCommentCountLabel" : m16,
    "placeDetailInfoLabel" : MessageLookupByLibrary.simpleMessage("产品详情"),
    "placeDetailMerchantInfoLabel" : MessageLookupByLibrary.simpleMessage("商家信息"),
    "placeDetailMerchantRegistrationNameLabel" : MessageLookupByLibrary.simpleMessage("注册名字"),
    "placeDetailMerchantSSMLabel" : MessageLookupByLibrary.simpleMessage("SSM号"),
    "placeDetailOpeningHoursLabel" : MessageLookupByLibrary.simpleMessage("营业时间"),
    "placeDetailOperatingCloseLabel" : MessageLookupByLibrary.simpleMessage("休息"),
    "placeDetailOperatingOpenLabel" : MessageLookupByLibrary.simpleMessage("营业"),
    "placeDetailOperatingSoonLabel" : MessageLookupByLibrary.simpleMessage("即将休息"),
    "settingLanguageLabelSystemDefault" : MessageLookupByLibrary.simpleMessage("跟随系统"),
    "stateTitle" : MessageLookupByLibrary.simpleMessage("森美兰"),
    "stateTypeNoNetwork" : MessageLookupByLibrary.simpleMessage("无网络连接"),
    "stateTypePlace" : MessageLookupByLibrary.simpleMessage("呜呜这里空荡荡的"),
    "tabTitleExploreOverview" : MessageLookupByLibrary.simpleMessage("简介"),
    "tabTitleExploreTodo" : MessageLookupByLibrary.simpleMessage("打卡"),
    "tabViewLabelAttraction" : MessageLookupByLibrary.simpleMessage("游玩景点"),
    "tabViewLabelGovernment" : MessageLookupByLibrary.simpleMessage("政府部门"),
    "tabViewLabelNGO" : MessageLookupByLibrary.simpleMessage("非政府组织"),
    "tabViewLabelProfessional" : MessageLookupByLibrary.simpleMessage("专业服务"),
    "tabViewLabelShop" : MessageLookupByLibrary.simpleMessage("美食商店"),
    "toastMessageTapToExit" : MessageLookupByLibrary.simpleMessage("再次点击退出应用")
  };
}
