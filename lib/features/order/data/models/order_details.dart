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
