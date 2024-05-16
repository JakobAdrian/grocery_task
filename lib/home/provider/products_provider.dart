import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/repository/products_repository.dart';

class ProductsProvider with ChangeNotifier {
  final ProductsRepository productRepository;
  final List<Product> _products = [];
  bool isLoading = false;

  List<Product> get products => _products;

  ProductsProvider(this.productRepository) {
    _loadProducts();
  }

  void _loadProducts() async {
    isLoading = true;
    notifyListeners();

    productRepository.getProductsStream().listen((products) {
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
    productRepository.addProductToFirestore();
  }
}
