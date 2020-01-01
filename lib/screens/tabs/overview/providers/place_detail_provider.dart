import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class PlaceDetailProvider extends ChangeNotifier {
  ListingModel _place;
  ListingModel get place => _place;

  StateType _stateType = StateType.loading;
  StateType get stateType => _stateType;

  void setPlace(ListingModel data) {
    print(this.hashCode.toString() + data.listingName);
    _place = data;
    notifyListeners();
  }

  void setStateType(StateType stateType) {
    _stateType = stateType;
    notifyListeners();
  }

  void setStateTypeNotNotify(StateType stateType) {
    _stateType = stateType;
  }
}
