import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grocery_task/home/models/cart.dart';
import 'package:grocery_task/home/models/product.dart';
import 'package:grocery_task/home/widgets/action_headline.dart';
import 'package:grocery_task/home/widgets/categories_section.dart';
import 'package:grocery_task/home/widgets/hero_image.dart';
import 'package:grocery_task/home/widgets/product_item.dart';

class HomeBody extends StatefulWidget {
  const HomeBody(
      {Key? key,
      required this.products,
      required this.cart,
      required this.wishlist,
      required this.toggleTheme})
      : super(key: key);

  final List<Product> products;
  final Cart cart;
  final List<Product> wishlist;
  final VoidCallback toggleTheme;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void onAddItem(Product product) {
    setState(() {
      if (widget.cart.items.any((element) => element.product == product)) {
        widget.cart.items
            .firstWhere((element) => element.product == product)
            .quantity++;
        return;
      } else {
        widget.cart.items.add(
          CartItem(product: product, quantity: 1),
        );
      }
    });
  }

  void onRemoveItem(Product product) {
    setState(() {
      if (widget.cart.items.any((element) => element.product == product) &&
          widget.cart.items
                  .firstWhere((element) => element.product == product)
                  .quantity >
              1) {
        widget.cart.items
            .firstWhere((element) => element.product == product)
            .quantity--;
        return;
      } else {
        widget.cart.items.removeWhere((element) => element.product == product);
      }
    });
  }

  void toggleFavoriteList(Product product) {
    setState(() {
      if (widget.wishlist.contains(product)) {
        widget.wishlist.remove(product);
      } else {
        widget.wishlist.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search keywords..',
              prefixIcon: Icon(Icons.search),
              fillColor: Color(0xffe4e5e9),
              filled: true,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const HeroImage(),
        const SizedBox(height: 20),
        CategoriesSection(),
        const SizedBox(height: 20),
        const ActionHeadline(title: 'Featured products'),
        const SizedBox(height: 12),
        Wrap(
          runSpacing: 20,
          alignment: WrapAlignment.spaceBetween,
          children: [
            for (final product in widget.products)
              ProductItem(
                product: product,
                quantity: widget.cart.items
                    .firstWhere((element) => element.product == product,
                        orElse: () => CartItem(product: product, quantity: 0))
                    .quantity,
                onAddToCart: () => onAddItem(product),
                onRemoveItem: () => onRemoveItem(product),
                toggleFavorite: () => toggleFavoriteList(product),
                isFavorite: widget.wishlist.contains(product),
              ),
          ],
        ),
        const SizedBox(
          height: 22,
        ),
        FilledButton(
          onPressed: () {
            widget.toggleTheme();
          },
          child: const Text('Change Theme'),
        ),
      ].animate(interval: const Duration(milliseconds: 100)).fadeIn(),
    );
  }
}
