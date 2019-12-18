import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/core/services/gateway/net.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/overview_page.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class OverviewPagePresenter extends BasePagePresenter<OverviewPageState> {
  @override
  void initState() {
    super.initState();
  }

  Future fetchListings(String type, int page) async {
    asyncRequestNetwork<List<ListingModel>, ListingModel>(Method.get,
        url: APIConst.listings, onSuccess: (data) {
      if (data != null) {
        view.listingProvider.setHasMore(false);
        view.listingProvider.addAll(data);
      } else {
        view.listingProvider.setHasMore(false);
        view.listingProvider.setStateType(StateType.network);
      }
    }, onError: (_, __) {
      view.listingProvider.setHasMore(false);
      view.listingProvider.setStateType(StateType.network);
    });
  }
}
