import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/account/page/setting_page.dart';
import 'package:jom_malaysia/screens/tabs/explore/pages/explore_page.dart';
import 'package:jom_malaysia/screens/tabs/notification/pages/notification_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/theme_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:provider/provider.dart';

import 'provider/home_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _pageList = [
    OverviewPage(),
    ExplorePage(),
    NotificationPage(),
    SettingPage(),
  ];
  final _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 由于SpUtil未初始化，所以MaterialApp获取的为默认主题配置，这里同步一下。

      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
      // Provider.of<LanguageProvider>(context, listen: false).syncLang();
      // Provider.of<LocationProvider>(context, listen: false).syncLoc();
    });
    // initData();
  }

  // void initData() {}

  final double iconSize = 24;
  List<BottomNavigationBarItem> _buildBottomNavigationBarItem(
      BuildContext context) {
    final _appBarTitles = [
      S.of(context).appBarTitleHome,
      S.of(context).appBarTitleExplore,
      S.of(context).appBarTitleNotification,
      S.of(context).appBarTitleSetting,
    ];

    var _tabImages = [
      Icon(
        Icons.home,
        size: iconSize,
      ),
      Icon(
        Icons.explore,
        size: iconSize,
      ),
      Icon(
        Icons.notifications,
        size: iconSize,
      ),
      Icon(
        Icons.settings,
        size: iconSize,
      ),

      // [
    ];
    _list = List.generate(4, (i) {
      return BottomNavigationBarItem(
        icon: _tabImages[i],
        // activeIcon: _tabImages[i][1],
        title: Padding(
          padding: const EdgeInsets.only(top: 1.5),
          child: Text(
            _appBarTitles[i],
            key: Key(_appBarTitles[i]),
            style: TextStyles.textBold14,
          ),
        ),
      );
    });

    return _list;
  }

  DateTime _lastTime;

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      Toast.show(S.of(context).toastMessageTapToExit);
      return Future.value(false);
    }
    Toast.cancelToast();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
        create: (_) => provider,
        child: WillPopScope(
          onWillPop: _isExit,
          child: Scaffold(
            bottomNavigationBar:
                Consumer<HomeProvider>(builder: (_, provider, __) {
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: _buildBottomNavigationBarItem(context),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Colours.selected_item_color,
                unselectedItemColor: Colours.unselected_item_color,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            }),
            body: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _pageList,
              physics: NeverScrollableScrollPhysics(), // 禁止滑动
            ),
          ),
        ));
  }

  void _onPageChanged(int index) {
    setState(() {
      provider.value = index;
    });
  }
}
