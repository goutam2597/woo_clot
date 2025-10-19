import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/wishlist/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

class WishlistButton extends StatelessWidget {
  const WishlistButton({super.key, required this.products});

  final ProductsModel products;

  @override
  Widget build(BuildContext context) {
    final wish = context.watch<WishlistProvider>();
    final isWished = wish.contains(products);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.read<WishlistProvider>().toggle(products);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isWished ? 'Removed from wishlist' : 'Added to wishlist',
            ),
          ),
        );
      },
      child: Card(
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: _WishlistIcon(),
        ),
      ),
    );
  }
}

class _WishlistIcon extends StatelessWidget {
  const _WishlistIcon();

  @override
  Widget build(BuildContext context) {
    final wish = context.watch<WishlistProvider>();
    final element = (context.findAncestorWidgetOfExactType<WishlistButton>())!;
    final products = element.products;
    final isWished = wish.contains(products);

    return Icon(
      isWished ? Icons.favorite : Icons.favorite_border,
      color: AppColors.themeColor,
    );
  }
}
