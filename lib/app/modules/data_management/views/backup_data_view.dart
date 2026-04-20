import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import '../../../config/app_theme_config.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../controllers/data_management_controller.dart';

class BackupDataView extends GetView<DataManagementController> {
  const BackupDataView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: themeConfig
                          .getPrimaryColor(isDarkMode)
                          .withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.backup,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                l10n.localBackup,
                style: SafeGoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildBackupCard(
                      context,
                      themeConfig,
                      isDarkMode,
                      Icons.backup,
                      l10n.backupToLocalStorage,
                      l10n.backupToLocalDescription,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildBackupCard(
                      context,
                      themeConfig,
                      isDarkMode,
                      Icons.settings_backup_restore,
                      l10n.restoreFromLocal,
                      l10n.restoreFromLocalDescription,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Obx(() => Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.lastBackupDate.value.isNotEmpty
                                  ? l10n.lastBackupDate(
                                      controller.lastBackupDate.value)
                                  : l10n.noBackup,
                              style: SafeGoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color:
                                    themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          Icons.info_outline,
                          l10n.backupPrevention,
                          themeConfig,
                          isDarkMode,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          Icons.storage,
                          l10n.backupStorage,
                          themeConfig,
                          isDarkMode,
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                          Icons.security,
                          l10n.sharedDevice,
                          themeConfig,
                          isDarkMode,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              Text(
                l10n.createBackup,
                style: SafeGoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              Text(
                l10n.backupInstructions(l10n.dokandarFolder),
                style: SafeGoogleFonts.poppins(
                  fontSize: 12,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.isBackingUp.value)
                        LinearProgressIndicator(
                          value: controller.backupProgress.value,
                          backgroundColor: themeConfig
                              .getTextSecondaryColor(isDarkMode)
                              .withValues(alpha: 0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            themeConfig.getPrimaryColor(isDarkMode),
                          ),
                        ),
                      if (controller.backupStatus.value.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          controller.backupStatus.value,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 14,
                            color: controller.backupStatus.value
                                    .contains(l10n.success)
                                ? Colors.green
                                : controller.backupStatus.value
                                        .contains(l10n.error)
                                    ? Colors.red
                                    : themeConfig
                                        .getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ],
                    ],
                  )),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeConfig.getPrimaryColor(isDarkMode),
                      themeConfig
                          .getPrimaryColor(isDarkMode)
                          .withValues(alpha: 0.1),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: themeConfig
                          .getPrimaryColor(isDarkMode)
                          .withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(() => ElevatedButton.icon(
                      onPressed: controller.isBackingUp.value
                          ? null
                          : () => controller.startBackup(),
                      icon: const Icon(Icons.backup, color: Colors.white),
                      label: Text(
                        controller.isBackingUp.value
                            ? l10n.backingUp
                            : l10n.createNewBackup,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackupCard(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: SafeGoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String text,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: SafeGoogleFonts.poppins(
              fontSize: 14,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
        ),
      ],
    );
  }
}
