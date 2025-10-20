import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/coupons/providers/coupons_provider.dart';
import 'package:provider/provider.dart';

class CartCouponField extends StatefulWidget {
  const CartCouponField({super.key});

  @override
  State<CartCouponField> createState() => _CartCouponFieldState();
}

class _CartCouponFieldState extends State<CartCouponField> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _applyFromText() {
    final code = _ctrl.text.trim();
    if (code.isEmpty) return;
    final coupons = context.read<CouponsProvider>();
    final found = coupons.findByCode(code);
    final cart = context.read<CartProvider>();
    if (found != null) {
      cart.applyCoupon(found);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Applied coupon ${found.code}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid coupon')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final coupons = context.watch<CouponsProvider>();
    final saved = coupons.saved;
    final applied = context.watch<CartProvider>().appliedCoupon;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Coupon',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Color(0xFFEAEAEA)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: (_) => _applyFromText(),
                ),
              ),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 88,
                  maxWidth: 120,
                  minHeight: 44,
                  maxHeight: 44,
                ),
                child: ElevatedButton(
                  onPressed: _applyFromText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              if (applied != null) ...[
                const SizedBox(width: 8),
                SizedBox(
                  width: 44,
                  height: 44,
                  child: IconButton(
                    tooltip: 'Remove coupon',
                    onPressed: () => context.read<CartProvider>().clearCoupon(),
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ],
          ),
          if (saved.isNotEmpty) ...[
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: saved.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final c = saved[i];
                  return ActionChip(
                    label: Text(c.code),
                    onPressed: () {
                      context.read<CartProvider>().applyCoupon(c);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Applied coupon ${c.code}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
