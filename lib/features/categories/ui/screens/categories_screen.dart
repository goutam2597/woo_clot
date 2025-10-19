import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/features/categories/data/models/categories_model.dart';
import 'package:flutter_woocommerce/features/categories/ui/widgets/category_list.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  List<CategoryListModel> _buildAllCategories() {
    final Map<String, CategoryListModel> map = {};

    for (final products in dummyProductList) {
      final category = products.category;
      map[category.title] = CategoryListModel(
        images: category.images,
        title: category.title,
      );
    }
    for (final ategories in dummyCategoryList) {
      map.putIfAbsent(
        ategories.title,
        () =>
            CategoryListModel(images: ategories.images, title: ategories.title),
      );
    }

    final list = map.values.toList()
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final categories = _buildAllCategories();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Categories', centerTitle: true),
      body: SafeArea(
        child: categories.isEmpty
            ? Center(
                child: Text(
                  'No categories found',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 120,
                        ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final c = categories[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [CategoryList(categories: c)],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
