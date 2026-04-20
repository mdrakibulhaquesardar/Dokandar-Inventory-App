import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../controllers/roles_controller.dart';
import '../../../data/models/role.dart';
import '../../../data/models/permission.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class PermissionsView extends GetView<RolesController> {
  final Role role;

  const PermissionsView({super.key, required this.role});

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
        '${l10n.permissions}: ${role.name}',
        true,
        false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: PermissionCategory.values.length,
        itemBuilder: (context, index) {
          final category = PermissionCategory.values[index];
          final permissions = controller.getPermissionsByCategory(category);

          if (permissions.isEmpty) return const SizedBox.shrink();

          return Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            color: themeConfig.getSurfaceColor(isDarkMode),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              title: Text(
                _getCategoryName(category),
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              children: permissions.map((permission) {
                final isSelected = role.permissionIds.contains(permission.id);
                return CheckboxListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  title: Text(
                    permission.name,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 13,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Text(
                    permission.description,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 11,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                  value: isSelected,
                  onChanged: null, // Read-only view
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  String _getCategoryName(PermissionCategory category) {
    final l10n = AppLocalizations.of(Get.context!)!;
    switch (category) {
      case PermissionCategory.dashboard:
        return l10n.dashboard;
      case PermissionCategory.records:
        return l10n.records;
      case PermissionCategory.reports:
        return l10n.reports;
      case PermissionCategory.users:
        return l10n.users;
      case PermissionCategory.settings:
        return l10n.settings;
      case PermissionCategory.files:
        return l10n.fileManagement;
      case PermissionCategory.analytics:
        return l10n.analytics;
      case PermissionCategory.notifications:
        return l10n.notifications;
    }
  }
}
