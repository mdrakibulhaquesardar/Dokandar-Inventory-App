class Notification {
  int? id;
  final String title;
  final String message;
  final NotificationType type;
  final NotificationCategory category;
  final DateTime createdAt;
  bool isRead;
  String? actionUrl;
  Map<String, dynamic>? metadata;

  Notification({
    this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.category,
    required this.createdAt,
    this.isRead = false,
    this.actionUrl,
    this.metadata,
  });
}

enum NotificationType {
  info,
  warning,
  success,
  error,
  system,
}

enum NotificationCategory {
  all,
  unread,
  important,
  system,
}
