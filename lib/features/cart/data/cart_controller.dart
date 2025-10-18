import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';

class CartItem {
  final ProductsModel product;
  final String? color;
  final String? size;
  final String? storage;
  int quantity;

  CartItem({
    required this.product,
    this.color,
    this.size,
    this.storage,
    this.quantity = 1,
  });

  double get unitPrice => double.tryParse(product.discount) ?? 0.0;
  double get total => unitPrice * quantity;

  // Equality based on product and selected attributes
  @override
  bool operator ==(Object other) {
    return other is CartItem &&
        other.product.title == product.title &&
        other.product.images == product.images &&
        other.color == color &&
        other.size == size &&
        other.storage == storage;
  }

  @override
  int get hashCode => Object.hash(
    product.title,
    product.images,
    color ?? '',
    size ?? '',
    storage ?? '',
  );
}

class CartController extends ChangeNotifier {
  final List<CartItem> _items = [];

  UnmodifiableListView<CartItem> get items => UnmodifiableListView(_items);

  int get totalQuantity =>
      _items.fold<int>(0, (prev, e) => prev + (e.quantity));

  double get subtotal => _items.fold<double>(0.0, (prev, e) => prev + e.total);

  double get originalSubtotal => _items.fold<double>(
    0.0,
    (prev, e) =>
        prev + ((double.tryParse(e.product.price) ?? 0.0) * e.quantity),
  );

  double get totalDiscount => originalSubtotal - subtotal;

  void add(
    ProductsModel product, {
    int quantity = 1,
    String? color,
    String? size,
    String? storage,
  }) {
    final index = _items.indexWhere(
      (e) =>
          e.product.title == product.title &&
          e.product.images == product.images &&
          e.color == color &&
          e.size == size &&
          e.storage == storage,
    );
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          product: product,
          quantity: quantity,
          color: color,
          size: size,
          storage: storage,
        ),
      );
    }
    notifyListeners();
  }

  int quantityFor(
    ProductsModel product, {
    String? color,
    String? size,
    String? storage,
  }) {
    final index = _items.indexWhere(
      (e) =>
          e.product.title == product.title &&
          e.product.images == product.images &&
          e.color == color &&
          e.size == size &&
          e.storage == storage,
    );
    if (index == -1) return 0;
    return _items[index].quantity;
  }

  void decrement(
    ProductsModel product, {
    int by = 1,
    String? color,
    String? size,
    String? storage,
  }) {
    final index = _items.indexWhere(
      (e) =>
          e.product.title == product.title &&
          e.product.images == product.images &&
          e.color == color &&
          e.size == size &&
          e.storage == storage,
    );
    if (index != -1) {
      _items[index].quantity -= by;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  void setQuantity(CartItem item, int quantity) {
    if (quantity <= 0) {
      remove(item);
      return;
    }
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  // Seed cart with a few dummy items for demo/testing
  void seedDummy() {
    if (_items.isNotEmpty) return;
    try {
      final list = dummyProductList.take(3).toList();
      if (list.isEmpty) return;
      add(list[0], quantity: 1);
      if (list.length > 1) add(list[1], quantity: 2);
      if (list.length > 2) add(list[2], quantity: 1);
    } catch (_) {
      // ignore if dummy list unavailable
    }
  }
}
