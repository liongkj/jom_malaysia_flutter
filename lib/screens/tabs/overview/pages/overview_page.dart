import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/overview_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/ads_space.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/listing_type_tab.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/location_header.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_list.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState
    extends BasePageState<OverviewPage, OverviewPagePresenter>
    with
        AutomaticKeepAliveClientMixin<OverviewPage>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  OverviewPageProvider provider = OverviewPageProvider();
  PageController _pageController = PageController(initialPage: 0);
  BaseListProvider<ListingModel> listingProvider =
      BaseListProvider<ListingModel>();
  LocationProvider locationProvider = LocationProvider();
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController;

  _onPageChange(int index) async {
    presenter.onPageChange(index);
    provider.setIndex(index);

    _tabController.animateTo(index);
  }

  @override
  OverviewPagePresenter createPresenter() {
    return OverviewPagePresenter();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _scrollController = ScrollController();
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
        ChangeNotifierProvider<BaseListProvider<ListingModel>>.value(
          value: listingProvider,
        )
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
            Consumer<LocationProvider>(builder: (_, locationProvider, child) {
              return NestedScrollView(
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
                        // city: Provider.of<LocationProvider>(context).selected,
                        presenter: presenter,
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
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
