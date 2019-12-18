import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_grid_card.dart';
import 'package:jom_malaysia/widgets/my_rating.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key key,
    @required this.tabIndex,
    @required this.index,
    @required this.listing,
  }) : super(key: key);

  final int tabIndex;
  final int index;
  final ListingModel listing;

  @override
  Widget build(BuildContext context) {
    print(listing.listingImages.coverPhoto.url);
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () =>
                NavigatorUtils.push(context, OverviewRouter.placeDetailPage),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: LoadImage(
                    listing.listingImages.coverPhoto.url,
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.contain,
                  ),
                ),
                //place summary
                Gaps.hGap10,
                Row(
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: <Widget>[
                            Text(listing.listingName,
                                style: TextStyles.textBold14,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(listing.category.toString(),
                                      style: TextStyles.textDarkGray12,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Container(
                                  child: Text(listing.tags[0]),
                                ),
                              ],
                            ),
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
