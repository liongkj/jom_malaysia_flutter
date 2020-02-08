import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/current_location.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:jom_malaysia/widgets/search_bar_button.dart';
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

const kExpandedHeight = 113.0;

class _LocationHeaderState extends State<LocationHeader> {
//Load Cities from json file
  List<CityModel> _cities = [];
  var selectedLocationStr;
  CityModel selectedLocation;

  void _loadData() async {
    var jsonCities;
    if (Constant.isTest) {
      jsonCities = await loadString('assets/data/city.json');
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
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverAppBar(
        leading: Gaps.empty,
        brightness: Brightness.dark,
        actions: <Widget>[
          SearchBarButton(
            hintText: "Search for a name or keyword",
            onTap: () {
              print("tap");
              NavigatorUtils.push(context, OverviewRouter.placeSearchPage);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.notifications),
          ),
          // overflow menu
        ],

        backgroundColor: Colors.transparent,

        elevation: 0.0,
        centerTitle: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.18,
        floating: false, // 不随着滑动隐藏标题
        pinned: true, // 固定在顶部
        flexibleSpace: MyFlexibleSpaceBar(
          background: ThemeUtils.isDark(context)
              ? Container(
                  height: 113.0,
                  color: Colours.dark_bg_color,
                )
              : const LoadAssetImage(
                  "overview/overview_bg",
                  width: double.infinity,
                  height: 113.0,
                  fit: BoxFit.fill,
                ),
          centerTitle: true,
          titlePadding:
              const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: GestureDetector(
            onTap: () => _showCityPickerDialog(context),
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Consumer<LocationProvider>(
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                builder: (_, location, child) {
                  selectedLocation =
                      _cities.isNotEmpty && location.selected != null
                          ? _cities.firstWhere(
                              (x) => x.cityName == location.selected,
                              orElse: null)
                          : null;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        selectedLocation == null
                            ? S.of(context).locationSelectCityMessage
                            : selectedLocation.getCityName(widget.locale),
                        style: TextStyles.textBold16,
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
      ),
    );
  }

  Future _showCityPickerDialog(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);

    Color iconColor = isDark ? Colours.dark_text_gray : Colours.text_gray_c;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LocationProvider>(
          builder: (_, locationProvider, child) {
            final selected = locationProvider.cityModel;
            var c = selected == null
                ? S.of(context).labelNone
                : selected.getCityName(
                    widget.locale,
                    fullName: true,
                  );
            return AlertDialog(
              title: Text(S.of(context).locationSelectCityMessage),
              content: Container(
                height: 600.0,
                width: 300.0,
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          S.of(context).cityPickerCurrentCity(
                                c,
                              ),
                        ),
                      ),
                      if (selected != null)
                        IconButton(
                          onPressed: Provider.of<LocationProvider>(context,
                                  listen: false)
                              .clear,
                          icon: LoadAssetImage(
                            "place/place_delete",
                            color: iconColor,
                            width: 18,
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: AzListView(
                      header: AzListViewHeader(
                          builder: (_) {
                            return CurrentLocation();
                          },
                          height: 100),
                      data: _cities,
                      isUseRealIndex: true,
                      itemHeight: 40,
                      suspensionWidget: null,
                      suspensionHeight: 0,
                      itemBuilder: (context, city) => _buildListTile(city),
                    ),
                  ),
                ]),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildListTile(CityModel city) {
    return ListTile(
      onTap: () {
        Provider.of<LocationProvider>(context, listen: false).selectPlace(city);
        NavigatorUtils.goBack(context);
      },
      title: Text(
        city.getCityName(widget.locale, fullName: true),
      ),
    );
  }
}
