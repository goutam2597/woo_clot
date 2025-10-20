import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/coupons/providers/coupons_provider.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CouponsScreen extends StatelessWidget {
  final bool popOnApply;
  const CouponsScreen({super.key, this.popOnApply = false});

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
          // Enter code card
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEAEAEA)),
            ),
            child: ListTile(
              leading: const Icon(Icons.local_offer_outlined),
              title: const Text('Have a coupon code?'),
              subtitle: const Text('Tap to enter a code and apply'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final textCtrl = TextEditingController();
                // Capture dependencies before awaiting to satisfy use_build_context_synchronously
                final couponsProv = context.read<CouponsProvider>();
                final cartProv = context.read<CartProvider>();
                final messenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);
                final code = await showDialog<String>(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Enter Coupon Code'),
                      content: TextField(
                        controller: textCtrl,
                        decoration: const InputDecoration(
                          hintText: 'e.g. SAVE10',
                        ),
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) =>
                            Navigator.of(ctx).pop(textCtrl.text.trim()),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(ctx).pop(textCtrl.text.trim()),
                          child: const Text('Apply'),
                        ),
                      ],
                    );
                  },
                );
                if (code != null && code.isNotEmpty) {
                  final found = couponsProv.findByCode(code);
                  if (found != null) {
                    cartProv.applyCoupon(found);
                    messenger.showSnackBar(
                      SnackBar(content: Text('Applied $code')),
                    );
                    if (popOnApply) navigator.pop(true);
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Invalid coupon')),
                    );
                  }
                }
              },
            ),
          ),
          if (saved.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Saved Coupons',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
            ...saved.map(
              (c) =>
                  _CouponTile(coupons: c, saved: true, popOnApply: popOnApply),
            ),
            const SizedBox(height: 16),
          ],
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Available Coupons',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          if (available.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No coupons available',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ...available.map(
            (c) => _CouponTile(
              coupons: c,
              saved: couponsCtrl.isSaved(c.code),
              popOnApply: popOnApply,
            ),
          ),
        ],
      ),
    );
  }
}

class _CouponTile extends StatelessWidget {
  final dynamic coupons;
  final bool saved;
  final bool popOnApply;
  const _CouponTile({
    required this.coupons,
    required this.saved,
    required this.popOnApply,
  });

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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                this.coupons.code,
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
                this.coupons.title,
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
                context.read<CartProvider>().applyCoupon(this.coupons);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Applied ${this.coupons.code}')),
                );
                if (popOnApply) Navigator.of(context).pop(true);
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
                  coupons.unsave(this.coupons.code);
                } else {
                  coupons.save(this.coupons);
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
