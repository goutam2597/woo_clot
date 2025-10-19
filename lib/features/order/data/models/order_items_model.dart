class OrderItemModel {
  final String title;
  final String image;
  final int quantity;
  final double price;

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
  String status;

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
