import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/facts/provider/facts_page_provider.dart';
import 'package:jom_malaysia/setting/provider/language_provider.dart';
import 'package:jom_malaysia/setting/routers/fluro_navigator.dart';
import 'package:jom_malaysia/util/theme_utils.dart';
import 'package:provider/provider.dart';

class FactsPage extends StatefulWidget {
  FactsPage({Key key}) : super(key: key);

  @override
  _FactsPageState createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  GlobalKey _addKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();
  GlobalKey _buttonKey = GlobalKey();

  FactsPageProvider provider = FactsPageProvider();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigatorUtils.goWebViewPage(context, "Negeri Sembilan",
          "https://en.wikipedia.org/wiki/Negeri_Sembilan");
    });
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
    return Consumer<LanguageProvider>(builder: (_, provider, __) {
      return Scaffold(appBar: AppBar(), body: Text(""));
    });
  }
}
