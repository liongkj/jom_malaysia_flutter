import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/screens/tabs/overview/providers/search_result_provider.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/search/history_results_item.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/search/search_bar.dart';
import 'package:jom_malaysia/screens/tabs/overview/widgets/search/search_results_item.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/my_refresh_list.dart';
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
  Timer _timer;

  _getSuggestion() {
    var q = _controller.text;
    if (q.length > 2) {
      if (_timer == null || !_timer.isActive)
        _timer = Timer(const Duration(seconds: 1),
            () async => await searchProvider.getSuggestions(q));
    } else
      _timer?.cancel();
  }

  _stopTimer() {
    if (!_focusNode.hasFocus) _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    searchProvider = Provider.of<SearchResultProvider>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchProvider.clearOldResult());
    _controller = TextEditingController()..addListener(() => _getSuggestion());
    _focusNode = FocusNode()..addListener(_stopTimer);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locale = Provider.of<LanguageProvider>(context, listen: false).locale ??
        Localizations.localeOf(context);

    return WillPopScope(
      onWillPop: _isSuggestion,
      child: Scaffold(
          appBar: SearchBar(
            controller: _controller,
            hintText: S.of(context).labelSearchHint,
            onPressed: (text) {
              if (text.isEmpty) {
                showToast(S.of(context).labelSearchHintNotEmpty);
                return;
              }
              FocusScope.of(context).unfocus();
              _keyword = text;
              _page = 1;
              searchProvider.search(_keyword, _page, locale: locale);
            },
            focusNode: _focusNode,
          ),
          body: Consumer<SearchResultProvider>(builder: (_, provider, __) {
            debugPrint(provider.resultType.toString());
            debugPrint(provider.stateType.toString());
            var list;
            switch (provider.resultType) {
              case ResultType.search:
                list = DeerListView(
                    key: Key('place_search_list'),
                    searchText: _controller.text,
                    itemCount: provider.result.length,
                    stateType: provider.stateType,
                    loadMore: _loadMore,
                    itemExtent: 90.0,
                    hasMore: false,
                    itemBuilder: (_, index) {
                      return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: SearchResultItem(
                            key: Key("result-$index"),
                            result: provider.result[index],
                            onTap: () {
                              NavigatorUtils.push(context,
                                  '${OverviewRouter.placeDetailPage}/${provider.result[index].objectId}');
                            },
                          ));
                    });
                break;
              case ResultType.suggestion:
                list = DeerListView(
                  key: Key('place_search_suggestion'),
                  searchText: _controller.text,
                  itemCount: provider.suggestions.length,
                  stateType: provider.stateType,
                  loadMore: _loadMore,
                  itemExtent: 90.0,
                  hasMore: false,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SearchResultItem(
                        key: Key("suggestion-$index"),
                        result: provider.suggestions[index],
                        onTap: () {
                          NavigatorUtils.push(context,
                              '${OverviewRouter.placeDetailPage}/${provider.suggestions[index].objectId}');
                        },
                      ),
                    );
                  },
                );
                break;
              case ResultType.history:
                list = DeerListView(
                    searchText: _controller.text,
                    key: Key('place_search_history'),
                    itemCount: provider.history.length,
                    stateType: provider.stateType,
                    loadMore: _loadMore,
                    itemExtent: 40.0,
                    hasMore: false,
                    itemBuilder: (_, index) {
                      return HistoryResultItem(
                        title: provider.history[index],
                        delete: () => provider.removeHistoryAt(index),
                        onTap: () {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            FocusScope.of(context).unfocus();
                            provider.search(provider.history[index], 1);
                            _controller.text = provider.history[index];
                          });
                        },
                      );
                    });
                break;
            }
            return list;
          })),
    );
  }

  Future _loadMore() async {
    _page++;
    await searchProvider.search(_keyword, _page, locale: locale);
  }

  Future<bool> _isSuggestion() async {
    if (searchProvider.resultType == ResultType.search) {
      searchProvider.clearOldResult();
      return Future.value(false);
    }
    if (searchProvider.resultType == ResultType.suggestion) {
      _controller.clear();
      searchProvider.clearOldResult();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
