import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  @override
  void initState() {
    super.initState();
  }

  Future fetchListings(String type, int page) async {
    asyncRequestNetwork<List<CategoryModel>, CategoryModel>(Method.get,
        url: APIConst.categories, onSuccess: (data) {
      if (data != null) {
        view.categoryProvider.setHasMore(false);
        view.categoryProvider.addAll(data);
      } else {
        view.categoryProvider.setHasMore(false);
        view.categoryProvider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      view.categoryProvider.setHasMore(false);
      view.categoryProvider.setStateType(StateType.network);
    });
  }
}
