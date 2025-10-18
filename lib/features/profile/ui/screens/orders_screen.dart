import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/app/assets_path.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/order_details_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = _dummyOrders;
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Orders', centerTitle: true),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: orders.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final o = orders[i];
          return Container(
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
              title: Text(
                'Order #${o.id}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${o.itemsCount} items • Placed on ${o.date}'),
                    const SizedBox(height: 2),
                    Text('Total: \$${o.total.toStringAsFixed(2)}'),
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _StatusChip(status: o.status),
                  const SizedBox(height: 4),
                  const Icon(Icons.chevron_right, color: Colors.black38),
                ],
              ),
              onTap: () {
                final details = _buildDetails(o);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => OrderDetailsScreen(details: details),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status; // Delivered, Processing, Cancelled
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    switch (status.toLowerCase()) {
      case 'delivered':
        bg = const Color(0xFFE6F4EA);
        fg = const Color(0xFF1E8E3E);
        break;
      case 'processing':
        bg = const Color(0xFFE6F2FF);
        fg = const Color(0xFF1967D2);
        break;
      case 'cancelled':
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFD93025);
        break;
      default:
        bg = const Color(0xFFF1F3F4);
        fg = Colors.black87;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}

class _OrderItem {
  final String id;
  final String date;
  final int itemsCount;
  final double total;
  final String status;
  const _OrderItem(
    this.id,
    this.date,
    this.itemsCount,
    this.total,
    this.status,
  );
}

const _dummyOrders = <_OrderItem>[
  _OrderItem('1023', '12 Oct 2024', 3, 129.99, 'Delivered'),
  _OrderItem('1024', '20 Oct 2024', 1, 39.90, 'Processing'),
  _OrderItem('1025', '28 Oct 2024', 2, 84.50, 'Cancelled'),
  _OrderItem('1026', '1 Nov 2024', 4, 199.20, 'Delivered'),
];

OrderDetails _buildDetails(_OrderItem o) {
  final items = <OrderItem>[
    OrderItem(
      title: 'Wireless Headphones',
      image: AssetsPath.hp1,
      quantity: 1,
      price: 59.99,
    ),
    OrderItem(
      title: 'Gaming Mouse',
      image: AssetsPath.gamingMouse,
      quantity: 1,
      price: 29.99,
    ),
    OrderItem(
      title: 'USB-C Adapter',
      image: AssetsPath.usbCAdapter,
      quantity: 1,
      price: 19.99,
    ),
  ];
  double subtotal = items.fold(0, (p, e) => p + e.price * e.quantity);
  const shipping = 5.0;
  final discount = o.status.toLowerCase() == 'cancelled' ? 0 : 10.0;
  final total = subtotal + shipping - discount;
  return OrderDetails(
    id: o.id,
    date: o.date,
    status: o.status,
    items: items,
    subtotal: subtotal,
    shipping: shipping,
    discount: discount.toDouble(),
    total: total,
    shippingAddress:
        'Mark Adam\n325 15th Eighth Avenue\nNew York, NY 10011\n+1 212 555 7890',
    paymentMethod: 'Visa **** 4242',
  );
}
