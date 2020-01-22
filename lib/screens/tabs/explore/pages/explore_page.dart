import 'package:flutter/material.dart';
import 'package:jom_malaysia/generated/l10n.dart';
import 'package:jom_malaysia/screens/tabs/explore/pages/overview_tab.dart';
import 'package:jom_malaysia/screens/tabs/explore/pages/todo_tab.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:jom_malaysia/widgets/app_bar.dart';
import 'package:jom_malaysia/widgets/my_card.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    List<Choice> choices = <Choice>[
      Choice(
          title: S.of(context).tabTitleExploreOverview,
          icon: Icons.featured_play_list),
      Choice(title: S.of(context).tabTitleExploreTodo, icon: Icons.done),
      // const Choice(title: 'TRANSPORT', icon: Icons.directions),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 20,
        title: Text(S.of(context).appBarTitleExplore),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.title,
              icon: Icon(choice.icon),
            );
          }).toList(),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          OverviewTab(),
          TodoTab(),
          // MyCard(
          //   child: Container(
          //     child: Text("Transport"),
          //   ),
          // )
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
