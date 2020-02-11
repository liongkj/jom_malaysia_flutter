import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  CityModel get cityModel => _cityModel;
  CityModel _cityModel;

  String get selected {
    String cityName = SpUtil.getString(Constant.prefLocation);
    return cityName == "" ? null : cityName;
  }

  clear() {
    SpUtil.remove(Constant.prefLocation);
    _cityModel = null;
    print("clear");
    notifyListeners();
  }

  selectPlace(CityModel city) {
    SpUtil.putString(Constant.prefLocation, city.cityName);
    _cityModel = city;
    rebuildHome = true;
    notifyListeners();
  }

  bool rebuildHome = true;

  void syncLoc() {
    String loc = SpUtil.getString(Constant.prefLocation);
    print(loc + " saved");
    if (loc.isNotEmpty) {
      notifyListeners();
    }
  }
}
