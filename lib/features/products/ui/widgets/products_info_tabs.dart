import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/description_n_review.dart';

class ProductInfoAndTabs extends StatefulWidget {
  const ProductInfoAndTabs({super.key, required this.products});

  final ProductsModel products;

  @override
  State<ProductInfoAndTabs> createState() => _ProductInfoAndTabsState();
}

class _ProductInfoAndTabsState extends State<ProductInfoAndTabs> {
  @override
  Widget build(BuildContext context) {
    final p = widget.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              p.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            RichText(
              text: TextSpan(
                text: '\$${p.discount}  ',
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: '\$${p.price}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            StarRating(rating: double.parse(p.rating), size: 20),
            const SizedBox(width: 8),
            Text(
              '(${p.review}) Reviews',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Text(
          p.shortDetails,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),
        DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                indicatorColor: AppColors.themeColor,
                onTap: (i) => setState(() {}),
                tabs: const [
                  Tab(text: 'Description'),
                  Tab(text: 'Reviews'),
                ],
              ),
              const SizedBox(height: 8),
              DescriptionOrReviews(products: p),
            ],
          ),
        ),
      ],
    );
  }
}
