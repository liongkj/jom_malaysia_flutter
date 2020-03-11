import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/current_location.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

class LocationHeader extends StatefulWidget {
  const LocationHeader({
    Key key,
    this.locale,
  }) : super(key: key);
  final locale;

  @override
  _LocationHeaderState createState() => _LocationHeaderState();
}

const kExpandedHeight = 80.0;

class _LocationHeaderState extends State<LocationHeader> {
//Load Cities from json file
  List<CityModel> _cities = [];
  var selectedLocationStr;
  CityModel selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadData();
    _fetchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color(0xFFb8b8b8);
    return SliverAppBar(
      leading: null,
      // brightness: Brightness.dark,
      actions: <Widget>[
        // SearchBarButton(
        IconButton(
          icon: const LoadAssetImage(
            "overview/icon_search",
            color: iconColor,
            width: 24,
          ),
          onPressed: () =>
              NavigatorUtils.push(context, OverviewRouter.placeSearchPage),
        ),
      ],
      backgroundColor: Colours.dark_button_text,
      floating: true, // 不随着滑动隐藏标题
      snap: true,
      pinned: false, // 固定在顶部
      elevation: 0.0,
      expandedHeight: MediaQuery.of(context).size.height * 0.10,

      flexibleSpace: MyFlexibleSpaceBar(
        background: DecoratedBox(
          decoration: BoxDecoration(
            color: Colours.dark_button_text,
          ),
        ),
        centerTitle: true,
        titlePadding: const EdgeInsetsDirectional.only(start: 14.0),
        collapseMode: CollapseMode.pin,
        title: GestureDetector(
          onTap: () => _showCityPickerDialog(context, selectedLocation),
          child: Container(
            height: kExpandedHeight * 0.3,
            // padding: const EdgeInsets.only(left: 12, right: 16.0),
            child: Consumer<LocationProvider>(
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colours.arrow_color,
              ),
              builder: (_, location, child) {
                selectedLocation =
                    _cities.isNotEmpty && location.selected != null
                        ? _cities.firstWhere(
                            (x) => x.cityName == location.selected?.cityName,
                            orElse: null)
                        : null;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      selectedLocation == null
                          ? S.of(context).locationSelectCityMessage
                          : selectedLocation.getCityName(widget.locale),
                      style: TextStyles.textBold16
                          .copyWith(color: Colours.arrow_color),
                      maxLines: 2,
                    ),
                    Gaps.hGap8,
                    child,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCityPickerDialog(
      BuildContext context, CityModel selected) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UserCurrentLocationProvider>(
          builder: (_, userLoc, __) => AlertDialog(
            title: Text(S.of(context).locationSelectCityMessage),
            content: Container(
              height: 600.0,
              width: 300.0,
              child: Column(children: <Widget>[
                Expanded(
                  child: AzListView(
                      header: AzListViewHeader(
                          builder: (_) {
                            CityModel currentCity;
                            if (userLoc.currentLocation != null)
                              currentCity = _cities.firstWhere(
                                  (x) => x.cityName == userLoc.currentLocation,
                                  orElse: () => null);
                            return CurrentLocation(currentCity, widget.locale);
                          },
                          height: 60),
                      data: userLoc.currentLocation == null
                          ? _cities
                          : _cities
                              .where(
                                  (x) => x.cityName != userLoc.currentLocation)
                              .toList(),
                      isUseRealIndex: true,
                      itemHeight: 40,
                      suspensionWidget: null,
                      suspensionHeight: 0,
                      itemBuilder: (context, city) {
                        return _buildListTile(city);
                      }),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListTile(CityModel city) {
    final bool selected = Provider.of<LocationProvider>(context, listen: false)
            .selected
            ?.cityName ==
        city.cityName;
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: selected
                ? Icon(Icons.keyboard_arrow_right)
                : Container(
                    width: 20,
                  ),
            selected: selected,
            onTap: () {
              Provider.of<LocationProvider>(context, listen: false)
                  .selectPlace(city);
              NavigatorUtils.goBack(context);
            },
            title: Text(
              city.getCityName(widget.locale, fullName: true),
              style: TextStyle(
                  color: ThemeUtils.getIconColor(context),
                  fontSize: Dimens.font_sp16),
            ),
          ),
          Gaps.line
        ],
      ),
    );
  }

  void _loadData() async {
    var jsonCities;
    if (Constant.isTest) {
      jsonCities = await loadString('assets/data/cities.json');
    } else {
      jsonCities = await rootBundle.loadString('assets/json/cities.json');
    }

    List decoded = json.decode(jsonCities);
    decoded.forEach((f) => _cities.add(CityModel.fromJsonMap(f)));
    _processList(_cities);

    setState(() {});
  }

  Future<String> loadString(String key, {bool cache = true}) async {
    final ByteData data = await rootBundle.load(key);
    if (data == null) throw FlutterError('Unable to load asset: $key');
    return utf8.decode(data.buffer.asUint8List());
  }

  void _processList(List<CityModel> list) {
    if (list == null || list.isEmpty) return;
    for (var c in list) {
      String tag = c.getFirstChar(widget.locale);
      if (RegExp("[A-Z]").hasMatch(tag)) {
        c.tagIndex = tag;
      } else {
        c.tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cities);
  }

  @override
  void didUpdateWidget(LocationHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    //call process list again during rebuild. etc switch language
    _processList(_cities);
    _fetchCurrentLocation();
  }

  void _fetchCurrentLocation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _preCacheImage();
      await LocationUtils.getCurrentLocation(context);
    });
  }
}
