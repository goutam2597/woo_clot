import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/features/notifications/providers/notifications_provider.dart';
import 'package:flutter_woocommerce/features/notifications/ui/widgets/notifications_tile.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<NotificationsProvider>();
    final items = ctrl.items;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        centerTitle: true,
        rightIcon: Icons.done_all,
        onRight: items.isEmpty || ctrl.unreadCount == 0
            ? null
            : ctrl.markAllRead,
      ),
      body: SafeArea(
        child: items.isEmpty
            ? Center(
                child: Text(
                  'No notifications yet',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                itemBuilder: (context, i) {
                  final n = items[i];
                  return Dismissible(
                    key: ValueKey(n.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) =>
                        context.read<NotificationsProvider>().remove(n.id),
                    child: NotificationsTile(
                      notif: n,
                      onTap: () => context
                          .read<NotificationsProvider>()
                          .markRead(n.id),
                    ),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemCount: items.length,
              ),
      ),
    );
  }
}
