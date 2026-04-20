import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import '../../../config/app_theme_config.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../controllers/data_management_controller.dart';

class RestoreDataView extends GetView<DataManagementController> {
  const RestoreDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        title: Text(
          l10n.restoreFromLocal,
          style: SafeGoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 24),
              _buildActionCards(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 24),
              _buildInfoSection(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 24),
              _buildRestoreButton(themeConfig, isDarkMode, l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.history,
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Obx(() => Text(
                    controller.lastBackupDate.value.isNotEmpty
                        ? l10n.lastBackupDate(controller.lastBackupDate.value)
                        : l10n.noBackup,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            themeConfig,
            isDarkMode,
            Icons.folder_open,
            l10n.selectBackupFile,
            l10n.selectBackupDescription,
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            themeConfig,
            isDarkMode,
            Icons.restore,
            l10n.restoreData,
            l10n.restoreDataDescription,
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: SafeGoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: SafeGoogleFonts.poppins(
              fontSize: 12,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.importantInfo,
            style: SafeGoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            Icons.warning_amber_rounded,
            l10n.backupBeforeRestore,
            themeConfig,
            isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.storage,
            l10n.restoreWarning,
            themeConfig,
            isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.security,
            l10n.validBackupOnly,
            themeConfig,
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
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

  Widget _buildRestoreButton(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Obx(() => Column(
          children: [
            if (controller.isRestoring.value)
              Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.restoreProgress.value,
                    backgroundColor: themeConfig
                        .getTextSecondaryColor(isDarkMode)
                        .withValues(alpha: 0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      themeConfig.getPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            if (controller.restoreStatus.value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  controller.restoreStatus.value,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 14,
                    color: controller.restoreStatus.value.contains(l10n.success)
                        ? Colors.green
                        : controller.restoreStatus.value.contains(l10n.error)
                            ? Colors.red
                            : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: controller.isRestoring.value
                    ? null
                    : () => controller.startRestore(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restore,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.isRestoring.value
                          ? l10n.restoring
                          : l10n.restoreDataButton,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}


