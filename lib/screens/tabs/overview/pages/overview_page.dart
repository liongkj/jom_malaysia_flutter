import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/services/gateway/http_service.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/ads_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/ads_space.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/listing_type_tab.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/location_header.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_list.dart';
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
  ScrollController _scrollController;

  _onPageChange(int index) async {
    // presenter.onPageChange(index, city);
    provider.setIndex(index);

    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _scrollController = ScrollController();

    print("overviewpage init");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  bool isDark = false;

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
                  child: isDark
                      ? null
                      : const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: const [
                                Color(0xFF5793FA),
                                Color(0xFF4647FA)
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              NestedScrollView(
                key: const Key('order_list'),
                physics: ClampingScrollPhysics(),
                controller: _scrollController ?? null,
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return _sliverBuilder(context);
                },
                body: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 5,
                  onPageChanged: _onPageChange,
                  controller: _pageController,
                  itemBuilder: (_, index) {
                    return SafeArea(
                      top: false,
                      bottom: false,
                      child: PlaceList(
                        controller: this._scrollController,
                        index: index,
                      ),
                    );
                  },
                ),
              ),
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
      ListingTypeTabs(
          isDark: isDark,
          tabController: _tabController,
          mounted: mounted,
          pageController: _pageController),
      AdsSpace(),
    ];
  }
}
