import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/enums/category_type_enum.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/core/res/resources.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_search_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/search/search_bar.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/my_rating_bar.dart';
import 'package:jom_malaysia/widgets/my_refresh_list.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class PlaceSearchPage extends StatefulWidget {
  @override
  PlaceSearchPageState createState() => PlaceSearchPageState();
}

class PlaceSearchPageState
    extends BasePageState<PlaceSearchPage, PlaceSearchPresenter> {
  BaseListProvider<ListingModel> provider = BaseListProvider<ListingModel>();
  String _keyword;
  int _page = 1;
  Locale locale;
  @override
  void initState() {
    provider.setStateTypeNotNotify(StateType.empty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locale = Provider.of<LanguageProvider>(context, listen: false).locale ??
        Localizations.localeOf(context);
    return ChangeNotifierProvider<BaseListProvider<ListingModel>>(
      create: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: S.of(context).labelSearchHint,
          onPressed: (text) {
            if (text.isEmpty) {
              showToast(S.of(context).labelSearchHintNotEmpty);
              return;
            }
            FocusScope.of(context).unfocus();
            _keyword = text;
            provider.setStateType(StateType.loading);
            _page = 1;
            presenter.search(_keyword, _page, true, locale: locale);
          },
        ),
        body: Consumer<BaseListProvider<ListingModel>>(
            builder: (_, provider, __) {
          return DeerListView(
            key: Key('order_search_list'),
            itemCount: provider.list.length,
            stateType: provider.stateType,
            onRefresh: _onRefresh,
            loadMore: _loadMore,
            itemExtent: 50.0,
            hasMore: provider.hasMore,
            itemBuilder: (_, index) {
              return _BuildListTile(provider.list[index]);
            },
          );
        }),
      ),
    );
  }

  @override
  PlaceSearchPresenter createPresenter() {
    return new PlaceSearchPresenter();
  }

  Future _onRefresh() async {
    _page = 1;
    await presenter.search(_keyword, _page, false, locale: locale);
  }

  Future _loadMore() async {
    _page++;
    await presenter.search(_keyword, _page, false, locale: locale);
  }
}

class _BuildListTile extends StatelessWidget {
  _BuildListTile(this.place);
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        NavigatorUtils.push(
            context, '${OverviewRouter.placeDetailPage}/${place.listingId}');
      },
      leading: Icon(
        _getTypeIcon(place.categoryType),
      ),
      title: Text(
        place.listingName,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.title.copyWith(fontSize: 14.0),
      ),
      isThreeLine: true,
      subtitle: _BuildSubtitle(place),
      trailing: Text(place.address.city),
    );
  }

  IconData _getTypeIcon(CategoryType category) {
    switch (category) {
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
  final ListingModel place;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            MyRatingBar(
              rating: 0.0,
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              place.category.subcategory.categoryName,
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.hGap8,
            Gaps.vLine,
            Gaps.hGap8,
            Text(
              place.category.category.categoryName,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      ],
    );
  }
}
