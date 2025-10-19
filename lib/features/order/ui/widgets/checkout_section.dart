
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/checkout_screen.dart';
import 'package:flutter_woocommerce/features/order/ui/widgets/address_section.dart';
import 'package:flutter_woocommerce/features/order/ui/widgets/order_summary.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/addresses_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutPaymentSection extends StatelessWidget {
  const CheckoutPaymentSection({
    super.key,
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose payment method',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        PaymentTile(
          icon: const FaIcon(FontAwesomeIcons.paypal, color: Color(0xFF003087)),
          label: 'Paypal',
          selected: selectedMethod == PaymentMethod.paypal,
          onTap: () => onMethodSelected(PaymentMethod.paypal),
        ),
        PaymentTile(
          icon: const FaIcon(
            FontAwesomeIcons.solidCreditCard,
            color: Colors.blueGrey,
          ),
          label: 'Credit Card',
          selected: selectedMethod == PaymentMethod.card,
          onTap: () => onMethodSelected(PaymentMethod.card),
        ),
        PaymentTile(
          icon: const FaIcon(
            FontAwesomeIcons.solidMoneyBill1,
            color: Colors.amber,
          ),
          label: 'Cash',
          selected: selectedMethod == PaymentMethod.cash,
          onTap: () => onMethodSelected(PaymentMethod.cash),
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
              color: AppColors.primaryColor.withValues(alpha: 0.1),
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
                  child: Icon(Icons.add, color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CheckoutSummarySection extends StatelessWidget {
  const CheckoutSummarySection({
    super.key,
    required this.totalQuantity,
    required this.subtotal,
    required this.discount,
    required this.delivery,
  });

  final int totalQuantity;
  final double subtotal;
  final double discount;
  final double delivery;

  @override
  Widget build(BuildContext context) {
    final total = subtotal + delivery;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        SummaryCard(
          rows: [
            SummaryRow('Items', totalQuantity.toString()),
            SummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
            SummaryRow('Discount', '\$${discount.toStringAsFixed(0)}'),
            SummaryRow('Delivery Charges', '\$${delivery.toStringAsFixed(0)}'),
          ],
          total: '\$${total.toStringAsFixed(2)}',
        ),
      ],
    );
  }
}

class CheckoutAddressSection extends StatelessWidget {
  const CheckoutAddressSection({
    super.key,
    required this.hasAddress,
    required this.defaultAddress,
    required this.onChange,
  });

  final bool hasAddress;
  final dynamic defaultAddress;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return AddressCard(
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
            onPressed: onChange,
            child: Text(hasAddress ? 'Change' : 'Add'),
          ),
          const SizedBox(width: 4),
          IconButton(
            tooltip: 'Manage',
            icon: const Icon(Icons.edit_location_alt_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddressesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}