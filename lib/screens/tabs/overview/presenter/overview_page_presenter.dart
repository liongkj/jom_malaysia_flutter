import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncRequestNetwork<List<CategoryModel>>(
        Method.get,
        url: APIConst.categories,
        isList: true,
        onSuccess: (data) {
          view.setCategories(data);
        },
      );
    });
  }
}
