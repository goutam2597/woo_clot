
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/features/notifications/data/notifications_provider.dart';
import 'package:flutter_woocommerce/features/notifications/ui/screens/notifications_screen.dart';
import 'package:provider/provider.dart';

class NotificationAction extends StatelessWidget {
  final ValueChanged<int>? onRequestTabChange;
  const NotificationAction({super.key, this.onRequestTabChange});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsController>(
      builder: (context, notif, _) {
        final count = notif.unreadCount;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.notifications_none, size: 20),
                ),
                if (count > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        count > 9 ? '9+' : '$count',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}