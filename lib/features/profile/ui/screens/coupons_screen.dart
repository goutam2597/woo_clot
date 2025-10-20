import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/coupons/providers/coupons_provider.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CouponsScreen extends StatelessWidget {
  const CouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final couponsCtrl = context.watch<CouponsProvider>();
    final saved = couponsCtrl.saved;
    final available = couponsCtrl.available;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Coupons', centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          if (saved.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('Saved Coupons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            ...saved.map((c) => _CouponTile(c: c, saved: true)).toList(),
            const SizedBox(height: 16),
          ],
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text('Available Coupons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          if (available.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No coupons available',
                style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
              ),
            ),
          ...available.map((c) => _CouponTile(c: c, saved: couponsCtrl.isSaved(c.code))).toList(),
        ],
      ),
    );
  }
}

class _CouponTile extends StatelessWidget {
  final dynamic c; // CouponModel
  final bool saved;
  const _CouponTile({required this.c, required this.saved});

  @override
  Widget build(BuildContext context) {
    final coupons = context.read<CouponsProvider>();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
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
          child: Text(saved ? 'Saved' : 'Tap save to use later'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                context.read<CartProvider>().applyCoupon(c);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Applied ${c.code}')),
                );
              },
              child: const Text(
                'Apply',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              tooltip: saved ? 'Unsave' : 'Save',
              onPressed: () {
                if (saved) {
                  coupons.unsave(c.code);
                } else {
                  coupons.save(c);
                }
              },
              icon: Icon(saved ? Icons.bookmark : Icons.bookmark_add_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
