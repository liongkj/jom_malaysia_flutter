import 'package:jom_malaysia/core/mvp/base_page_presenter.dart';
import 'package:jom_malaysia/screens/tabs/overview/pages/place_detail_page.dart';

class PlaceDetailPagePresenter extends BasePagePresenter<PlaceDetailPageState> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   fetchDetail("5df090ab8430e205883f71db");
    // });
  }

  // Future fetchDetail(String placeId) async {
  //   print("fetching " + placeId);
  //   asyncRequestNetwork<ListingModel, Null>(Method.get,
  //       url: "${APIEndpoint.listings}/$placeId", onSuccess: (data) {
  //     view.provider.setStateType(StateType.loading);
  //     if (data != null) {
  //       print("fetched " + data.listingName);
  //       view.setPlace(data);
  //     } else {
  //       view.provider.setStateType(StateType.network);
  //     }
  //   }, onError: (_, __) {
  //     view.provider.setStateType(StateType.network);
  //   });
  // }
}
