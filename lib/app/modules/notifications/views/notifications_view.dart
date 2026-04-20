import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../controllers/notifications_controller.dart';
import '../../../data/models/notification.dart' as model;
import 'notification_detail_view.dart';
import '../../../widgets/Custom_AppBar.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.notifications,
        true,
        false,
        actions: [
          Obx(() => controller.unreadCount > 0
              ? IconButton(
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.done_all,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: themeConfig.getPrimaryColor(isDarkMode),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${controller.unreadCount}',
                            style: SafeGoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: controller.markAllAsRead,
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: themeConfig.getPrimaryColor(isDarkMode),
            ),
          );
        }

        final filtered = controller.filteredNotifications;

        if (filtered.isEmpty) {
          return _buildEmptyState(themeConfig, isDarkMode, l10n);
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          color: themeConfig.getPrimaryColor(isDarkMode),
          child: Column(
            children: [
              _buildCategoryFilters(themeConfig, isDarkMode),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final notification = filtered[index];
                    return _buildNotificationCard(
                      notification,
                      themeConfig,
                      isDarkMode,
                      context,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCategoryFilters(AppThemeConfig themeConfig, bool isDarkMode) {
    final l10nLocal = AppLocalizations.of(Get.context!)!;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          _buildCategoryChip(
            l10nLocal.all,
            model.NotificationCategory.all,
            themeConfig,
            isDarkMode,
          ),
          const SizedBox(width: 8),
          _buildCategoryChip(
            l10nLocal.unread,
            model.NotificationCategory.unread,
            themeConfig,
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    model.NotificationCategory category,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Obx(() {
      final isSelected = controller.selectedCategory.value == category;
      return FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => controller.setCategory(category),
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        selectedColor: themeConfig.getPrimaryColor(isDarkMode),
        labelStyle: SafeGoogleFonts.poppins(
          fontSize: 12,
          color: isSelected
              ? Colors.white
              : themeConfig.getTextPrimaryColor(isDarkMode),
        ),
      );
    });
  }

  Widget _buildNotificationCard(
    model.Notification notification,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    BuildContext context,
  ) {
    IconData icon;
    Color iconColor;

    switch (notification.type) {
      case model.NotificationType.info:
        icon = Icons.info_outline;
        iconColor = Colors.blue;
        break;
      case model.NotificationType.warning:
        icon = Icons.warning_amber_rounded;
        iconColor = Colors.orange;
        break;
      case model.NotificationType.success:
        icon = Icons.check_circle_outline;
        iconColor = Colors.green;
        break;
      case model.NotificationType.error:
        icon = Icons.error_outline;
        iconColor = Colors.red;
        break;
      case model.NotificationType.system:
        icon = Icons.settings_outlined;
        iconColor = themeConfig.getPrimaryColor(isDarkMode);
        break;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: notification.isRead
          ? themeConfig.getSurfaceColor(isDarkMode)
          : themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: iconColor.withValues(alpha: 0.2),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        title: Text(
          notification.title,
          style: SafeGoogleFonts.poppins(
            fontSize: 13,
            fontWeight: notification.isRead ? FontWeight.w500 : FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              notification.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: SafeGoogleFonts.poppins(
                fontSize: 11,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _formatDate(notification.createdAt),
              style: SafeGoogleFonts.poppins(
                fontSize: 9,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          ],
        ),
        trailing: !notification.isRead
            ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  shape: BoxShape.circle,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete_outline, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                onPressed: () => controller.deleteNotification(notification.id),
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
        onTap: () {
          controller.markAsRead(notification.id);
          Get.to(() => NotificationDetailView(notification: notification));
        },
      ),
    );
  }

  Widget _buildEmptyState(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noNotifications,
            style: SafeGoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.allCaughtUp,
            style: SafeGoogleFonts.poppins(
              fontSize: 14,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    final l10n = AppLocalizations.of(Get.context!)!;
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return l10n.justNow;
        }
        return l10n.minutesAgo(difference.inMinutes);
      }
      return l10n.hoursAgo(difference.inHours);
    } else if (difference.inDays == 1) {
      return l10n.yesterday;
    } else if (difference.inDays < 7) {
      return l10n.daysAgo(difference.inDays);
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
