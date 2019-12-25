import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/listing_model.dart';

class PlaceDetailProvider extends ChangeNotifier {
  ListingModel _place;
  ListingModel get place => _place;

  void setPlace(ListingModel data) {
    _place = data;
    notifyListeners();
  }
}
