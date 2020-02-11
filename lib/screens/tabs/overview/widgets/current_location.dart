import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatefulWidget {
  final String address;
  //final Position position;
  const CurrentLocation({
    this.address,
    //this.position,
    Key key,
  }) : super(key: key);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _preCacheImage();
      await LocationUtils.getCurrentLocation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              location.currentLocation ?? "Gps not open",
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
