import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/cart/data/models/cart_item.dart';
import 'package:flutter_woocommerce/features/order/data/models/order_items_model.dart';

class OrdersProvider extends ChangeNotifier {
  final List<OrderRecord> orders = [];

  UnmodifiableListView<OrderRecord> get items => UnmodifiableListView(orders);

  void seedDummy() {
    if (orders.isNotEmpty) return;
    final now = DateTime.now();
    orders.addAll([
      OrderRecord(
        id: '1023',
        createdAt: now.subtract(const Duration(days: 8)),
        items: const [
          OrderItemModel(
            title: 'Acoustic Noise-Cancelling Headphones',
            image: 'assets/dummy/hp1.png',
            quantity: 1,
            price: 59.99,
          ),
          OrderItemModel(
            title: 'USB-C Adapter',
            image: 'assets/dummy/product9.png',
            quantity: 1,
            price: 19.99,
          ),
        ],
        subtotal: 79.98,
        discount: 10.0,
        delivery: 5.0,
        total: 74.98,
        status: 'Delivered',
      ),
      OrderRecord(
        id: '1024',
        createdAt: now.subtract(const Duration(days: 2)),
        items: const [
          OrderItemModel(
            title: 'Gaming Mouse',
            image: 'assets/dummy/product6.png',
            quantity: 1,
            price: 29.99,
          ),
        ],
        subtotal: 29.99,
        discount: 0.0,
        delivery: 5.0,
        total: 34.99,
        status: 'Processing',
      ),
    ]);
    notifyListeners();
  }

  String placeFromCart(
    List<CartItem> cartItems, {
    required double subtotal,
    required double discount,
    required double delivery,
    required double total,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final items = cartItems
        .map(
          (e) => OrderItemModel(
            title: e.product.title,
            image: e.product.images,
            quantity: e.quantity,
            price: e.unitPrice,
          ),
        )
        .toList(growable: false);
    orders.insert(
      0,
      OrderRecord(
        id: id,
        createdAt: DateTime.now(),
        items: items,
        subtotal: subtotal,
        discount: discount,
        delivery: delivery,
        total: total,
        status: 'Processing',
      ),
    );
    notifyListeners();
    return id;
  }
}
