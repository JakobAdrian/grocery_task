import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/provider/products_provider.dart';
import 'package:grocery_task/home/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({required this.wishlist, Key? key}) : super(key: key);

  final List<Product> wishlist;

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    final productModel = context.watch<WishlistProvider>();
    return ListView(
      children: [
        Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        if (productModel.products.isEmpty) const Text('Your wishlist is empty'),
        for (var product in productModel.products)
          ListTile(
            onTap: () {},
            title: Text(product.name),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  productModel.products.remove(product);
                });
              },
              icon: const Icon(Icons.delete),
            ),
          ),
      ],
    );
  }
}
