import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';

class UserCurrentLocationProvider extends ChangeNotifier {
  String get currentLocation => _currentLocation;
  String _currentLocation;
  CoordinatesModel get currentCoordinate => _currentCoordinate;

  CoordinatesModel _currentCoordinate;

  void setCurrentLocation(String currentCity, Position coordinate) {
    _currentLocation = currentCity;
    _currentCoordinate = new CoordinatesModel(
        longitude: coordinate.longitude, latitude: coordinate.latitude);
    notifyListeners();
  }
}
