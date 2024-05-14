import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';

class WishlistRepository {
  final List<Product> wishlist = [];
  

  Stream<List<Product>> getProductsStream() {
    return FirebaseFirestore.instance.collection('wishlist').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Product.fromFirestore(doc.data()),
              )
              .toList(),
        );
  }

  Future<void> addProductToFirestore() async {
    await FirebaseFirestore.instance.collection('wishlist').get().then(
      (snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      },
    );
    for (Product product in wishlist) {
      FirebaseFirestore.instance
          .collection('wishlist')
          .add(product.toFirestore());
    }
  }
}