import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/core/services/list_view_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => [..._categoryList];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncRequestNetwork<List<CategoryModel>, CategoryModel>(
        Method.get,
        url: APIConst.categories,
        onSuccess: (data) {
          view.setCategories(data);
        },
      );
    });
  }
}
