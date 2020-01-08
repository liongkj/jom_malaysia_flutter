import 'dart:convert';

import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/current_location.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

class LocationHeader extends StatefulWidget {
  const LocationHeader({Key key}) : super(key: key);

  @override
  _LocationHeaderState createState() => _LocationHeaderState();
}

class _LocationHeaderState extends State<LocationHeader> {
//Load Cities from json file
  List<String> _cities = [];
  void _loadData() async {
    var jsonCities = await rootBundle.loadString('assets/json/cities.json');
    setState(() {
      _cities = (jsonDecode(jsonCities) as List<dynamic>).cast<String>();
    });
    //print(_cities);
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
          GestureDetector(
            // key: _buttonKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Consumer<LocationProvider>(builder: (_, location, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      location.selected ?? "Select a City",
                      style: TextStyles.textBold16,
                    ),
                    //statelist drop down
                    IconButton(
                      onPressed: () {
                        //Location Selector Starts Here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Select a City'),
                              content: Container(
                                height: 600.0,
                                width: 300.0,
                                child: AlphabetListScrollView(
                                  showPreview: true,
                                  strList: _cities,
                                  indexedHeight: (i) => 40,
                                  keyboardUsage: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        Provider.of<LocationProvider>(context,
                                                listen: false)
                                            .selectPlace(_cities[index]);
                                        Navigator.pop(context);
                                      },
                                      title: Text(_cities[index]),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: ThemeUtils.getIconColor(context),
                      ),
                    ),
                  ],
                );
              }),
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
          background: ThemeUtils.isDark(context)
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
          title: CurrentLocation(),
        ),
      ),
    );
  }
}
