import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final List<SummaryRow> rows;
  final String total;
  const SummaryCard({super.key, required this.rows, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text(
                    r.label,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const Spacer(),
                  Text(
                    r.value,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          const Divider(height: 24),
          Row(
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(total, style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryRow {
  final String label;
  final String value;
  const SummaryRow(this.label, this.value);
}

class PaymentTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const PaymentTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(width: 28, child: Center(child: icon)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? Colors.black : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _checkBubble(selected),
          ],
        ),
      ),
    );
  }
}

Container _checkBubble(final bool checked) {
  return Container(
    width: 22,
    height: 22,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: checked ? AppColors.primaryColor : Colors.black26,
        width: checked ? 5 : 1.5,
      ),
    ),
  );
}
