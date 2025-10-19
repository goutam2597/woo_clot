import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/common/widgets/header_text.dart';
import 'package:flutter_woocommerce/features/cart/data/models/cart_item.dart';
import 'package:flutter_woocommerce/features/cart/ui/widgets/cart_item_card.dart';
import 'package:flutter_woocommerce/features/cart/ui/widgets/cart_summary.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final List<CartItem> items = cart.items;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart', centerTitle: true),
      body: items.isEmpty
          ? const _CartEmptyState()
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: HeaderText(text: 'Shopping List', fontSize: 18),
                    ),
                    const SizedBox(height: 8),

                    // Items List
                    _CartItemsListView(items: items, cart: cart),

                    const SizedBox(height: 16),
                    // Order Summary scrolls with content
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CartSummary(),
                    ),

                    // Extra space so content isn't hidden behind sticky checkout bar
                    SizedBox(height: items.isNotEmpty ? 100 : 16),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: items.isEmpty ? null : const CartCheckoutBar(),
    );
  }
}

class _CartEmptyState extends StatelessWidget {
  const _CartEmptyState();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CartItemsListView extends StatelessWidget {
  final List<CartItem> items;
  final CartProvider cart;
  const _CartItemsListView({required this.items, required this.cart});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final CartItem item = items[index];
        return CartItemCard(item: item, cart: cart);
      },
    );
  }
}

class CardSurface extends StatelessWidget {
  final Widget child;
  const CardSurface({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}
