import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';

class VariationRow extends StatelessWidget {
  final CartItem item;
  const VariationRow({super.key, required this.item});


  static List<Widget> _buildVariationChips(ProductsModel p) {
    final values = <String>{};
    for (final v in p.variations) {
      if (v.color != null && v.color!.trim().isNotEmpty) {
        values.add(v.color!.trim());
      }
      if (v.size != null && v.size!.trim().isNotEmpty) {
        values.add(v.size!.trim());
      }
      if (v.storage != null && v.storage!.trim().isNotEmpty) {
        values.add(v.storage!.trim());
      }
    }
    final chips = values.take(3).toList();
    return chips
        .map(
          (e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(e, style: const TextStyle(fontSize: 11)),
      ),
    )
        .toList();
  }

  static List<Widget> _buildVariationChipsFromItem(CartItem item) {
    final chips = <String>[];
    if ((item.color ?? '').isNotEmpty) chips.add(item.color!);
    if ((item.size ?? '').isNotEmpty) chips.add(item.size!);
    if ((item.storage ?? '').isNotEmpty) chips.add(item.storage!);
    if (chips.isEmpty) {
      return _buildVariationChips(item.product);
    }
    return chips
        .map(
          (e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(e, style: const TextStyle(fontSize: 11)),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Variations : ',
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: -8,
            children: _buildVariationChipsFromItem(item),
          ),
        ),
      ],
    );
  }
}