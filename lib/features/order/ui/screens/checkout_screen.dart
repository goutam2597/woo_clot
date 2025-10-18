import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/order_success_screen.dart';
import 'package:flutter_woocommerce/features/profile/data/address_provider.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/addresses_screen.dart';

enum PaymentMethod { paypal, card, cash }

class CheckoutScreen extends StatefulWidget {
  final int totalQuantity;
  final double subtotal;
  final double discount;
  const CheckoutScreen({
    super.key,
    required this.totalQuantity,
    required this.subtotal,
    required this.discount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _method = PaymentMethod.card;

  Future<void> _showAddressPicker(BuildContext context) async {
    final ctrl = context.read<AddressController>();
    if (ctrl.items.isEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const AddressesScreen()),
      );
      return;
    }

    String selectedId = ctrl.items.firstWhere(
          (a) => a.isDefault,
          orElse: () => ctrl.items.first,
        ).id;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Choose Shipping Address',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final a in ctrl.items)
                            InkWell(
                              onTap: () => setState(() => selectedId = a.id),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _RadioVisual(checked: selectedId == a.id),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${a.name} • ${a.line1}', maxLines: 1, overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontWeight: FontWeight.w700)),
                                          const SizedBox(height: 2),
                                          Text('${a.city}, ${a.state} ${a.zip}\n${a.phone}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        onPressed: () {
                          ctrl.setDefault(selectedId);
                          Navigator.pop(ctx);
                        },
                        child: const Text('Use This Address', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressCtrl = context.watch<AddressController>();
    final hasAddress = addressCtrl.items.isNotEmpty;
    final defaultAddress = hasAddress
        ? (addressCtrl.items.firstWhere(
            (a) => a.isDefault,
            orElse: () => addressCtrl.items.first,
          ))
        : null;
    final itemsCount = widget.totalQuantity;
    final discountedSubtotal = widget.subtotal;
    final double discount = widget.discount < 0 ? 0.0 : widget.discount;
    const delivery = 2.0;
    final total = discountedSubtotal + delivery;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Check Out', centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address card fetched from AddressController
              _AddressCard(
                title: hasAddress
                    ? '${defaultAddress!.name} • ${defaultAddress.line1}'
                    : 'No shipping address',
                subtitle: hasAddress
                    ? '${defaultAddress?.city}, ${defaultAddress?.state} ${defaultAddress?.zip}\nPhone: ${defaultAddress?.phone}'
                    : 'Add a shipping address to continue',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => _showAddressPicker(context),
                      child: Text(hasAddress ? 'Change' : 'Add'),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      tooltip: 'Manage',
                      icon: const Icon(Icons.edit_location_alt_outlined),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AddressesScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Order Summary block
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              _SummaryCard(
                rows: [
                  _SummaryRow('Items', itemsCount.toString()),
                  _SummaryRow(
                    'Subtotal',
                    '\$${discountedSubtotal.toStringAsFixed(2)}',
                  ),
                  _SummaryRow('Discount', '\$${discount.toStringAsFixed(0)}'),
                  _SummaryRow(
                    'Delivery Charges',
                    '\$${delivery.toStringAsFixed(0)}',
                  ),
                ],
                total: '\$${total.toStringAsFixed(2)}',
              ),

              const SizedBox(height: 20),
              const Text(
                'Choose payment method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),

              _PaymentTile(
                icon: const FaIcon(
                  FontAwesomeIcons.paypal,
                  color: Color(0xFF003087),
                ),
                label: 'Paypal',
                selected: _method == PaymentMethod.paypal,
                onTap: () => setState(() => _method = PaymentMethod.paypal),
              ),
              _PaymentTile(
                icon: const FaIcon(
                  FontAwesomeIcons.solidCreditCard,
                  color: Colors.blueGrey,
                ),
                label: 'Credit Card',
                selected: _method == PaymentMethod.card,
                onTap: () => setState(() => _method = PaymentMethod.card),
              ),
              _PaymentTile(
                icon: const FaIcon(
                  FontAwesomeIcons.solidMoneyBill1,
                  color: Colors.amber,
                ),
                label: 'Cash',
                selected: _method == PaymentMethod.cash,
                onTap: () => setState(() => _method = PaymentMethod.cash),
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Add new payment method',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Material(
                    color: AppColors.themeColor.withValues(alpha: 0.1),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Add payment method')),
                        );
                      },
                      child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(Icons.add, color: AppColors.themeColor),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                final itemsCount = widget.totalQuantity;
                final discountedSubtotal = widget.subtotal;
                final double discount = widget.discount < 0
                    ? 0.0
                    : widget.discount;
                const delivery = 2.0;
                final total = discountedSubtotal + delivery;

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => OrderSuccessScreen(
                      itemsCount: itemsCount,
                      subtotal: discountedSubtotal,
                      discount: discount,
                      delivery: delivery,
                      total: total,
                    ),
                  ),
                );
                // Clear cart via provider
                context.read<CartController>().clear();
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
        ),
      ),
    );
  }
}

class _RadioVisual extends StatelessWidget {
  final bool checked;
  const _RadioVisual({required this.checked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: checked ? AppColors.themeColor : Colors.black26,
          width: checked ? 6 : 1.5,
        ),
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  const _AddressCard({
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFF2F2F2),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.location_on, color: AppColors.themeColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
        if (trailing != null) const SizedBox(width: 12),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final List<_SummaryRow> rows;
  final String total;
  const _SummaryCard({required this.rows, required this.total});

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

class _SummaryRow {
  final String label;
  final String value;
  const _SummaryRow(this.label, this.value);
}

class _PaymentTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PaymentTile({
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
            _CheckBubble(checked: selected),
          ],
        ),
      ),
    );
  }
}

class _CheckBubble extends StatelessWidget {
  final bool checked;
  const _CheckBubble({required this.checked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: checked ? AppColors.themeColor : Colors.black26,
          width: checked ? 5 : 1.5,
        ),
      ),
    );
  }
}
