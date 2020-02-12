import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/explore/pages/overview_tab.dart';
import 'package:jom_malaysia/screens/tabs/explore/pages/todo_tab.dart';
import 'package:jom_malaysia/util/image_utils.dart';
import 'package:jom_malaysia/widgets/load_image.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ExplorePage> {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCacheImage();
    });
  }

  _preCacheImage() {
    precacheImage(
        ImageUtils.getAssetImage('explore/featured/pd_bird_eye', format: "jpg"),
        context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Choice> choices = <Choice>[
      Choice(
          title: S.of(context).tabTitleExploreOverview,
          icon: Icons.featured_play_list),
      Choice(title: S.of(context).tabTitleExploreTodo, icon: Icons.done),
      // const Choice(title: 'TRANSPORT', icon: Icons.directions),
    ];
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.redAccent,
              expandedHeight: 200.0,
              floating: false,
              title: Text(S.of(context).appBarTitleExplore),
              pinned: false,
              bottom: TabBar(
                indicatorColor: Colors.white,
                controller: _tabController,
                tabs: choices.map(
                  (Choice choice) {
                    return Tab(
                      text: choice.title,
                      icon: Icon(choice.icon),
                    );
                  },
                ).toList(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background:
                    LoadImage("explore/featured/pd_bird_eye", format: "jpg"),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            OverviewTab(),
            TodoTab(),
          ],
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
