import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/order/ui/widgets/address_section.dart';
import 'package:flutter_woocommerce/features/order/ui/widgets/checkout_bottom_button.dart';
import 'package:flutter_woocommerce/features/order/ui/widgets/checkout_section.dart';
import 'package:flutter_woocommerce/features/order/ui/widgets/checkout_coupon_section.dart';
import 'package:flutter_woocommerce/features/cart/providers/cart_provider.dart';
import 'package:flutter_woocommerce/features/coupons/data/models/coupon_model.dart';
import 'package:provider/provider.dart';

import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/features/profile/providers/address_provider.dart';
import 'package:flutter_woocommerce/features/profile/ui/screens/addresses_screen.dart';

enum PaymentMethod { paypal, card, cash }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.totalQuantity,
    required this.subtotal,
    required this.discount,
  });

  final int totalQuantity;
  final double subtotal;
  final double discount;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  PaymentMethod _method = PaymentMethod.card;

  static const double deliveryFee = 2.0;

  Future<void> _showAddressPicker(BuildContext context) async {
    final ctrl = context.read<AddressProvider>();

    if (ctrl.items.isEmpty) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const AddressesScreen()));
      return;
    }

    String selectedId = ctrl.items
        .firstWhere((a) => a.isDefault, orElse: () => ctrl.items.first)
        .id;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return AddressPickerSheet(selectedId: selectedId, controller: ctrl);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressCtrl = context.watch<AddressProvider>();
    final cart = context.watch<CartProvider>();

    final hasAddress = addressCtrl.items.isNotEmpty;
    final defaultAddress = hasAddress
        ? addressCtrl.items.firstWhere(
            (a) => a.isDefault,
            orElse: () => addressCtrl.items.first,
          )
        : null;

    final subtotal = widget.subtotal;
    final discount = widget.discount < 0 ? 0.0 : widget.discount;
    final coupon = cart.couponDiscount;
    // Waive delivery if a free-shipping coupon is applied (simple UI behavior)
    final hasFreeShipping = cart.appliedCoupon?.type == CouponType.freeShipping;
    final delivery = hasFreeShipping ? 0.0 : deliveryFee;
    final total = (subtotal - coupon) + delivery;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Check Out', centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckoutAddressSection(
                hasAddress: hasAddress,
                defaultAddress: defaultAddress,
                onChange: () => _showAddressPicker(context),
              ),
              const SizedBox(height: 20),
              const CheckoutCouponSection(),
              const SizedBox(height: 20),
              CheckoutSummarySection(
                totalQuantity: widget.totalQuantity,
                subtotal: subtotal,
                discount: discount,
                delivery: delivery,
                coupon: coupon,
              ),
              const SizedBox(height: 20),
              CheckoutPaymentSection(
                selectedMethod: _method,
                onMethodSelected: (m) => setState(() => _method = m),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CheckoutBottomButton(
        subtotal: subtotal,
        discount: discount,
        delivery: delivery,
        total: total,
        totalQuantity: widget.totalQuantity,
      ),
    );
  }
}
