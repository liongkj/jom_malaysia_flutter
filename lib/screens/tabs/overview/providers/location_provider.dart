import 'package:flutter/cupertino.dart';

class LocationProvider extends ChangeNotifier {
  String get selected => _selected;
  String _selected;

  selectPlace(String city) {
    _selected = city;
    notifyListeners();
  }
}
