import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';

class OverviewPageProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  void refresh() {
    notifyListeners();
  }

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setCategory(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }
}
