import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/core/services/search/place_search_result_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/load_image.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:jom_malaysia/widgets/my_rating_bar.dart';

class SearchResultItem extends StatelessWidget {
  SearchResultItem(this.result);
  final PlaceSearchResult result;
  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListTile(
          leading: result.photo == null
              ? Container(
                  width: 80,
                  child: Icon(
                    _getTypeIcon(result.categoryType),
                    size: 50,
                  ),
                )
              : LoadImage(
                  result.photo,
                  width: 80,
                  height: 65,
                ),
          title: Text(
            result.listingName,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
          ),

          subtitle: _BuildSubtitle(result),
          isThreeLine: false,
          // trailing: Container(),
          onTap: () => NavigatorUtils.push(
              context, '${OverviewRouter.placeDetailPage}/${result.objectId}'),
        ),
      ),
    );
  }

  IconData _getTypeIcon(String category) {
    CategoryType cat = CategoryType.values.firstWhere(
        (x) =>
            x.toString().toLowerCase() ==
            "CategoryType.$category".toLowerCase(),
        orElse: () => null);
    switch (cat) {
      case CategoryType.Private:
        return Icons.restaurant;
        break;
      case CategoryType.Attraction:
        return Icons.local_play;
        break;
      case CategoryType.Government:
        return Icons.location_city;
        break;
      case CategoryType.Professional:
        return Icons.work;
        break;
      case CategoryType.Nonprofit:
        return Icons.people;
        break;
      default:
        return Icons.search;
    }
  }
}

class _BuildSubtitle extends StatelessWidget {
  _BuildSubtitle(this.place);
  final PlaceSearchResult place;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Gaps.vGap4,
          MyRatingBar(
            rating: 3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(place.address.city),
              Gaps.hGap8,
              Gaps.vLine,
              Gaps.hGap8,
              Text(
                place.category.en[0],
                style: Theme.of(context).textTheme.subtitle,
              ),
              Gaps.hGap4,
              Text("/"),
              Gaps.hGap4,
              Text(
                place.category.en[1],
                style: Theme.of(context).textTheme.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
