import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/repository/wishlist_repository.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistRepository wishlistRepository;
  final List<Product> _products = [];
  bool isLoading = false;

  List<Product> get products => _products;

  WishlistProvider(this.wishlistRepository) {
    _loadProducts();
  }

  void _loadProducts() async {
    isLoading = true;
    notifyListeners();

    wishlistRepository.getProductsStream().listen((products) {
      _products.clear();
      _products.addAll(products);
      isLoading = false;
      notifyListeners();
    });
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void addProductsToFirestore() {
    wishlistRepository.addProductToFirestore();
  }
}
