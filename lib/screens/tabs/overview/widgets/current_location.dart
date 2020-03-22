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
  final CityModel locatedUserCity;
  final Locale locale;
  const CurrentLocation(
    this.locatedUserCity,
    this.locale, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final city = locatedUserCity?.getCityName(locale, fullName: true);

    return Container(
      child: Column(
        children: <Widget>[
          Consumer<UserCurrentLocationProvider>(
              builder: (context, provider, providerChild) {
            Widget tile;
            switch (provider.locState) {
              case LocationState.found:
                tile = _CurrentLocationSelector(
                    locatedUserCity: locatedUserCity,
                    onTap: city == null
                        ? () => showToast("City not in service area")
                        : null,
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.orangeAccent,
                    ),
                    trailing: Gaps.empty,
                    title: city == null
                        ? Text(
                            provider.currentLocation,
                            style: TextStyle(
                                color: ThemeUtils.getIconColor(context),
                                fontSize: Dimens.font_sp12),
                          )
                        : Text(city),
                    city: city);

                break;
              case LocationState.noPermit:
                tile = _CurrentLocationSelector(
                    locatedUserCity: locatedUserCity,
                    leading: Icon(
                      Icons.location_off,
                      color: Colors.redAccent,
                    ),
                    onTap: () async {
                      await LocationUtils.isLocationServiceEnabled(context);
                    },
                    trailing: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          await LocationUtils.isLocationServiceEnabled(context);
                        }),
                    title: Text("No GPS"),
                    city: city);
                break;
              case LocationState.init:
              case LocationState.loading:
                tile = _CurrentLocationSelector(
                    //TODO add animation
                    locatedUserCity: locatedUserCity,
                    leading: Icon(Icons.location_searching),
                    title: Text(
                      "Locating city . . .",
                      style: TextStyles.textBold14,
                    ),
                    trailing: Gaps.empty,
                    city: city);
                break;
              case LocationState.granted:
                tile = _CurrentLocationSelector(
                    locatedUserCity: locatedUserCity,
                    leading: Icon(Icons.error_outline),
                    title: Text("Retry"),
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
      @required this.locatedUserCity,
      @required this.city,
      @required this.title,
      this.onTap,
      this.trailing,
      @required this.leading})
      : super(key: key);

  final CityModel locatedUserCity;
  final Icon leading;
  final Text title;
  final Function onTap;
  final String city;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    final CityModel currentSelectedCity = locationProvider.selected;
    final bool isSelected =
        currentSelectedCity?.cityName == locatedUserCity?.cityName;
    return ListTile(
      selected: isSelected,
      onTap: onTap ??
          () async {
            if (locatedUserCity != null) {
              locationProvider.selectPlace(locatedUserCity);
              NavigatorUtils.goBack(context);
            } else {
              await LocationUtils.getCurrentLocation(context);
            }
          },
      leading: leading,
      title: title,
      trailing: trailing ??
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                await LocationUtils.getCurrentLocation(context);
              }),
    );
  }
}
