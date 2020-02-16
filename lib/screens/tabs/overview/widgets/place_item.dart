import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/location/location_utils.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/location_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/provider/user_current_location_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_rating_bar.dart';
import 'package:provider/provider.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({
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
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            8.0,
            8.0,
            16.0,
            8.0,
          ),
          child: InkWell(
            onTap: () {
              NavigatorUtils.push(context,
                  '${OverviewRouter.placeDetailPage}/${listing.listingId}');
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: LoadImage(
                      listing.listingImages.coverPhoto.url,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: _Description(listing: listing),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key key,
    @required this.listing,
  }) : super(key: key);

  final ListingModel listing;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context, listen: false).locale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          listing.listingName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Gaps.vGap8,
        Row(
          children: <Widget>[
            Expanded(
              child: MyRatingBar(rating: 4),
            ),
            Text(
              '"${listing.tags[0]}"',
              style: TextStyle(
                  fontSize: Dimens.font_sp12,
                  color: Theme.of(context).errorColor),
            )
          ],
        ),
        Gaps.vGap8,
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                listing.category
                    .getSubcategory(lang ?? Localizations.localeOf(context)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Consumer<LocationProvider>(
              builder: (_, selectedCity, locChild) =>
                  Consumer<UserCurrentLocationProvider>(
                builder: (_, userLocation, __) {
                  return FutureBuilder<String>(
                      future: LocationUtils.getDistanceBetween(
                          userLocation.currentCoordinate,
                          listing,
                          selectedCity.cityModel),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? Text(
                                snapshot.data,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(fontSize: Dimens.font_sp10),
                              )
                            : Text("N/A");
                      });
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
