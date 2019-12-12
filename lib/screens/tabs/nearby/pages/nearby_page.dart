import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/nearby/provider/nearby_page_provider.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class NearbyPage extends StatefulWidget {
  NearbyPage({Key key}) : super(key: key);

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  GlobalKey _addKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();
  GlobalKey _buttonKey = GlobalKey();

  NearbyPageProvider provider = NearbyPageProvider();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
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
    return ChangeNotifierProvider<NearbyPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(),
        body: Text("Maps"),
      ),
    );
  }
}
