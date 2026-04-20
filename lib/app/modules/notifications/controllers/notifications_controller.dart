import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/notification.dart' as model;

class NotificationsController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();

  final RxList<model.Notification> notifications = <model.Notification>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<model.NotificationCategory> selectedCategory =
      model.NotificationCategory.all.obs;
  final Rx<model.NotificationType?> selectedType =
      Rx<model.NotificationType?>(null);

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    isLoading.value = true;
    try {
      final allNotifications = await _databaseService.getAllNotifications();
      notifications.value = allNotifications;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notifications');
    } finally {
      isLoading.value = false;
    }
  }

  List<model.Notification> get filteredNotifications {
    var filtered = notifications.toList();

    // Filter by category
    if (selectedCategory.value == model.NotificationCategory.unread) {
      filtered = filtered.where((n) => !n.isRead).toList();
    } else if (selectedCategory.value == model.NotificationCategory.important) {
      filtered = filtered
          .where((n) =>
              n.type == model.NotificationType.warning ||
              n.type == model.NotificationType.error)
          .toList();
    } else if (selectedCategory.value == model.NotificationCategory.system) {
      filtered = filtered
          .where((n) => n.category == model.NotificationCategory.system)
          .toList();
    }

    // Filter by type
    if (selectedType.value != null) {
      filtered = filtered.where((n) => n.type == selectedType.value).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return filtered;
  }

  int get unreadCount {
    return notifications.where((n) => !n.isRead).length;
  }

  void setCategory(model.NotificationCategory category) {
    selectedCategory.value = category;
  }

  void setType(model.NotificationType? type) {
    selectedType.value = type;
  }

  Future<void> markAsRead(int? id) async {
    if (id == null) return;
    try {
      await _databaseService.markNotificationAsRead(id);
      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index].isRead = true;
        notifications.refresh();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to mark notification as read');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _databaseService.markAllNotificationsAsRead();
      for (var notification in notifications) {
        notification.isRead = true;
      }
      notifications.refresh();
      Get.snackbar('Success', 'All notifications marked as read');
    } catch (e) {
      Get.snackbar('Error', 'Failed to mark all as read');
    }
  }

  Future<void> deleteNotification(int? id) async {
    if (id == null) return;
    try {
      await _databaseService.deleteNotification(id);
      notifications.removeWhere((n) => n.id == id);
      Get.snackbar('Success', 'Notification deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete notification');
    }
  }

  Future<void> refreshNotifications() async {
    await loadNotifications();
  }
}
