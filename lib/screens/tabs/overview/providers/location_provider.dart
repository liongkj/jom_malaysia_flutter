import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  // CityModel get selected => _selected;

  String get selected {
    String cityName = SpUtil.getString(Constant.prefLocation);
    return cityName == "" ? null : cityName;
  }

  selectPlace(CityModel city) {
    SpUtil.putString(Constant.prefLocation, city.cityName);

    notifyListeners();
  }
}
