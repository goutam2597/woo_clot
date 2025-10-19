import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/order/providers/orders_provider.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/order_success_screen.dart';
import 'package:provider/provider.dart';

class CheckoutBottomButton extends StatelessWidget {
  const CheckoutBottomButton({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.delivery,
    required this.total,
    required this.totalQuantity,
  });

  final double subtotal;
  final double discount;
  final double delivery;
  final double total;
  final int totalQuantity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor,
              shape: const StadiumBorder(),
              elevation: 0,
            ),
            onPressed: () {
              final cartCtrl = context.read<CartProvider>();
              context.read<OrdersProvider>().placeFromCart(
                cartCtrl.items,
                subtotal: subtotal,
                discount: discount,
                delivery: delivery,
                total: total,
              );

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => OrderSuccessScreen(
                    itemsCount: totalQuantity,
                    subtotal: subtotal,
                    discount: discount,
                    delivery: delivery,
                    total: total,
                  ),
                ),
              );

              cartCtrl.clear();
            },
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
