import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  CityModel get cityModel => _cityModel;
  CityModel _cityModel;
  bool rebuildHome = true;

  String get selected {
    String cityName = SpUtil.getString(Constant.prefLocation);
    return cityName == "" ? "" : cityName;
  }

  clear() {
    SpUtil.remove(Constant.prefLocation);
    _cityModel = null;
    notifyListeners();
  }

  selectPlace(CityModel city) {
    SpUtil.putString(Constant.prefLocation, city.cityName);
    _cityModel = city;
    rebuildHome = true;
    notifyListeners();
  }

  void syncLoc() {
    String loc = SpUtil.getString(Constant.prefLocation);
    if (loc.isNotEmpty) {
      notifyListeners();
    }
  }
}
