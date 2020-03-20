import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:jom_malaysia/core/constants/common.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/city_model.dart';

class LocationProvider extends ChangeNotifier {
  CityModel get selected {
    Map<dynamic, dynamic> sp = SpUtil.getObject(Constant.prefLocation);
    if (sp != null) {
      return CityModel.fromJsonMap(sp);
    }
    return null;
  }

  clear() {
    SpUtil.remove(Constant.prefLocation);

    notifyListeners();
  }

  selectPlace(CityModel city) {
    SpUtil.putObject(Constant.prefLocation, city);
    notifyListeners();
  }
}
