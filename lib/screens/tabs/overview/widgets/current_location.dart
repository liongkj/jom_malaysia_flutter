import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatelessWidget {
  final CityModel cityModel;
  final Locale locale;
  const CurrentLocation(
    this.cityModel,
    this.locale, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final city = cityModel?.getCityName(locale, fullName: true);
    final bool selected =
        Provider.of<LocationProvider>(context, listen: false).selected ==
            cityModel?.cityName;
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            selected: selected,
            onTap: () {
              Provider.of<LocationProvider>(context, listen: false)
                  .selectPlace(cityModel);
              NavigatorUtils.goBack(context);
            },
            leading: city != null
                ? Icon(Icons.my_location)
                : Icon(
                    Icons.warning,
                    size: 28.0,
                    color: ThemeUtils.getIconColor(context),
                  ),
            title: FutureBuilder<bool>(
              initialData: false,
              future: LocationUtils.isLocationServiceDisabled(),
              builder:
                  (BuildContext context, AsyncSnapshot<bool> dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return Text("GPS Disabled");
                } else
                  return Text(
                    city == null ? "Not in service area" : city,
                    //position.latitude.toString()+','+position.longitude.toString(),
                    style: TextStyle(
                        color: ThemeUtils.getIconColor(context),
                        fontSize: Dimens.font_sp16),
                  );
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async =>
                  await LocationUtils.getCurrentLocation(context),
            ),
          ),
          Gaps.line
        ],
      ),
    );
  }
}
