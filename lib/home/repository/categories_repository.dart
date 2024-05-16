import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_task/home/models/category.dart';

class CategoriesRepository {
  List<Category> getCategories() {
    return categoriesMock;
  }

 

  Stream<List<Category>> getCategoriesStream() {
    return FirebaseFirestore.instance.collection('categories').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Category.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Future<void> addCategoriesToFirestore() async {
    await FirebaseFirestore.instance.collection('categories').get().then(
      (snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      },
    );
    for (Category category in categoriesMock) {
      await FirebaseFirestore.instance
          .collection('categories')
          .add(category.toJson());
    }
  }
}

final List<Category> categoriesMock = const [
  Category(
    name: 'Vegetable',
    iconAsset: 'assets/icons/vegetables.png',
    color: const Color(0xff28B446),
  ),
  Category(
    name: 'Fruits',
    iconAsset: 'assets/icons/fruits.png',
    color: const Color(0xffF8644A),
  ),
  Category(
    name: 'Beverages',
    iconAsset: 'assets/icons/beverages.png',
    color: const Color(0xffF5BA3C),
  ),
  Category(
    name: 'Grocery',
    iconAsset: 'assets/icons/grocery.png',
    color: const Color(0xffAE80FF),
  ),
  Category(
    name: 'Edible Oil',
    iconAsset: 'assets/icons/edible_oil.png',
    color: const Color(0xff0CD4DC),
  ),
  Category(
    name: 'Household',
    iconAsset: 'assets/icons/vacuum.png',
    color: const Color(0xffFF7EB6),
  ),
];
