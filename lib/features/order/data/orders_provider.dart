import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/cart/data/cart_controller.dart';

class OrderItemModel {
  final String title;
  final String image;
  final int quantity;
  final double price; // unit price actually paid

  const OrderItemModel({
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });
}

class OrderRecord {
  final String id;
  final DateTime createdAt;
  final List<OrderItemModel> items;
  final double subtotal;
  final double discount;
  final double delivery;
  final double total;
  String status; // e.g., Processing, Delivered, Cancelled

  OrderRecord({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.delivery,
    required this.total,
    this.status = 'Processing',
  });

  int get itemsCount => items.fold(0, (p, e) => p + e.quantity);
}

class OrdersController extends ChangeNotifier {
  final List<OrderRecord> _orders = [];

  UnmodifiableListView<OrderRecord> get items => UnmodifiableListView(_orders);

  void seedDummy() {
    if (_orders.isNotEmpty) return;
    final now = DateTime.now();
    _orders.addAll([
      OrderRecord(
        id: '1023',
        createdAt: now.subtract(const Duration(days: 8)),
        items: const [
          OrderItemModel(title: 'Acoustic Noise-Cancelling Headphones', image: 'assets/dummy/hp1.png', quantity: 1, price: 59.99),
          OrderItemModel(title: 'USB-C Adapter', image: 'assets/dummy/product9.png', quantity: 1, price: 19.99),
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
          OrderItemModel(title: 'Gaming Mouse', image: 'assets/dummy/product6.png', quantity: 1, price: 29.99),
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

  /// Create an order from the current cart and totals, return new order id.
  String placeFromCart(List<CartItem> cartItems, {
    required double subtotal,
    required double discount,
    required double delivery,
    required double total,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final items = cartItems
        .map((e) => OrderItemModel(
              title: e.product.title,
              image: e.product.images,
              quantity: e.quantity,
              price: e.unitPrice,
            ))
        .toList(growable: false);
    _orders.insert(
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

