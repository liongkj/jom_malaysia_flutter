import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  SearchResultProvider searchProvider;
  TextEditingController _controller;
  FocusNode _focusNode;

  _getSuggestion() {}

  @override
  void initState() {
    searchProvider = Provider.of<SearchResultProvider>(context, listen: false);
    _controller = TextEditingController()..addListener(_getSuggestion);
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchProvider.clearOldResult();
      FocusScope.of(context).requestFocus(_focusNode);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locale = Provider.of<LanguageProvider>(context, listen: false).locale ??
        Localizations.localeOf(context);

    return Scaffold(
        appBar: SearchBar(
          controller: _controller,
          hintText: S.of(context).labelSearchHint,
          suggestionController: (value) => searchProvider.getSuggestions(value),
          onPressed: (text) {
            if (text.isEmpty) {
              showToast(S.of(context).labelSearchHintNotEmpty);
              return;
            }
            FocusScope.of(context).unfocus();
            _keyword = text;
            searchProvider.setStateType(StateType.loading);
            _page = 1;
            searchProvider.search(_keyword, _page, locale: locale);
          },
          focusNode: _focusNode,
        ),
        body: Consumer<SearchResultProvider>(builder: (_, provider, __) {
          return provider.showResult
              ? DeerListView(
                  key: Key('place_search_list'),
                  itemCount: provider.result.length,
                  stateType: provider.stateType,
                  loadMore: _loadMore,
                  itemExtent: 90.0,
                  hasMore: false,
                  itemBuilder: (_, index) {
                    debugPrint("printing search results");
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SearchResultItem(provider.result[index]),
                    );
                  },
                )
              : DeerListView(
                  key: Key('place_search_history'),
                  itemCount: provider.history.length,
                  stateType: provider.stateType,
                  loadMore: _loadMore,
                  itemExtent: 40.0,
                  hasMore: false,
                  itemBuilder: (_, index) {
                    return ListTile(
                      dense: true,
                      onTap: () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          FocusScope.of(context).unfocus();
                          provider.search(provider.history[index], 1);
                          _controller.clear();
                        });
                      },
                      leading: Icon(Icons.history),
                      title: Text(provider.history[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever),
                        onPressed: () => provider.history.removeAt(index),
                      ),
                    );
                  });
        }));
  }

  Future _loadMore() async {
    _page++;
    await searchProvider.search(_keyword, _page, locale: locale);
  }
}
