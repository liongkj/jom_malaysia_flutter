import 'package:flutter/cupertino.dart';

class UserCurrentLocationProvider extends ChangeNotifier {
  String get currentLocation => _currentLocation;
  String _currentLocation;
  void setCurrentLocation(currentLocation) {
    _currentLocation = currentLocation;
    notifyListeners();
  }
}
