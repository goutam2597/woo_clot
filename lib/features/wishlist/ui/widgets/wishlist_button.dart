import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/wishlist/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishlistButton extends StatelessWidget {
  final ProductsModel product;
  const WishlistButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final isWished = wishlist.contains(product);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          final wasWished = isWished;
          context.read<WishlistProvider>().toggle(product);
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
            size: 32,
          ),
        ),
      ),
    );
  }
}
