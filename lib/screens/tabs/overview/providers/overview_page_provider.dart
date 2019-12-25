import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';

class OverviewPageProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void refresh() {
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;

    notifyListeners();
  }
}
