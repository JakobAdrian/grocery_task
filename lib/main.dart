import 'package:flutter/material.dart';
import 'package:grocery_task/app.dart';
import 'package:grocery_task/firebase_options.dart';
import 'package:grocery_task/home/provider/categories_provider.dart';
import 'package:grocery_task/home/provider/products_provider.dart';
import 'package:grocery_task/home/provider/wishlist_provider.dart';
import 'package:grocery_task/home/repository/categories_repository.dart';
import 'package:grocery_task/home/repository/products_repository.dart';
import 'package:grocery_task/home/repository/wishlist_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  ProductsRepository productsRepository = ProductsRepository();
  CategoryRepository categoryRepository = CategoryRepository();
  WishlistRepository wishlistRepository = WishlistRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(productsRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoriesProvider(categoryRepository),
        ),
        ChangeNotifierProvider(
            create: (context) => WishlistProvider(wishlistRepository)),
      ],
      child: App(
        preferences: prefs,
      ),
    ),
  );
}
