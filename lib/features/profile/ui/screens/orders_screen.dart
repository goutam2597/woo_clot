import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/features/order/ui/screens/order_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_woocommerce/features/order/data/orders_provider.dart';
import 'package:flutter_woocommerce/features/profile/data/address_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersController>().items;
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Orders', centerTitle: true),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet'))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
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
                    Text('${o.itemsCount} items • Placed on ${_formatDate(o.createdAt)}'),
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
                final details = _buildDetailsFromRecord(context, o);
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

String _formatDate(DateTime d) {
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

OrderDetails _buildDetailsFromRecord(BuildContext context, OrderRecord r) {
  final items = r.items
      .map((i) => OrderItem(title: i.title, image: i.image, quantity: i.quantity, price: i.price))
      .toList();
  final addr = context.read<AddressController>();
  final has = addr.items.isNotEmpty;
  final a = has
      ? (addr.items.firstWhere((x) => x.isDefault, orElse: () => addr.items.first))
      : null;
  final addrText = has ? '${a!.name}\n${a.line1}\n${a.city}, ${a.state} ${a.zip}\n${a.phone}' : 'No address';
  return OrderDetails(
    id: r.id,
    date: _formatDate(r.createdAt),
    status: r.status,
    items: items,
    subtotal: r.subtotal,
    shipping: r.delivery,
    discount: r.discount,
    total: r.total,
    shippingAddress: addrText,
    paymentMethod: 'Card',
  );
}

