import 'package:flutter/material.dart';
import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';

class CategoriesProvider with ChangeNotifier {
  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => [..._categoryList];
}
