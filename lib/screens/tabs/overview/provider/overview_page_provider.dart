import 'package:flutter/material.dart';

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
