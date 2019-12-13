import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/date_utils_.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_rating.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.tabIndex,
    @required this.index,
  }) : super(key: key);

  final int tabIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () =>
                NavigatorUtils.push(context, OverviewRouter.placeDetailPage),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: LoadImage(
                    "overview/restaurant-thumbnail",
                    width: 72.0,
                    height: 72.0,
                    fit: BoxFit.fill,
                  ),
                ),
                //place summary
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Restoran Abu",
                              style: TextStyle(
                                fontSize: Dimens.font_sp12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Chinese Restaurant",
                                style: TextStyle(
                                  fontSize: Dimens.font_sp10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Rating(rating: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
