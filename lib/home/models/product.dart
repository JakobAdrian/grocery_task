import 'dart:ui';

import 'package:grocery_task/home/models/category.dart';
import 'package:grocery_task/utils/colors.dart';

class Product {
  final String name;
  final String description;
  final num price;
  final Category? category;

  final String imageAsset;

  final Color color;

  final ProductBadge? badge;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    required this.color,
    this.category,
    this.badge,
  });
  factory Product.fromFirestore(Map<String, dynamic> map) {
    return Product(
        name: map['name'] as String,
        description: map['description'] as String,
        price: map['price'] as num,
        imageAsset: map['imageAsset'],
        color: fromHex(map['color'] as String),
        category: map['category'] == null
            ? null
            : Category.fromJson(map['category'] as Map<String, dynamic>),
        badge: map['badge'] == null
            ? null
            : ProductBadge.fromJson(map['badge'] as Map<String, dynamic>));
  }
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageAsset': imageAsset,
      'color': toHex(color),
      'category': category?.toJson(),
      'badge': badge?.toJson(),
    };
  }
}

class ProductBadge {
  final String name;
  final Color color;

  const ProductBadge({
    required this.name,
    required this.color,
  });
  factory ProductBadge.fromJson(Map<String, dynamic> map) {
    return ProductBadge(
      name: map['name'] as String,
      color: fromHex(map['color'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': toHex(color),
    };
  }
}
