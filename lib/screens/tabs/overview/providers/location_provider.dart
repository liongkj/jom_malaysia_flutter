import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  CityModel _selected;

  CityModel get selected => _selected;

  void init() {
    Map<String, dynamic> sp = SpUtil.getObject(Constant.prefLocation);
    if (sp != null) {
      _selected = CityModel.fromJsonMap(sp);
    } else
      _selected = null;
    notifyListeners();
  }

  clear() {
    SpUtil.remove(Constant.prefLocation);

    notifyListeners();
  }

  selectPlace(CityModel city) {
    SpUtil.putObject(Constant.prefLocation, city);
    _selected = city;
    notifyListeners();
  }
}
