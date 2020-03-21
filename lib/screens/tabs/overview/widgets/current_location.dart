import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:oktoast/oktoast.dart';
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
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final CityModel currentSelected = locationProvider.selected;
    final city = cityModel?.getCityName(locale, fullName: true);
    final bool isSelected = currentSelected?.cityName == cityModel?.cityName;
    return Container(
      child: Column(
        children: <Widget>[
          Consumer<UserCurrentLocationProvider>(
              builder: (context, provider, providerChild) {
            Widget tile;
            switch (provider.locState) {
              case LocationState.found:
                tile = _CurrentLocationSelector(
                    isSelected: isSelected,
                    cityModel: cityModel,
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.orangeAccent,
                    ),
                    title: city == null
                        ? Text(
                            "Not in service area",
                            style: TextStyle(
                                color: ThemeUtils.getIconColor(context),
                                fontSize: Dimens.font_sp12),
                          )
                        : Text(city),
                    city: city);
                break;
              case LocationState.noPermit:
                tile = _CurrentLocationSelector(
                    isSelected: isSelected,
                    cityModel: cityModel,
                    leading: Icon(
                      Icons.location_off,
                      color: Colors.redAccent,
                    ),
                    title: Text("Gps disabled"),
                    city: city);
                break;
              case LocationState.loading:
                tile = _CurrentLocationSelector(
                    isSelected: isSelected,
                    cityModel: cityModel,
                    leading: Icon(Icons.location_searching),
                    title: Text("Fetching"),
                    city: city);
                break;
              case LocationState.empty:
                tile = _CurrentLocationSelector(
                    isSelected: isSelected,
                    cityModel: cityModel,
                    leading: Icon(Icons.error_outline),
                    title: Text("Unknown error"),
                    city: city);
                break;
            }
            return tile;
          }),
          Gaps.line
        ],
      ),
    );
  }
}

class _CurrentLocationSelector extends StatelessWidget {
  const _CurrentLocationSelector(
      {Key key,
      @required this.isSelected,
      @required this.cityModel,
      @required this.city,
      @required this.title,
      @required this.leading})
      : super(key: key);

  final bool isSelected;
  final CityModel cityModel;
  final Icon leading;
  final Text title;
  final String city;

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return ListTile(
      selected: isSelected,
      onTap: () async {
        if (await LocationUtils.isLocationServiceDisabled())
          showToast("Please grant location service permission from setting");
        if (cityModel != null) {
          locationProvider.selectPlace(cityModel);
          NavigatorUtils.goBack(context);
        } else {
          await LocationUtils.getCurrentLocation(context);
        }
      },
      leading: leading,
      title: title,
      trailing: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () async {
            if (await LocationUtils.isLocationServiceDisabled())
              showToast(
                  "Please enable location service permission from settings");
            else
              await LocationUtils.getCurrentLocation(context);
          }),
    );
  }
}
