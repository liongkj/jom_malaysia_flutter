import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatelessWidget {
  final String address;
  //final Position position;
  const CurrentLocation({
    this.address,
    //this.position,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (_, langauge, __) {
      return Container(
        child: Row(
          children: <Widget>[
            Icon(
              langauge.currentLocation == null ? Icons.warning : Icons.near_me,
              size: Dimens.font_sp16,
              color: ThemeUtils.getIconColor(context),
            ),
            Gaps.hGap8,
            Text(
              langauge.currentLocation ?? "Gps not open",
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
