import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/common/widgets/custom_app_bar.dart';
import 'package:flutter_woocommerce/features/notifications/data/notifications_provider.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<NotificationsController>();
    final items = ctrl.items;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        centerTitle: true,
        rightIcon: Icons.done_all,
        onRight: items.isEmpty || ctrl.unreadCount == 0 ? null : ctrl.markAllRead,
      ),
      body: SafeArea(
        child: items.isEmpty
            ? Center(
                child: Text(
                  'No notifications yet',
                  style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
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
                    onDismissed: (_) => context.read<NotificationsController>().remove(n.id),
                    child: _NotificationTile(
                      notif: n,
                      onTap: () => context.read<NotificationsController>().markRead(n.id),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemCount: items.length,
              ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notif;
  final VoidCallback onTap;
  const _NotificationTile({required this.notif, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final iconData = _iconFor(notif.type);
    final iconColor = _colorFor(notif.type);
    final timeText = _formatTime(notif.time);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(iconData, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(timeText, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notif.body,
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (!notif.read)
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _iconFor(NotificationType t) {
  switch (t) {
    case NotificationType.order:
      return Icons.local_shipping_outlined;
    case NotificationType.promo:
      return Icons.local_offer_outlined;
    case NotificationType.message:
      return Icons.mail_outline;
    case NotificationType.system:
      return Icons.settings_suggest_outlined;
  }
}

Color _colorFor(NotificationType t) {
  switch (t) {
    case NotificationType.order:
      return const Color(0xFF1E8E3E);
    case NotificationType.promo:
      return const Color(0xFF1967D2);
    case NotificationType.message:
      return const Color(0xFFAA00AA);
    case NotificationType.system:
      return const Color(0xFF6D6D6D);
  }
}

String _formatTime(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  return '${diff.inDays}d ago';
}

