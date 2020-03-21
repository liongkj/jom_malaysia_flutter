import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
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
    final CityModel currentSelected =
        Provider.of<LocationProvider>(context, listen: false).selected;
    final city = cityModel?.getCityName(locale, fullName: true);
    final bool isSelected = currentSelected?.cityName == cityModel?.cityName;
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            selected: isSelected,
            onTap: () async {
              if (cityModel != null) {
                Provider.of<LocationProvider>(context, listen: false)
                    .selectPlace(cityModel);
                NavigatorUtils.goBack(context);
              }
              await LocationUtils.getCurrentLocation(context);
            },
            leading: city != null
                ? Icon(
                    Icons.location_on,
                    color: Colors.orangeAccent,
                  )
                : Icon(
                    Icons.location_off,
                    size: 28.0,
                    color: ThemeUtils.getIconColor(context),
                  ),
            title: Consumer<UserCurrentLocationProvider>(
              builder: (context, provider, providerChild) {
                switch (provider.locState) {
                  case LocationState.loading:
                    return Text("Locating");
                    break;
                  case LocationState.noPermit:
                    return Text("Gps disabled");
                    break;
                  case LocationState.found:
                    return city == null
                        ? Text(
                            "Not in service area",
                            style: TextStyle(
                                color: ThemeUtils.getIconColor(context),
                                fontSize: Dimens.font_sp12),
                          )
                        : Text(city);
                    break;
                  default:
                    return Text("Error");
                }
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
