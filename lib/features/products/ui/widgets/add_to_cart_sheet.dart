import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:provider/provider.dart';

Future<void> handleAddToCart(
  BuildContext context,
  ProductsModel product,
) async {
  final cart = context.read<CartProvider>();

  List<String> colors = product.variations
      .map((v) => v.color)
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();
  List<String> sizes = product.variations
      .map((v) => v.size)
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();
  List<String> storages = product.variations
      .map((v) => v.storage)
      .whereType<String>()
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();

  final needsSelection =
      colors.isNotEmpty || sizes.isNotEmpty || storages.isNotEmpty;

  if (!needsSelection) {
    cart.add(product, quantity: 1);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Added to cart')));
    return;
  }

  int colorIndex = 0;
  int sizeIndex = 0;
  int storageIndex = 0;

  await showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    useSafeArea: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          Widget chips(
            String title,
            List<String> values,
            int selected,
            void Function(int) onSelect,
          ) {
            if (values.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: -6,
                    children: [
                      for (int i = 0; i < values.length; i++)
                        ChoiceChip(
                          label: Text(values[i]),
                          selected: selected == i,
                          onSelected: (_) => setState(() => onSelect(i)),
                          selectedColor: AppColors.primaryColor.withValues(
                            alpha: 0.15,
                          ),
                          labelStyle: TextStyle(
                            color: selected == i
                                ? AppColors.primaryColor
                                : Colors.black87,
                            fontWeight: selected == i
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: Text(
                    'Select Options',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 4),
                chips('Color', colors, colorIndex, (i) => colorIndex = i),
                chips('Size', sizes, sizeIndex, (i) => sizeIndex = i),
                chips(
                  'Storage',
                  storages,
                  storageIndex,
                  (i) => storageIndex = i,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: const StadiumBorder(),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                    onPressed: () {
                      final color = colors.isNotEmpty
                          ? colors[colorIndex]
                          : null;
                      final size = sizes.isNotEmpty ? sizes[sizeIndex] : null;
                      final storage = storages.isNotEmpty
                          ? storages[storageIndex]
                          : null;
                      cart.add(
                        product,
                        quantity: 1,
                        color: color,
                        size: size,
                        storage: storage,
                      );
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart')),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
