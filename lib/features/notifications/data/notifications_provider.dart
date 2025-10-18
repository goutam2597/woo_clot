import 'dart:collection';
import 'package:flutter/foundation.dart';

enum NotificationType { order, promo, message, system }

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime time;
  final NotificationType type;
  bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.read = false,
  });
}

class NotificationsController extends ChangeNotifier {
  final List<AppNotification> _items = [];

  UnmodifiableListView<AppNotification> get items => UnmodifiableListView(_items);
  int get unreadCount => _items.where((n) => !n.read).length;

  void seedDummy() {
    if (_items.isNotEmpty) return;
    final now = DateTime.now();
    _items.addAll([
      AppNotification(
        id: 'n1',
        title: 'Order Shipped',
        body: 'Your order #1023 is on the way. Track in Orders.',
        time: now.subtract(const Duration(minutes: 30)),
        type: NotificationType.order,
        read: false,
      ),
      AppNotification(
        id: 'n2',
        title: 'Limited-time Offer',
        body: 'Save 15% on accessories. Use code SAVE15 at checkout.',
        time: now.subtract(const Duration(hours: 3)),
        type: NotificationType.promo,
        read: false,
      ),
      AppNotification(
        id: 'n3',
        title: 'Message from Support',
        body: 'We have updated your ticket. Please check your inbox.',
        time: now.subtract(const Duration(days: 1, hours: 2)),
        type: NotificationType.message,
        read: true,
      ),
      AppNotification(
        id: 'n4',
        title: 'System Update',
        body: 'We improved performance and fixed minor issues.',
        time: now.subtract(const Duration(days: 2)),
        type: NotificationType.system,
        read: true,
      ),
    ]);
    notifyListeners();
  }

  void markAllRead() {
    for (final n in _items) n.read = true;
    notifyListeners();
  }

  void markRead(String id) {
    final i = _items.indexWhere((n) => n.id == id);
    if (i != -1 && !_items[i].read) {
      _items[i].read = true;
      notifyListeners();
    }
  }

  void remove(String id) {
    _items.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}

