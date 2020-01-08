import 'package:flutter/cupertino.dart';

class LocationProvider extends ChangeNotifier {
  String get selected => _selected;
  String _selected;

  String get currentLocation => _currentLocation;
  String _currentLocation;

  selectPlace(String city) {
    _selected = city;
    notifyListeners();
  }

  void setCurrentLocation(currentLocation) {
    _currentLocation = currentLocation;
    notifyListeners();
  }
}
