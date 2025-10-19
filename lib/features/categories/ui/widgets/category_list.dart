
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/categories/data/models/categories_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.categories, this.onTap});

  final CategoryListModel categories;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(categories.images),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            categories.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
