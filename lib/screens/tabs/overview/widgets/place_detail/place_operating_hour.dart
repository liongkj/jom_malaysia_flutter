import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/operating_hours_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/place_detail/operating_hours_dialog.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/util/utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';

class OperatingHour extends StatelessWidget {
  final List<OperatingHours> operatingHours;

  OperatingHour(this.operatingHours);
  @override
  Widget build(BuildContext context) {
    //weekday returns 1-7
    final _today = (DateTime.now().weekday == 7) ? 0 : DateTime.now().weekday;
    final _oh = operatingHours.firstWhere((x) => x.dayOfWeek.index == _today,
        orElse: () => null);
    return Material(
      child: InkWell(
        onTap: () => {},
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const LoadAssetImage("place/icon_wait",
                    width: 18.0, height: 18.0),
                Gaps.hGap12,
                Expanded(
                  flex: 6,
                  child: _oh != null
                      ? Row(children: <Widget>[
                          Text('${_oh.openHour} - ${_oh.closeHour}'),
                          Gaps.hGap15,
                          !_oh.isOpen
                              ? Text(
                                  S.of(context).placeDetailOperatingCloseLabel,
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )
                              : !_oh.closingSoon
                                  ? Text(
                                      S
                                          .of(context)
                                          .placeDetailOperatingOpenLabel,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  : Text(
                                      S
                                          .of(context)
                                          .placeDetailOperatingSoonLabel,
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                        ])
                      : Row(
                          children: <Widget>[
                            Text(
                              S.of(context).placeDetailOperatingCloseLabel,
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            )
                          ],
                        ),
                ),
                Gaps.vLine,
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.navigate_next,
                      size: 24,
                      color: ThemeUtils.getIconColor(context),
                    ),
                    onPressed: () {
                      showElasticDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return OperatingHoursDialog(
                              hours: operatingHours,
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
