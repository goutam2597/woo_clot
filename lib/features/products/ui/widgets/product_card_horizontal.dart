import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/add_to_cart_sheet.dart';
import 'package:flutter_woocommerce/features/wishlist/ui/widgets/wishlist_button.dart';

class ProductCardHorizontal extends StatelessWidget {
  final VoidCallback onTap;
  const ProductCardHorizontal({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: Colors.white,

        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 280,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with wishlist button overlay
              Stack(
                children: [
                  Image.asset(product.images),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: WishlistButton(product: product),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.shortDetails,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '\$${product.discount}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade600,
                                    decorationColor: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '\$${product.discountPercentage}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                StarRating(
                                  rating: double.parse(product.rating),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '(${product.review})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () => handleAddToCart(context, product),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,

                              shape: BoxShape.circle,
                            ),

                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
