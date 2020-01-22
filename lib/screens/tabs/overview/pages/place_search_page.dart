import 'package:flutter/material.dart';
import 'package:jom_malaysia/core/mvp/base_page_state.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/search_item.dart';
import 'package:jom_malaysia/screens/tabs/overview/presenter/place_search_presenter.dart';
import 'package:jom_malaysia/setting/provider/base_list_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/widgets/my_refresh_list.dart';
import 'package:jom_malaysia/widgets/search_bar.dart';
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
          hintText: "Search for a name or keyword",
          onPressed: (text) {
            if (text.isEmpty) {
              showToast("Keyword cannot be blank");
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
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: Alignment.centerLeft,
                child: Text(provider.list[index].listingName),
              );
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
