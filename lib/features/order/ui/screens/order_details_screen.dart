import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';
import 'package:flutter_woocommerce/features/cart/ui/screens/cart_screen.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';
import 'package:flutter_woocommerce/features/categories/data/models/categories_model.dart';
import 'package:flutter_woocommerce/features/products/data/models/details_slider_model.dart';
import 'package:flutter_woocommerce/features/products/data/models/variation_model.dart';
import 'package:flutter_woocommerce/features/products/data/models/reviews_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderDetails details;
  const OrderDetailsScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order #${details.id}', centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          _HeaderRow(
            status: details.status,
            date: details.date,
            total: details.total,
          ),
          const SizedBox(height: 12),
          const Text('Items', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          for (final it in details.items) _ItemTile(item: it),
          const SizedBox(height: 12),
          const Text('Summary', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _SummaryRow('Subtotal', '\$${details.subtotal.toStringAsFixed(2)}'),
          _SummaryRow('Shipping', '\$${details.shipping.toStringAsFixed(2)}'),
          _SummaryRow('Discount', '\$${details.discount.toStringAsFixed(2)}'),
          const Divider(height: 24),
          _SummaryRow(
            'Total',
            '\$${details.total.toStringAsFixed(2)}',
            bold: true,
          ),
          const SizedBox(height: 16),
          const Text(
            'Shipping Address',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(details.shippingAddress),
          const SizedBox(height: 16),
          const Text(
            'Payment Method',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(details.paymentMethod),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Order invoice downloaded')),
                  ),
                  child: const Text('Download Invoice'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  onPressed: () => _reorderToCart(context),
                  child: const Text(
                    'Reorder',
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

  void _reorderToCart(BuildContext context) {
    final cart = context.read<CartController>();
    for (final it in details.items) {
      final product = _findProductFor(it);
      cart.add(product, quantity: it.quantity);
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Items added to cart')));
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const CartScreen()));
  }

  ProductsModel _findProductFor(OrderItem it) {
    final byImage = dummyProductList.where((p) => p.images == it.image);
    if (byImage.isNotEmpty) return byImage.first;
    final t = it.title.toLowerCase();
    final byTitle = dummyProductList.where((p) => p.title.toLowerCase() == t);
    if (byTitle.isNotEmpty) return byTitle.first;
    final priceStr = it.price.toStringAsFixed(2);
    return ProductsModel(
      images: it.image,
      title: it.title,
      shortDetails: 'Reordered item',
      description: '',
      price: priceStr,
      rating: '4.5',
      review: '10',
      discount: priceStr,
      stock: '5',
      discountPercentage: '0%',
      category: CategoryListModel(images: it.image, title: 'Reorder'),
      sliderImages: [DetailsSliderModel(imageUrl: it.image)],
      variations: <VariationModel>[],
      reviews: <ReviewsModel>[],
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final String status;
  final String date;
  final double total;
  const _HeaderRow({
    required this.status,
    required this.date,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.themeColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: AppColors.themeColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(date),
        const Spacer(),
        Text(
          '\$${total.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _ItemTile extends StatelessWidget {
  final OrderItem item;
  const _ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            item.image,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          'Qty: ${item.quantity}  •  Unit: \$${item.price.toStringAsFixed(2)}',
        ),
        trailing: Text(
          '\$${(item.quantity * item.price).toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

Widget _SummaryRow(String label, String value, {bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(label),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class OrderDetails {
  final String id;
  final String date;
  final String status;
  final List<OrderItem> items;
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;
  final String shippingAddress;
  final String paymentMethod;

  const OrderDetails({
    required this.id,
    required this.date,
    required this.status,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
    required this.shippingAddress,
    required this.paymentMethod,
  });
}

class OrderItem {
  final String title;
  final String image;
  final int quantity;
  final double price;
  const OrderItem({
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });
}
