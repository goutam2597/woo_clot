import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/common/widgets/header_text.dart';
import 'package:flutter_woocommerce/common/widgets/rating_star_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/checkout_screen.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final accent = AppColors.themeColor;
    final cart = context.watch<CartController>();
    final List<CartItem> items = cart.items;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart', centerTitle: true),
      body: items.isEmpty
          ? SafeArea(
              child: Center(
                child: Text(
                  'Your cart is empty',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: HeaderText(text: 'Shopping List', fontSize: 18),
                    ),
                    const SizedBox(height: 8),

                    // Items
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final CartItem item = items[index];
                        final p = item.product;
                        final oldPrice = _parse(p.price);
                        final newPrice = _parse(p.discount);
                        final qty = item.quantity;

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
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (_) => cart.remove(item),
                          child: Column(
                            children: [
                              _CardSurface(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Variations : ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Wrap(
                                                    spacing: 6,
                                                    runSpacing: -8,
                                                    children:
                                                        _buildVariationChipsFromItem(
                                                          item,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                StarRating(
                                                  rating:
                                                      double.tryParse(
                                                        p.rating,
                                                      ) ??
                                                      0,
                                                  size: 16,
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'upto ${p.discountPercentage} off',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: accent,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      '\$${oldPrice.toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey
                                                            .shade600,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor:
                                                            Colors.red,
                                                        decorationThickness:
                                                            1.5,
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
                                                _QtyStepper(
                                                  quantity: qty,
                                                  onIncrement: () =>
                                                      cart.setQuantity(
                                                        item,
                                                        qty + 1,
                                                      ),
                                                  onDecrement: () =>
                                                      cart.setQuantity(
                                                        item,
                                                        qty - 1,
                                                      ),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Total Order ($qty)  :',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '\$${(newPrice * qty).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    SizedBox(height: items.isNotEmpty ? 180 : 16),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Builder(
                  builder: (context) {
                    final itemsCount = cart.totalQuantity;
                    final discountedSubtotal = cart.subtotal;
                    final double discount = cart.totalDiscount < 0
                        ? 0.0
                        : cart.totalDiscount;
                    const delivery = 2.0;
                    final total = discountedSubtotal + delivery;

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFEAEAEA)),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Order Summary',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _summaryRow('Items', itemsCount.toString()),
                              _summaryRow(
                                'Subtotal',
                                '\$${discountedSubtotal.toStringAsFixed(2)}',
                              ),
                              _summaryRow(
                                'Discount',
                                '\$${discount.toStringAsFixed(0)}',
                              ),
                              _summaryRow(
                                'Delivery Charges',
                                '\$${delivery.toStringAsFixed(0)}',
                              ),
                              const Divider(height: 20),
                              _summaryRow(
                                'Total',
                                '\$${total.toStringAsFixed(2)}',
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CheckoutScreen(
                                    totalQuantity: itemsCount,
                                    subtotal: discountedSubtotal,
                                    discount: discount,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.themeColor,
                              shape: const StadiumBorder(),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Check Out',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }

  // Address section removed as requested; keeping screen focused on cart only.

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

  static double _parse(String v) => double.tryParse(v) ?? 0.0;
}

class _CardSurface extends StatelessWidget {
  final Widget child;
  const _CardSurface({required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0.5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: child,
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
            color: Colors.black.withValues(alpha: 0.04),
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

class _QtyStepper extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  const _QtyStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.themeColor;
    final text = quantity.toString().padLeft(2, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _circle(accent, Icons.remove, onDecrement),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        _circle(accent, Icons.add, onIncrement),
      ],
    );
  }

  Widget _circle(Color color, IconData icon, VoidCallback onTap) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 28,
          height: 28,
          child: Icon(icon, color: Colors.white, size: 16),
        ),
      ),
    );
  }
}

Widget _summaryRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
