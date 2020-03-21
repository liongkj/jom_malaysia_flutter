import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
            // title: FutureBuilder<Position>(
            //   initialData: null,
            //   future: LocationUtils.getCurrentLocation(context),
            //   builder: (context, dataSnapshot) {
            //     if (dataSnapshot.connectionState == ConnectionState.waiting) {
            //       return Text("Locating..");
            //     } else if (dataSnapshot.connectionState == ConnectionState.done)
            //       return dataSnapshot.data == null
            //           ? Text("Please enable GPS")
            //           : Text(
            //               city == null ? "Not in service area" : city,
            //               style: TextStyle(
            //                   color: ThemeUtils.getIconColor(context),
            //                   fontSize: Dimens.font_sp16),
            //             );
            //     else {
            //       return (Text("Error"));
            //     }
            //   },
            // ),
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
