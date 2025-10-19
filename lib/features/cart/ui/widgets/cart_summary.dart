
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/checkout_screen.dart';
import 'package:provider/provider.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final itemsCount = cart.totalQuantity;
    final discountedSubtotal = cart.subtotal;
    final double discount = cart.totalDiscount < 0 ? 0.0 : cart.totalDiscount;
    const delivery = 2.0;
    final total = discountedSubtotal + delivery;

    // This summary is intended to scroll with the page content
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          _summaryRow('Items', itemsCount.toString()),
          _summaryRow(
            'Subtotal',
            '\$${discountedSubtotal.toStringAsFixed(2)}',
          ),
          _summaryRow('Discount', '\$${discount.toStringAsFixed(0)}'),
          _summaryRow(
            'Delivery Charges',
            '\$${delivery.toStringAsFixed(0)}',
          ),
          const Divider(height: 20),
          _summaryRow(
            'Total',
            '\$${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final itemsCount = cart.totalQuantity;
    final discountedSubtotal = cart.subtotal;
    final double discount = cart.totalDiscount < 0 ? 0.0 : cart.totalDiscount;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CheckoutScreen(
                    totalQuantity: itemsCount,
                    subtotal: discountedSubtotal,
                    discount: discount,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: const StadiumBorder(),
              elevation: 0,
            ),
            child: const Text(
              'Check Out',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
Widget _summaryRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
