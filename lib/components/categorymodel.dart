import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class CategoryModel extends ChangeNotifier {
  String _selectedCategory = 'Singing'; // default value

  String get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
