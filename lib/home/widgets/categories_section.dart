import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_task/home/provider/categories_provider.dart';
import 'package:grocery_task/home/widgets/action_headline.dart';
import 'package:grocery_task/home/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesModel = context.watch<CategoriesProvider>();
    return SizedBox(
        height: 200,
        child: Column(
          children: [
            if (categoriesModel.categories.isEmpty)
              TextButton(
                  onPressed: () {
                    categoriesModel.addCategoriesToFirestore();
                  },
                  child: const Text('Add categories'))
            else
              const ActionHeadline(title: 'Categories'),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesModel.categories.length,
                itemBuilder: (context, index) {
                  final category = categoriesModel.categories[index];
                  return CategoryItem(category: category);
                },
              ),
            ),
          ],
        ));
  }
}
