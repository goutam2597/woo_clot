import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_woocommerce/features/products/data/models/products_model.dart';

class WishlistController extends ChangeNotifier {
  final List<ProductsModel> _items = [];

  UnmodifiableListView<ProductsModel> get items => UnmodifiableListView(_items);

  bool contains(ProductsModel product) {
    return _items.any((e) => _sameProduct(e, product));
  }

  void toggle(ProductsModel product) {
    final index = _items.indexWhere((e) => _sameProduct(e, product));
    if (index != -1) {
      _items.removeAt(index);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void remove(ProductsModel product) {
    _items.removeWhere((e) => _sameProduct(e, product));
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool _sameProduct(ProductsModel a, ProductsModel b) =>
      a.title == b.title && a.images == b.images;

  // Seed with some dummy products for demo/testing
  void seedDummy() {
    if (_items.isNotEmpty) return;
    try {
      // Take a few products from the in-memory dummy list
      final seeds = dummyProductList.take(3).toList();
      _items.addAll(seeds);
      notifyListeners();
    } catch (_) {
      // no-op if dummy list is unavailable
    }
  }
}
