import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jom_malaysia/core/models/ads_model.dart';
import 'package:jom_malaysia/core/res/colors.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/ads_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/listing_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/ads_space.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/listing_type_tab.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/location_header.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/place_list.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
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
  SwiperController _adsController;
  Future<List<AdsModel>> _fetchAds;

  _onPageChange(int index) async {
    provider.setIndex(index);

    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _fetchAds =
        Provider.of<AdsService>(context, listen: false).fetchAndInitAds();
    _adsController = SwiperController();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _adsController?.stopAutoplay();

    _adsController?.dispose();
    super.dispose();
  }

  int _lastReportedPage = 0;

  Future _onRefresh() async {
    var loc = Provider.of<LocationProvider>(context, listen: false)
        .selected
        ?.cityName;
    Provider.of<ListingProvider>(context, listen: false)
        .fetchAndInitPlaces(city: loc, refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<OverviewPageProvider>.value(
            value: provider,
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
                        onRefresh: () => _onRefresh(),
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
      SliverToBoxAdapter(
          child: FutureBuilder<List<AdsModel>>(
              initialData: [],
              future: _fetchAds,
              builder: (ctx, snapshot) {
                return AdsSpace(
                  adList: snapshot.data,
                  controller: _adsController,
                );
              })),
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
