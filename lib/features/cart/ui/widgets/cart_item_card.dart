import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/cart/ui/screens/cart_screen.dart';
import 'package:flutter_woocommerce/features/cart/ui/widgets/qty_stepper.dart';
import 'package:flutter_woocommerce/features/cart/ui/widgets/variation_row.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final CartController cart;
  const CartItemCard({super.key, required this.item, required this.cart});

  static double _parse(String v) => double.tryParse(v) ?? 0.0;

  @override
  Widget build(BuildContext context) {
    final p = item.product;
    final oldPrice = _parse(p.price);
    final newPrice = _parse(p.discount);
    final qty = item.quantity;
    final accent = AppColors.themeColor;

    final key = ValueKey(
      '${p.title}-${item.color ?? ''}-${item.size ?? ''}-${item.storage ?? ''}',
    );

    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => cart.remove(item),
      child: Column(
        children: [
          CardSurface(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      p.images,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        VariationRow(item: item),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            StarRating(
                              rating: double.tryParse(p.rating) ?? 0,
                              size: 16,
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'upto ${p.discountPercentage} off',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '\$${oldPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    decorationThickness: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _PricePill(amount: newPrice),
                            const Spacer(),
                            QtyStepper(
                              quantity: qty,
                              onIncrement: () =>
                                  cart.setQuantity(item, qty + 1),
                              onDecrement: () =>
                                  cart.setQuantity(item, qty - 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: [
                Text(
                  'Total Order ($qty)  :',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  '\$${(newPrice * qty).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PricePill extends StatelessWidget {
  final double amount;
  const _PricePill({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Text(
        '\$${amount.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
    );
  }
}
