import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/sliver_appbar_delegate.dart';
import 'package:provider/provider.dart';

class ListingTypeTabs extends StatelessWidget {
  const ListingTypeTabs({
    Key key,
    @required this.isDark,
    @required TabController tabController,
    @required this.mounted,
    @required PageController pageController,
  })  : _tabController = tabController,
        _pageController = pageController,
        super(key: key);

  final bool isDark;
  final TabController _tabController;
  final bool mounted;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MySliverAppBarDelegate(
        DecoratedBox(
          decoration: BoxDecoration(
              color: isDark ? Colours.dark_bg_color : null,
              image: isDark
                  ? null
                  : DecorationImage(
                      image: ImageUtils.getAssetImage("order/order_bg1"),
                      fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListingTypeTab(
                tabController: _tabController,
                mounted: mounted,
                pageController: _pageController),
          ),
        ),
        80.0,
      ),
    );
  }
}

class ListingTypeTab extends StatelessWidget {
  const ListingTypeTab({
    Key key,
    @required TabController tabController,
    @required this.mounted,
    @required PageController pageController,
  })  : _tabController = tabController,
        _pageController = pageController,
        super(key: key);

  final TabController _tabController;
  final bool mounted;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Container(
        height: 80.0,
        padding: const EdgeInsets.only(top: 8.0),
        child: Consumer<LanguageProvider>(builder: (_, __, ___) {
          return TabBar(
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            controller: _tabController,
            labelColor:
                ThemeUtils.isDark(context) ? Colours.dark_text : Colours.text,
            unselectedLabelColor: ThemeUtils.isDark(context)
                ? Colours.dark_text_gray
                : Colours.text,
            labelStyle: TextStyles.textBold14,
            unselectedLabelStyle: const TextStyle(
              fontSize: Dimens.font_sp12,
            ),
            indicatorColor: Colors.transparent,
            tabs: <Widget>[
              _TabViewTab(0, S.of(context).tabViewLabelShop, Icons.restaurant),
              _TabViewTab(
                  1, S.of(context).tabViewLabelAttraction, Icons.local_play),
              _TabViewTab(
                  2, S.of(context).tabViewLabelGovernment, Icons.location_city),
              _TabViewTab(
                  3, S.of(context).tabViewLabelProfessional, Icons.work),
              _TabViewTab(4, S.of(context).tabViewLabelNGO, Icons.people),
            ],
            onTap: (index) {
              if (!mounted) {
                return;
              }
              _pageController.jumpToPage(index);
            },
          );
        }),
      ),
    );
  }
}

class _TabViewTab extends StatelessWidget {
  const _TabViewTab(this.index, this.text, this.icon);

  final String text;
  final IconData icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<OverviewPageProvider>(
      builder: (_, provider, child) {
        int selectIndex = provider.index;
        return Container(
          width: 80.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon,
                  size: 24.0,
                  color: index == selectIndex
                      ? Theme.of(context).indicatorColor
                      : Colors.black),
              Gaps.vGap4,
              Text(
                text,
                style: TextStyle(
                    fontSize: Dimens.font_sp14,
                    color: index == selectIndex
                        ? Theme.of(context).indicatorColor
                        : Colors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}