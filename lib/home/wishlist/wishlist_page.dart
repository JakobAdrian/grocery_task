import 'package:flutter/material.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/provider/products_provider.dart';
import 'package:grocery_task/home/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

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
        if (productModel.wishlistProducts.isEmpty)
          const Text('Your wishlist is empty'),
        for (var product in productModel.wishlistProducts)
          ListTile(
            onTap: () {},
            title: Text(product.name),
            trailing: IconButton(
              onPressed: () {
                context.read<WishlistProvider>().toggleFavorites(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${product.name} removed from wishlist"),
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ),
      ],
    );
  }
}
