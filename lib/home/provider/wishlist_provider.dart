import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/repository/wishlist_repository.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistRepository wishlistRepository;
  final List<Product> _wishlistProducts = [];

  List<Product> get wishlistProducts => _wishlistProducts;

  WishlistProvider(this.wishlistRepository) {
    _loadWishlistProducts();
  }
  void toggleFavorites(Product product) async {
    if (_wishlistProducts
        .where((element) => element.name == product.name)
        .isNotEmpty) {
      await wishlistRepository.removeProductFromWishlist(product);
    } else {
      wishlistRepository.addProductToWishlist(product);
    }
    notifyListeners();
  }

  void _loadWishlistProducts() async {
    wishlistRepository.getWishlistStream().listen((products) {
      _wishlistProducts.clear();
      _wishlistProducts.addAll(products);
      notifyListeners();
    });
  }
}
