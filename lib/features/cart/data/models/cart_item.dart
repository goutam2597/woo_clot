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
