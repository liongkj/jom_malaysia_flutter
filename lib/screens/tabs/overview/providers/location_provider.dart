import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  CityModel get selected => _selected;
  CityModel _selected;

  selectPlace(CityModel city) {
    _selected = city;
    notifyListeners();
  }
}
