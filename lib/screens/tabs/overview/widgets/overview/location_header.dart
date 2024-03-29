import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/overview/current_location.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

List<CityModel> _parseCity(String json) {
  final parsed = jsonDecode(json).cast<Map<String, dynamic>>();

  return parsed.map<CityModel>((json) => CityModel.fromJsonMap(json)).toList();
}

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
    // _fetchCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).iconTheme.color;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leading: null,
      // brightness: Brightness.dark,
      actions: <Widget>[
        // SearchBarButton(
        IconButton(
          icon: LoadAssetImage(
            "overview/icon_search",
            color: iconColor,
            width: 24,
          ),
          onPressed: () =>
              NavigatorUtils.push(context, OverviewRouter.placeSearchPage),
        ),
      ],
      backgroundColor: Colours.dark_button_text,
      floating: true,
      // 不随着滑动隐藏标题
      snap: true,
      pinned: false,
      // 固定在顶部
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
        title: _buildHeaderTitle(context),
      ),
    );
  }

  GestureDetector _buildHeaderTitle(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCityPickerDialog(context, selectedLocation),
      child: Container(
        height: kExpandedHeight * 0.3,
        // padding: const EdgeInsets.only(left: 12, right: 16.0),
        child: Consumer<LocationProvider>(
          child: const Icon(
            Icons.keyboard_arrow_down,
            color: Colours.arrow_color,
          ),
          builder: (_, location, icon) {
            selectedLocation = _cities.isNotEmpty && location.selected != null
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
                icon,
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showCityPickerDialog(context, selected) async {
    _fetchCurrentLocation();
    return showDialog(
      context: context,
      builder: (context) {
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
                          height: 60,
                          builder: (_) {
                            CityModel currentCity;
                            if (userLoc.currentLocation != null)
                              currentCity = _cities.firstWhere(
                                  (x) => x.cityName == userLoc.currentLocation,
                                  orElse: () => null);
                            return CurrentLocation(currentCity, widget.locale);
                          },
                        ),
                        data: userLoc.currentLocation == null
                            ? _cities
                            : _cities
                                .where((x) =>
                                    x.cityName != userLoc.currentLocation)
                                .toList(),
                        isUseRealIndex: true,
                        itemHeight: 40,
                        suspensionWidget: null,
                        suspensionHeight: 0,
                        itemBuilder: (context, city) => _buildListTile(city))),
              ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListTile(CityModel city) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final bool selected = locationProvider.selected?.cityName == city.cityName;
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
              locationProvider.selectPlace(city);
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
    try {
      String jsonCities = await DefaultAssetBundle.of(context)
          .loadString('assets/json/cities.json');

      _cities = await compute(_parseCity, jsonCities);
      _processList(_cities);

      setState(() {});
    } catch (e) {
      showToast(e);
    }
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
    _processList(_cities);
  }

  void _fetchCurrentLocation() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await LocationUtils.getCurrentLocation(context);
    });
  }
}
