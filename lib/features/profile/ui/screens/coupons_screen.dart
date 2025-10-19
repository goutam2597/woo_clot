import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coupons = _dummyCoupons;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Coupons', centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: coupons.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final c = coupons[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEAEAEA)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      c.code,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      c.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Expires: ${c.expiry}'),
              ),
              trailing: TextButton(
                onPressed: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Applied ${c.code}'))),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Coupon {
  final String code, title, expiry;
  const _Coupon(this.code, this.title, this.expiry);
}

const _dummyCoupons = <_Coupon>[
  _Coupon('SAVE10', 'Save 10% on orders over \$50', '31 Dec 2025'),
  _Coupon('FREESHIP', 'Free shipping on all items', '15 Jan 2026'),
  _Coupon('WELCOME15', '15% off for new users', '30 Jun 2026'),
];
