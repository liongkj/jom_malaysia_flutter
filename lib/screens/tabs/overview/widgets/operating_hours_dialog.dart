import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/day_of_week_enum.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/date_utils_.dart';
import 'package:jom_malaysia/widgets/base_dialog.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class OperatingHoursDialog extends StatelessWidget {
  OperatingHoursDialog({
    Key key,
    this.hours,
  }) : super(key: key);

  final List<OperatingHours> hours;

  Widget getItem(DayOfWeek day) {
    final OperatingHours today =
        hours.firstWhere((x) => x.dayOfWeek == day, orElse: () => null);

    return Container(
      child: SizedBox(
        height: 42.0,
        child: Row(
          children: <Widget>[
            Gaps.hGap16,
            Expanded(child: Text(Utils.weekdays[day.index])),
            Expanded(
              flex: 3,
              child: today == null
                  ? Text("Closed")
                  : Text('${today.openHour} - ${today.closeHour}'),
            ),
            LoadAssetImage(
                today != null ? "overview/icon_done" : "overview/icon_close",
                width: 16.0,
                height: 16.0),
            Gaps.hGap16,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "Opening hours",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getItem(DayOfWeek.Sunday),
          getItem(DayOfWeek.Monday),
          getItem(DayOfWeek.Tuesday),
          getItem(DayOfWeek.Wednesday),
          getItem(DayOfWeek.Thursday),
          getItem(DayOfWeek.Friday),
          getItem(DayOfWeek.Saturday),
        ],
      ),
      onPressed: () {
        NavigatorUtils.goBack(context);
      },
    );
  }
}
