import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatefulWidget {
  final List<CityModel> cities;
  const CurrentLocation(
    this.cities, {
    Key key,
  }) : super(key: key);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  CityModel currentCity;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LanguageProvider>(context, listen: false).locale;
    return Consumer<UserCurrentLocationProvider>(builder: (_, location, __) {
      return Container(
        child: Row(
          children: <Widget>[
            Icon(
              location.currentLocation == null ? Icons.warning : Icons.near_me,
              size: Dimens.font_sp16,
              color: ThemeUtils.getIconColor(context),
            ),
            Gaps.hGap8,
            Text(
              currentCity == null
                  ? "Not in service area"
                  : currentCity.getCityName(locale),
              //position.latitude.toString()+','+position.longitude.toString(),
              style: TextStyle(
                  color: ThemeUtils.getIconColor(context),
                  fontSize: Dimens.font_sp16),
            ),
          ],
        ),
      );
    });
  }
}
