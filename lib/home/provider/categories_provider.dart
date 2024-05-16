import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/category.dart';
import 'package:grocery_task/home/repository/categories_repository.dart';

class CategoriesProvider with ChangeNotifier {
  final CategoriesRepository categoriesRepository;
  final List<Category> _categories = [];
  bool isLoading = false;

  List<Category> get categories => _categories;

  CategoriesProvider(this.categoriesRepository) {
    _loadCategories();
  }

  void _loadCategories() async {
    isLoading = true;
    notifyListeners();
    categoriesRepository.getCategoriesStream().listen((categories) {
      _categories.clear();
      _categories.addAll(categories);
      isLoading = false;
      notifyListeners();
    });
  }

  void addCategory(Category category) {
    _categories.add(category);
    notifyListeners();
  }

  void addCategoriesToFirestore() {
    categoriesRepository.addCategoriesToFirestore();
  }
}
