import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_woocommerce/features/wishlist/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/products/ui/widgets/product_card_grid.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final items = wishlist.items;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Wishlist', centerTitle: true),
      body: SafeArea(
        child: items.isEmpty
            ? Center(
                child: Text(
                  'Your wishlist is empty',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: const EdgeInsets.all(12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final p = items[index];
                  // Rely on the existing WishlistButton overlay inside ProductCardGrid
                  // to add/remove items from wishlist; remove redundant X button.
                  return ProductCardGrid(product: p, onTap: () {});
                },
              ),
      ),
    );
  }
}
