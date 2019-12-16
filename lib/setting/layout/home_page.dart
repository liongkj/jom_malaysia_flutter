import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/account/page/setting_page.dart';
import 'package:jom_malaysia/screens/tabs/facts/pages/facts_page.dart';
import 'package:jom_malaysia/screens/tabs/nearby/pages/nearby_page.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/util/toast.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:provider/provider.dart';

import 'provider/home_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _appBarTitles = ['Home', 'Nearby', 'Facts', 'Setting'];
  final _pageList = [
    OverviewPage(),
    NearbyPage(),
    FactsPage(),
    SettingPage(),
  ];
  final _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;

  @override
  void initState() {
    super.initState();
    print("homepage buid");
    // initData();
  }

  // void initData() {}

  final double iconSize = 24;
  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      var _tabImages = [
        Icon(
          Icons.home,
          size: iconSize,
        ),
        Icon(
          Icons.map,
          size: iconSize,
        ),
        Icon(
          Icons.history,
          size: iconSize,
        ),
        Icon(
          Icons.settings,
          size: iconSize,
        ) // [
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
    }
    return _list;
  }

  DateTime _lastTime;

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      Toast.show("Tap again to quit.");
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
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __) {
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark
                    ? Colours.dark_unselected_item_color
                    : Colours.unselected_item_color,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pageList,
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
          ),
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      provider.value = index;
    });
  }
}
