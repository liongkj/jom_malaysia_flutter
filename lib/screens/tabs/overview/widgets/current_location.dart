import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/util/theme_utils.dart';

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
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.near_me,
            size: Dimens.font_sp16,
            color: ThemeUtils.getIconColor(context),
          ),
          Gaps.hGap8,
          Text(
            address,
            //position.latitude.toString()+','+position.longitude.toString(),
            style: TextStyle(
                color: ThemeUtils.getIconColor(context),
                fontSize: Dimens.font_sp16),
          ),
        ],
      ),
    );
  }
}
