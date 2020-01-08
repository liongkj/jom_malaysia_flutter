import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/overview_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/place_detail_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/ads_space.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_list.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:jom_malaysia/widgets/sliver_appbar_delegate.dart';
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
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress = '';

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
    //Location
    _getCurrentLocation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _preCacheImage();
    });
  }

  //Get current location
  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(position);
      });
    }).catchError((e) {
      print(e);
    });
  }

  //Get Location Base on Latitude and Longtitude
  _getAddressFromLatLng(position) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
            "${place.locality}"; //, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  // _preCacheImage() {
  //   precacheImage(ImageUtils.getAssetImage("order/xdd_n"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/dps_s"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/dwc_s"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/ywc_s"), context);
  //   precacheImage(ImageUtils.getAssetImage("order/yqx_s"), context);
  // }

  @override
  void dispose() {
    _tabController?.dispose();
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
                    child: Builder(
                      builder: (BuildContext context) {
                        return PlaceList(
                          index: index,
                          presenter: presenter,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          brightness: Brightness.dark,
          actions: <Widget>[
            GestureDetector(
              // key: _buttonKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Negeri Sembilan",
                      style: TextStyles.textBold16,
                    ),
                    //statelist drop down
                    IconButton(
                      onPressed: () {
                        NavigatorUtils.push(context, "");
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: ThemeUtils.getIconColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                NavigatorUtils.push(context, OverviewRouter.placeDetailPage);
              },
              tooltip: 'Search',
              icon: Icon(
                Icons.search,
                color: ThemeUtils.getIconColor(context),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.18,
          //  140.0,
          floating: false, // 不随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
              background: isDark
                  ? Container(
                      height: 113.0,
                      color: Colours.dark_bg_color,
                    )
                  : const LoadAssetImage(
                      "order/order_bg",
                      width: double.infinity,
                      height: 113.0,
                      fit: BoxFit.fill,
                    ),
              centerTitle: true,
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
              collapseMode: CollapseMode.pin,
              title: _CurrentLocation(
                  address: _currentAddress) //(position: _currentPosition),
              ),
        ),
      ),
      SliverPersistentHeader(
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
              child: _ListingTypeTab(
                  tabController: _tabController,
                  mounted: mounted,
                  pageController: _pageController),
            ),
          ),
          80.0,
        ),
      ),
      AdsSpace(),
    ];
  }
}

class _CurrentLocation extends StatelessWidget {
  final String address;
  //final Position position;
  const _CurrentLocation({
    this.address,
    //this.position,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.near_me,
            size: Dimens.font_sp16,
            color: ThemeUtils.getIconColor(context),
          ),
          Gaps.hGap8,
          Text(
            address,
            //position.latitude.toString()+','+position.longitude.toString(),
            style: TextStyle(
                color: ThemeUtils.getIconColor(context),
                fontSize: Dimens.font_sp16),
          ),
        ],
      ),
    );
  }
}

class _ListingTypeTab extends StatelessWidget {
  const _ListingTypeTab({
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
