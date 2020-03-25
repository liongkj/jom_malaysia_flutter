import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/search_result_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/search/search_bar.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/search/search_results_item.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/widgets/my_refresh_list.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class PlaceSearchPage extends StatefulWidget {
  @override
  _PlaceSearchPageState createState() => _PlaceSearchPageState();
}

class _PlaceSearchPageState extends State<PlaceSearchPage> {
  String _keyword;
  int _page = 1;
  Locale locale;
  SearchResultProvider pro;

  @override
  Widget build(BuildContext context) {
    locale = Provider.of<LanguageProvider>(context, listen: false).locale ??
        Localizations.localeOf(context);
    pro = Provider.of<SearchResultProvider>(context, listen: false);
    return Scaffold(
      appBar: SearchBar(
        hintText: S.of(context).labelSearchHint,
        onPressed: (text) {
          if (text.isEmpty) {
            showToast(S.of(context).labelSearchHintNotEmpty);
            return;
          }
          FocusScope.of(context).unfocus();
          _keyword = text;
          pro.setStateType(StateType.loading);
          _page = 1;
          pro.search(_keyword, _page, locale: locale);
        },
      ),
      body: Consumer<SearchResultProvider>(builder: (_, provider, __) {
        return DeerListView(
          key: Key('place_search_list'),
          itemCount: provider.result.length,
          stateType: provider.stateType,
          loadMore: _loadMore,
          itemExtent: 90.0,
          hasMore: false,
          itemBuilder: (_, index) {
            // return Container(
            //   child: Text(provider.result[index].objectId),
            // );
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SearchResultItem(provider.result[index]),
            );
          },
        );
      }),
    );
  }

  Future _loadMore() async {
    _page++;
    await pro.search(_keyword, _page, locale: locale);
  }
}
