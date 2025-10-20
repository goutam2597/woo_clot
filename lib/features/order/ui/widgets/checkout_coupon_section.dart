import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/coupons/providers/coupons_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/coupons_screen.dart';

class CheckoutCouponSection extends StatefulWidget {
  const CheckoutCouponSection({super.key});

  @override
  State<CheckoutCouponSection> createState() => _CheckoutCouponSectionState();
}

class _CheckoutCouponSectionState extends State<CheckoutCouponSection> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _openCoupons() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CouponsScreen(popOnApply: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final coupons = context.watch<CouponsProvider>();
    final saved = coupons.saved;
    final applied = context.watch<CartProvider>().appliedCoupon;

    return Column(
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: applied != null
                    ? Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFEAEAEA)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Applied: ${applied.code}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () => context.read<CartProvider>().clearCoupon(),
                              child: const Icon(Icons.close, size: 18),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        saved.isNotEmpty ? 'No coupon applied' : 'Select a coupon',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 120,
                maxWidth: 160,
                minHeight: 44,
                maxHeight: 44,
              ),
              child: ElevatedButton(
                onPressed: _openCoupons,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: const StadiumBorder(),
                  elevation: 0,
                ),
                child: const Text(
                  'Select Coupon',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
