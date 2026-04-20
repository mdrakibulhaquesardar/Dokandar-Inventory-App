import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../../../data/models/team_member.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class UserDetailView extends StatelessWidget {
  final TeamMember user;

  const UserDetailView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    Color statusColor;
    String statusText;

    final l10n = AppLocalizations.of(context)!;
    switch (user.status) {
      case UserStatus.active:
        statusColor = Colors.green;
        statusText = l10n.active;
        break;
      case UserStatus.inactive:
        statusColor = Colors.grey;
        statusText = l10n.inactive;
        break;
      case UserStatus.suspended:
        statusColor = Colors.red;
        statusText = l10n.suspended;
        break;
    }

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        AppLocalizations.of(context)!.viewDetails,
        true,
        false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: SafeGoogleFonts.poppins(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.name,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      statusText,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 11,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
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
                    _buildInfoRow(l10n.email, user.email, Icons.email,
                        themeConfig, isDarkMode),
                    const Divider(),
                    _buildInfoRow(l10n.phone, user.phone, Icons.phone,
                        themeConfig, isDarkMode),
                    const Divider(),
                    _buildInfoRow(l10n.role, user.role, Icons.work, themeConfig,
                        isDarkMode),
                    const Divider(),
                    _buildInfoRow(l10n.department, user.department,
                        Icons.business, themeConfig, isDarkMode),
                    const Divider(),
                    _buildInfoRow(l10n.joined, _formatDate(user.createdAt),
                        Icons.calendar_today, themeConfig, isDarkMode),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon,
      AppThemeConfig themeConfig, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon,
              size: 18, color: themeConfig.getTextSecondaryColor(isDarkMode)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 11,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
