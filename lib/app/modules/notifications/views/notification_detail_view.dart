import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../../../data/models/notification.dart' as model;
import '../../../widgets/Custom_AppBar.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class NotificationDetailView extends StatelessWidget {
  final model.Notification notification;

  const NotificationDetailView({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

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

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        AppLocalizations.of(context)!.notificationDetails,
        true,
        false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: iconColor.withValues(alpha: 0.2),
                      child: Icon(icon, color: iconColor, size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      notification.title,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatDate(notification.createdAt),
                      style: SafeGoogleFonts.poppins(
                        fontSize: 11,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              color: themeConfig.getSurfaceColor(isDarkMode),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.message,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.message,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 13,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (notification.actionUrl != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Demo Only',
                      'Action would navigate to: ${notification.actionUrl}',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.takeAction,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
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
      return '${l10n.yesterday} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return l10n.daysAgo(difference.inDays);
    } else {
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    }
  }
}
