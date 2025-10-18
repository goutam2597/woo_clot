import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/wishlist/data/wishlist_provider.dart';

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
                    child: _WishlistButton(product: product),
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
                                    color: AppColors.themeColor,
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
                          onTap: () => _handleAddToCart(context, product),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.themeColor,

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

class _WishlistButton extends StatelessWidget {
  final ProductsModel product;
  const _WishlistButton({required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistController>();
    final isWished = wishlist.contains(product);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          final wasWished = isWished;
          context.read<WishlistController>().toggle(product);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                wasWished ? 'Removed from wishlist' : 'Added to wishlist',
              ),
              duration: const Duration(milliseconds: 1200),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            isWished ? Icons.favorite : Icons.favorite_border,
            color: isWished ? Colors.red : Colors.black54,
            size: 20,
          ),
        ),
      ),
    );
  }
}

void _handleAddToCart(BuildContext context, ProductsModel product) async {
  final cart = context.read<CartController>();

  List<String> colors = product.variations
      .map((v) => v.color)
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();
  List<String> sizes = product.variations
      .map((v) => v.size)
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();
  List<String> storages = product.variations
      .map((v) => v.storage)
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();

  final needsSelection =
      colors.isNotEmpty || sizes.isNotEmpty || storages.isNotEmpty;

  if (!needsSelection) {
    cart.add(product, quantity: 1);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
    return;
  }

  int colorIndex = 0;
  int sizeIndex = 0;
  int storageIndex = 0;

  await showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    useSafeArea: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          Widget chips(
            String title,
            List<String> values,
            int selected,
            void Function(int) onSelect,
          ) {
            if (values.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: -6,
                    children: [
                      for (int i = 0; i < values.length; i++)
                        ChoiceChip(
                          label: Text(values[i]),
                          selected: selected == i,
                          onSelected: (_) => setState(() => onSelect(i)),
                          selectedColor: AppColors.themeColor.withValues(
                            alpha: 0.15,
                          ),
                          labelStyle: TextStyle(
                            color: selected == i
                                ? AppColors.themeColor
                                : Colors.black87,
                            fontWeight: selected == i
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Text(
                    'Select Options',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 4),
                chips('Color', colors, colorIndex, (i) => colorIndex = i),
                chips('Size', sizes, sizeIndex, (i) => sizeIndex = i),
                chips(
                  'Storage',
                  storages,
                  storageIndex,
                  (i) => storageIndex = i,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      shape: const StadiumBorder(),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    onPressed: () {
                      final color = colors.isNotEmpty
                          ? colors[colorIndex]
                          : null;
                      final size = sizes.isNotEmpty ? sizes[sizeIndex] : null;
                      final storage = storages.isNotEmpty
                          ? storages[storageIndex]
                          : null;
                      cart.add(
                        product,
                        quantity: 1,
                        color: color,
                        size: size,
                        storage: storage,
                      );
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart')),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
