import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/ads_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/ads_space.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/listing_type_tab.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/location_header.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/place_list.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState extends State<OverviewPage>
    with
        AutomaticKeepAliveClientMixin<OverviewPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  OverviewPageProvider provider = OverviewPageProvider();
  PageController _pageController = PageController(initialPage: 0);

  TextEditingController searchController = TextEditingController();

  _onPageChange(int index) async {
    // presenter.onPageChange(index, city);
    provider.setIndex(index);

    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  bool isDark = false;
  int _lastReportedPage = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDark(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<OverviewPageProvider>.value(
            value: provider,
          ),
          ChangeNotifierProvider<AdsProvider>(
            create: (_) => AdsProvider(
              httpService: Provider.of<HttpService>(context, listen: false),
            ),
          ),
        ],
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              SafeArea(
                child: SizedBox(
                  height: 105,
                  width: double.infinity,
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colours.bg_color,
                    ),
                  ),
                ),
              ),
              NestedScrollView(
                key: const Key('place_list'),
                physics: ClampingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) =>
                    _sliverBuilder(context),
                body: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    /// PageView的onPageChanged是监听ScrollUpdateNotification，会造成滑动中卡顿。这里修改为监听滚动结束再更新、
                    if (notification.depth == 0 &&
                        notification is ScrollEndNotification) {
                      final PageMetrics metrics = notification.metrics;
                      final int currentPage = metrics.page.round();
                      if (currentPage != _lastReportedPage) {
                        _lastReportedPage = currentPage;
                        _onPageChange(currentPage);
                      }
                    }
                    return false;
                  },
                  child: PageView.builder(
                    key: const Key('pageView'),
                    itemCount: 5,
                    onPageChanged: _onPageChange,
                    controller: _pageController,
                    itemBuilder: (_, index) {
                      return PlaceList(
                        index: index,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      LocationHeader(
        locale: Provider.of<LanguageProvider>(context).locale ??
            Localizations.localeOf(context),
      ),
      AdsSpace(),
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: ListingTypeTabs(
            tabController: _tabController,
            mounted: mounted,
            pageController: _pageController),
      ),
    ];
  }
}
