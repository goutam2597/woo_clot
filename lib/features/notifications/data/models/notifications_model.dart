
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
