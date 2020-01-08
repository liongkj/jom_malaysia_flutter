import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/overview_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/overview_page_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/ads_space.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/location_header.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_list.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
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
  //Load Cities from json file
  List<String> _cities;
  Future<String> loadJsonFile() async {
    var jsonCities = await rootBundle.loadString('assets/json/cities.json');
    setState(() {
      _cities = (jsonDecode(jsonCities) as List<dynamic>).cast<String>();
    });
    //print(_cities);
  }

  TextEditingController searchController = TextEditingController();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress = '';

  _onPageChange(int index) async {
    presenter.onPageChange(index);
    provider.setIndex(index);

    _tabController.animateTo(index);
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

  @override
  OverviewPagePresenter createPresenter() {
    return OverviewPagePresenter();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    this.loadJsonFile();
    filterList();
    searchController.addListener(() {
      filterList();
    });
    //Location

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _preCacheImage();
      _getCurrentLocation();
    });
  }

  filterList() {
    if (searchController.text.isNotEmpty) {
      _cities.retainWhere((cities) =>
          cities.toLowerCase().contains(searchController.text.toLowerCase()));
    }
  }

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
      LocationHeader(
          cities: _cities, isDark: isDark, currentAddress: _currentAddress),
      ListingTypeTabs(
          isDark: isDark,
          tabController: _tabController,
          mounted: mounted,
          pageController: _pageController),
      AdsSpace(),
    ];
  }
}
