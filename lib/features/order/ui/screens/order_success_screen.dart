import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/features/home/ui/screens/bottom_nav.dart';

class OrderSuccessScreen extends StatelessWidget {
  final int itemsCount;
  final double subtotal;
  final double discount;
  final double delivery;
  final double total;

  const OrderSuccessScreen({
    super.key,
    required this.itemsCount,
    required this.subtotal,
    required this.discount,
    required this.delivery,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Success', centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAE6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.themeColor,
                  size: 72,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Order Successful!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'Your order has been placed and is being processed.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _SummaryBox(
                itemsCount: itemsCount,
                subtotal: subtotal,
                discount: discount,
                delivery: delivery,
                total: total,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const BottomNav()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final int itemsCount;
  final double subtotal;
  final double discount;
  final double delivery;
  final double total;

  const _SummaryBox({
    required this.itemsCount,
    required this.subtotal,
    required this.discount,
    required this.delivery,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _row('Items', itemsCount.toString()),
          _row('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          _row('Discount', '\$${discount.toStringAsFixed(0)}'),
          _row('Delivery Charges', '\$${delivery.toStringAsFixed(0)}'),
          const Divider(height: 22),
          _row('Total', '\$${total.toStringAsFixed(2)}', bold: true),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
