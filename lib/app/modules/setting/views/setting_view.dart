import 'package:dokandar_app_inventory/app/config/app_config.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:dokandar_app_inventory/app/utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../core/services/localization_service.dart';
import '../controllers/setting_controller.dart';
import '../../../config/app_theme_config.dart';
import '../../../widgets/custom_switch.dart';
import '../../../utils/vibration_helper.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Text(
                  l10n.settings,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: themeConfig.getPrimaryColor(isDarkMode),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    Get.find<AppConfig>().appCurrentVersion,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(themeConfig, isDarkMode, l10n),
            const SizedBox(height: 24),
            _buildSectionTitle(l10n.appSettings, themeConfig, isDarkMode, l10n),
            const SizedBox(height: 8),
            _buildSettingCard(
              title: l10n.appTheme,
              icon: Icons.color_lens_outlined,
              color: themeConfig.getPrimaryColor(isDarkMode),
              onTap: () => _showThemeSelector(context, themeConfig, isDarkMode),
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              isLocked: false,
              context: context,
            ),
            if (AppConfig.enableMultiLanguageSupport)
              Obx(() {
                final localizationService = Get.find<LocalizationService>();
                return _buildSettingCard(
                  title: l10n.language,
                  subtitle: localizationService.currentLanguageName,
                  icon: Icons.language_outlined,
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  onTap: () =>
                      _showLanguageSelector(context, themeConfig, isDarkMode),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  isLocked: false,
                  context: context,
                );
              }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildToggleSettingCard(
                title: l10n.enableNotifications,
                icon: Icons.notifications_outlined,
                color: Colors.orange,
                value: appConfig.notificationsEnabled.value,
                onChanged: (value) => appConfig.saveNotificationsEnabled(value),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildToggleSettingCard(
                title: l10n.enableAutoBackup,
                icon: Icons.backup_outlined,
                color: Colors.blue,
                value: appConfig.autoBackupEnabled.value,
                onChanged: (value) => appConfig.saveAutoBackupEnabled(value),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildToggleSettingCard(
                title: l10n.enableSound,
                icon: Icons.volume_up_outlined,
                color: Colors.green,
                value: appConfig.soundEnabled.value,
                onChanged: (value) => appConfig.saveSoundEnabled(value),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildToggleSettingCard(
                title: l10n.enableVibration,
                icon: Icons.vibration_outlined,
                color: Colors.purple,
                value: appConfig.vibrationEnabled.value,
                onChanged: (value) {
                  appConfig.saveVibrationEnabled(value);
                  // Test vibration when enabling
                  if (value) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      VibrationHelper.forceVibrate(
                          type: HapticFeedbackType.medium);
                    });
                  }
                },
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              final fontSizeLabels = {
                12: l10n.small,
                14: l10n.medium,
                16: l10n.large,
                18: l10n.extraLarge,
              };
              return _buildSettingCard(
                title: l10n.fontSize,
                subtitle: fontSizeLabels[appConfig.currentFontSize.value] ??
                    '${appConfig.currentFontSize.value}px',
                icon: Icons.text_fields_outlined,
                color: Colors.indigo,
                onTap: () =>
                    _showFontSizeSelector(context, themeConfig, isDarkMode),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                isLocked: false,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildSettingCard(
                title: l10n.currency,
                subtitle: AppConfig
                        .availableCurrencies[appConfig.currentCurrency.value] ??
                    appConfig.currentCurrency.value,
                icon: Icons.attach_money_outlined,
                color: Colors.amber,
                onTap: () =>
                    _showCurrencySelector(context, themeConfig, isDarkMode),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                isLocked: false,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildSettingCard(
                title: l10n.dateFormat,
                subtitle:
                    AppConfig.dateFormats[appConfig.currentDateFormat.value] ??
                        appConfig.currentDateFormat.value,
                icon: Icons.calendar_today_outlined,
                color: Colors.teal,
                onTap: () =>
                    _showDateFormatSelector(context, themeConfig, isDarkMode),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                isLocked: false,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildSettingCard(
                title: l10n.timeFormat,
                subtitle:
                    AppConfig.timeFormats[appConfig.currentTimeFormat.value] ??
                        appConfig.currentTimeFormat.value,
                icon: Icons.access_time_outlined,
                color: Colors.cyan,
                onTap: () =>
                    _showTimeFormatSelector(context, themeConfig, isDarkMode),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                isLocked: false,
                context: context,
              );
            }),
            Obx(() {
              final appConfig = Get.find<AppConfig>();
              return _buildSettingCard(
                title: l10n.pageSize,
                subtitle:
                    '${appConfig.currentPageSize.value} ${l10n.itemsPerPage}',
                icon: Icons.list_outlined,
                color: Colors.deepPurple,
                onTap: () =>
                    _showPageSizeSelector(context, themeConfig, isDarkMode),
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                isLocked: false,
                context: context,
              );
            }),
            _buildSettingCard(
              title: l10n.clearCache,
              subtitle: l10n.clearCacheDescription,
              icon: Icons.delete_outline,
              color: Colors.red,
              onTap: () => _clearCache(context, themeConfig, isDarkMode),
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              isLocked: false,
              context: context,
            ),
            const SizedBox(height: 10),
            _buildSectionTitle(
                l10n.dataManagement, themeConfig, isDarkMode, l10n),
            const SizedBox(height: 8),
            _buildSettingCard(
              title: l10n.dataBackup,
              icon: Icons.backup_outlined,
              color: Colors.blue,
              onTap: () {
                Get.toNamed(Routes.BACKUP_DATA);
              },
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              context: context,
            ),
            _buildSettingCard(
              title: l10n.dataRestore,
              icon: Icons.restore_outlined,
              color: Colors.green,
              onTap: () {
                Get.toNamed(Routes.RESTORE_DATA);
              },
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              context: context,
            ),
            const SizedBox(height: 10),
            _buildSectionTitle(l10n.storeSetup, themeConfig, isDarkMode, l10n),
            const SizedBox(height: 8),
            _buildSettingCard(
              title: l10n.storeSettings,
              icon: Icons.store_outlined,
              color: Colors.blue,
              onTap: () {
                Get.toNamed(Routes.STORE_SETTINGS);
              },
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              isLocked: false,
              context: context,
            ),
            if (AppConfig.enableSubscription)
              _buildSettingCard(
                title: l10n.subscription,
                icon: Icons.location_on_outlined,
                color: Colors.blue,
                onTap: () {
                  Get.toNamed(Routes.SUBSCRIPTION);
                },
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                isLocked: false,
                context: context,
              ),
            if (!AppConfig.enablePersonalUse) const SizedBox(height: 24),
            AppConfig.enablePersonalUse
                ? _buildSectionTitle(
                    l10n.supportAndHelp, themeConfig, isDarkMode, l10n)
                : _buildSectionTitle(
                    l10n.aboutApp, themeConfig, isDarkMode, l10n),
            const SizedBox(height: 8),
            if (!AppConfig.enablePersonalUse)
              _buildSettingCard(
                title: l10n.supportCenter,
                icon: Icons.phone_outlined,
                color: Colors.red,
                onTap: () {
                  Get.toNamed(Routes.SUPPORT);
                },
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                context: context,
              ),
            if (!AppConfig.enablePersonalUse)
              _buildSettingCard(
                title: l10n.feedback,
                icon: Icons.feedback_outlined,
                color: Colors.amber,
                onTap: () {
                  Get.toNamed(Routes.FEEDBACK);
                },
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
                context: context,
              ),
            _buildSettingCard(
              title: l10n.aboutApp,
              icon: Icons.info_outline,
              color: Colors.blueAccent,
              onTap: () {
                Get.toNamed(Routes.ABOUT_APP);
              },
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppThemeConfig themeConfig,
      bool isDarkMode, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SafeGoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        Text(
          l10n.customizeAppSettings,
          style: SafeGoogleFonts.poppins(
            fontSize: 14,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard({
    required String title,
    String? subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required AppThemeConfig themeConfig,
    bool isLocked = false,
    required bool isDarkMode,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isLocked
                        ? themeConfig
                            .getBorderColor(isDarkMode)
                            .withOpacity(0.1)
                        : color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: isLocked ? Colors.grey : color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 11,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  isLocked ? Icons.lock_outline : Icons.chevron_right,
                  size: 18,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageSelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final localizationService = Get.find<LocalizationService>();
    final l10n = AppLocalizations.of(context)!;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.selectLanguage,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...localizationService.availableLanguages.entries.map((entry) {
              return Obx(() {
                final isSelected =
                    localizationService.currentLanguageCode == entry.key;
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    entry.value,
                    style: SafeGoogleFonts.poppins(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    // Close bottom sheet first to avoid context issues
                    Get.back();
                    // Small delay to ensure bottom sheet is closed
                    await Future.delayed(const Duration(milliseconds: 100));
                    // Then change language
                    await localizationService.changeLanguage(entry.key);
                  },
                );
              });
            }),
            const SizedBox(height: 8),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildProfileSection(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GetBuilder<SettingController>(
                assignId: true,
                builder: (logic) {
                  final userName = logic.user?.name ?? l10n.defaultName;
                  final firstLetter =
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?';
                  return CircleAvatar(
                    radius: 28,
                    backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    child: Text(
                      firstLetter,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.name ?? l10n.defaultName,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.email ?? l10n.dataNotFound,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 12,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.role ?? l10n.dataNotFound,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: themeConfig.getPrimaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                onPressed: () {
                  Get.toNamed(Routes.EDIT_PROFILE);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: themeConfig.getBackgroundColor(isDarkMode),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                GetBuilder<SettingController>(
                  assignId: true,
                  builder: (logic) {
                    return _buildInfoRow(
                      '${l10n.store}:',
                      logic.store?.name ?? l10n.dataNotFound,
                      Icons.store_outlined,
                      themeConfig,
                      isDarkMode,
                    );
                  },
                ),
                const SizedBox(height: 6),
                GetBuilder<SettingController>(
                  assignId: true,
                  builder: (logic) {
                    return _buildInfoRow(
                      '${l10n.joined}:',
                      logic.user?.createdAt != null
                          ? DateTimeUtils.convertToBengaliDate(
                              logic.user!.createdAt)
                          : l10n.dateNotFound,
                      Icons.calendar_today_outlined,
                      themeConfig,
                      isDarkMode,
                    );
                  },
                ),
                const SizedBox(height: 6),
                GetBuilder<SettingController>(
                  assignId: true,
                  builder: (logic) {
                    return _buildInfoRow(
                      '${l10n.mobile}:',
                      logic.user?.phone ?? l10n.noMobileNumber,
                      Icons.phone_outlined,
                      themeConfig,
                      isDarkMode,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: SafeGoogleFonts.poppins(
            fontSize: 12,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: SafeGoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
        ),
      ],
    );
  }

  void _showThemeSelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final l10n = AppLocalizations.of(context)!;
    final appConfig = Get.find<AppConfig>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.appTheme,
              style: SafeGoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => RadioListTile<String>(
                  title: Text('Light'),
                  value: 'light',
                  groupValue: appConfig.currentTheme.value,
                  onChanged: (value) async {
                    if (value != null) {
                      await appConfig.saveTheme(value);
                      Get.back();
                    }
                  },
                )),
            Obx(() => RadioListTile<String>(
                  title: Text('Dark'),
                  value: 'dark',
                  groupValue: appConfig.currentTheme.value,
                  onChanged: (value) async {
                    if (value != null) {
                      await appConfig.saveTheme(value);
                      Get.back();
                    }
                  },
                )),
            Obx(() => RadioListTile<String>(
                  title: Text('System'),
                  value: 'system',
                  groupValue: appConfig.currentTheme.value,
                  onChanged: (value) async {
                    if (value != null) {
                      await appConfig.saveTheme(value);
                      Get.back();
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSettingCard({
    required String title,
    required IconData icon,
    required Color color,
    required bool value,
    required ValueChanged<bool> onChanged,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
            ),
            CustomSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: themeConfig.getPrimaryColor(isDarkMode),
            ),
          ],
        ),
      ),
    );
  }

  void _showFontSizeSelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final appConfig = Get.find<AppConfig>();
    final l10n = AppLocalizations.of(context)!;
    final fontSizeOptions = {
      12: l10n.small,
      14: l10n.medium,
      16: l10n.large,
      18: l10n.extraLarge,
    };

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectFontSize,
              style: SafeGoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            ...fontSizeOptions.entries.map((entry) {
              return Obx(() {
                final isSelected = appConfig.currentFontSize.value == entry.key;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    entry.value,
                    style: SafeGoogleFonts.poppins(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    await appConfig.saveFontSize(entry.key);
                    Get.back();
                  },
                );
              });
            }),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showCurrencySelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final appConfig = Get.find<AppConfig>();
    final l10n = AppLocalizations.of(context)!;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectCurrency,
              style: SafeGoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            ...AppConfig.availableCurrencies.entries.map((entry) {
              return Obx(() {
                final isSelected = appConfig.currentCurrency.value == entry.key;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    entry.value,
                    style: SafeGoogleFonts.poppins(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    await appConfig.saveCurrency(entry.key);
                    Get.back();
                  },
                );
              });
            }),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showDateFormatSelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final appConfig = Get.find<AppConfig>();
    final l10n = AppLocalizations.of(context)!;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectDateFormat,
              style: SafeGoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            ...AppConfig.dateFormats.entries.map((entry) {
              return Obx(() {
                final isSelected =
                    appConfig.currentDateFormat.value == entry.key;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    entry.value,
                    style: SafeGoogleFonts.poppins(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    await appConfig.saveDateFormat(entry.key);
                    Get.back();
                  },
                );
              });
            }),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showTimeFormatSelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final appConfig = Get.find<AppConfig>();
    final l10n = AppLocalizations.of(context)!;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectTimeFormat,
              style: SafeGoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            ...AppConfig.timeFormats.entries.map((entry) {
              return Obx(() {
                final isSelected =
                    appConfig.currentTimeFormat.value == entry.key;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    entry.value,
                    style: SafeGoogleFonts.poppins(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    await appConfig.saveTimeFormat(entry.key);
                    Get.back();
                  },
                );
              });
            }),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _showPageSizeSelector(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final appConfig = Get.find<AppConfig>();
    final l10n = AppLocalizations.of(context)!;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getBackgroundColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectPageSize,
              style: SafeGoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            ...AppConfig.availablePageSizes.map((size) {
              return Obx(() {
                final isSelected = appConfig.currentPageSize.value == size;
                return ListTile(
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    '$size ${l10n.itemsPerPage}',
                    style: SafeGoogleFonts.poppins(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    await appConfig.savePageSize(size);
                    Get.back();
                  },
                );
              });
            }),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _clearCache(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final l10n = AppLocalizations.of(context)!;
    final appConfig = Get.find<AppConfig>();

    Get.dialog(
      AlertDialog(
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        title: Text(
          l10n.clearCache,
          style: SafeGoogleFonts.poppins(
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        content: Text(
          l10n.clearCacheDescription,
          style: SafeGoogleFonts.poppins(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              l10n.cancel,
              style: SafeGoogleFonts.poppins(
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await appConfig.clearCache();
              Get.back();
              Get.snackbar(
                l10n.clearCache,
                l10n.cacheCleared,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                colorText: Colors.white,
              );
            },
            child: Text(
              l10n.clearCache,
              style: SafeGoogleFonts.poppins(
                color: themeConfig.getPrimaryColor(isDarkMode),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
