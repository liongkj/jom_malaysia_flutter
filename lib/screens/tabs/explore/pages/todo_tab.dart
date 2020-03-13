import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/explore/providers/featured_place_provider.dart';
import 'package:jom_malaysia/screens/tabs/explore/widgets/attraction_card.dart';
import 'package:jom_malaysia/screens/tabs/overview/overview_router.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({
    Key key,
  }) : super(key: key);

  @override
  TodoTabState createState() => TodoTabState();
}

class TodoTabState extends State<TodoTab> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // presenter.fetchFeaturedListing();
    _onRefresh();
  }

  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final lang = Provider.of<LanguageProvider>(context, listen: false).locale;
    return SafeArea(
      child: NotificationListener(
        onNotification: (ScrollNotification note) {
          if (note.metrics.pixels == note.metrics.maxScrollExtent) {
            _loadMore();
          }
          return true;
        },
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement:
              MediaQuery.of(context).size.height * 0.06, //40 + 120(header)
          child: CustomScrollView(slivers: <Widget>[
            Consumer<FeaturedPlaceProvider>(
              builder: (_, provider, child) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  sliver: provider.featured.isEmpty
                      ? SliverFillRemaining(
                          child: StateLayout(type: provider.stateType),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              final place = provider.featured[index];
                              return AttractionCard(
                                name: place.listingName,
                                description: place.description?.getDescription(
                                  lang ?? Localizations.localeOf(context),
                                ),
                                onTap: () {
                                  NavigatorUtils.push(context,
                                      '${OverviewRouter.placeDetailPage}/${place.listingId}');
                                },
                                image: place.listingImages.listingLogo.url,
                              );
                            },
                            childCount: provider.featured.length,
                          ),
                        ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

  List _list = [];

  Future<void> _onRefresh() async {
    await Provider.of<FeaturedPlaceProvider>(context, listen: false)
        .fetchFeaturedListing(refresh: true);
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page++;
        _isLoading = false;
      });
    });
  }
}
