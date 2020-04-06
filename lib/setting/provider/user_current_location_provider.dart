import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jom_malaysia/core/models/coordinates_model.dart';

enum LocationState {
  init,

  ///found location
  found,

  ///show rejected state
  noPermit,

  ///  loading state
  loading,

  ///  loading empty state
  granted,
}

class UserCurrentLocationProvider extends ChangeNotifier {
  String get currentLocation => _currentLocation;
  String _currentLocation;

  LocationState locState = LocationState.init;

  CoordinatesModel get currentCoordinate => _currentCoordinate;

  CoordinatesModel _currentCoordinate;

  void setLoading(LocationState param0) {
    locState = param0;
    notifyListeners();
  }

  void setCurrentLocation(String currentCity, Position coordinate) {
    _currentLocation = currentCity;
    _currentCoordinate = new CoordinatesModel(
        longitude: coordinate.longitude, latitude: coordinate.latitude);
    locState =
        currentCity == null ? LocationState.noPermit : LocationState.found;

    notifyListeners();
  }
}
