import 'package:flutter/cupertino.dart';
import 'package:grocery_task/utils/colors.dart';

class Category {
  final String name;
  final String iconAsset;
  final Color color;

  const Category(
      {required this.name, required this.iconAsset, required this.color});

      factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
      iconAsset: map['iconAsset'] as String,
      color: fromHex(map['color'] as String),
    );

    

}
Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconAsset': iconAsset,
      'color': toHex(color),
    };
  }
}
