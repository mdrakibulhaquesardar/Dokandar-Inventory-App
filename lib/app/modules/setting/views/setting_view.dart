import 'package:dokandar_app_inventory/app/config/app_config.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:dokandar_app_inventory/app/utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/services/localization_service.dart';
import '../controllers/setting_controller.dart';
import '../../../config/app_theme_config.dart';

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
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
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
                style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
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
              onTap: () {},
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              isLocked: true,
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
                  onTap: () => _showLanguageSelector(context, themeConfig, isDarkMode),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  isLocked: false,
                  context: context,
                );
              }),
            const SizedBox(height: 10),
            _buildSectionTitle(l10n.dataManagement, themeConfig, isDarkMode, l10n),
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
              onTap: () {},
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              isLocked: true,
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
            if (!AppConfig.enablePersonalUse)
            const SizedBox(height: 24),
            AppConfig.enablePersonalUse ?
            _buildSectionTitle(l10n.supportAndHelp, themeConfig, isDarkMode, l10n)
            : _buildSectionTitle(l10n.aboutApp, themeConfig, isDarkMode, l10n) ,
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

  Widget _buildSectionTitle(
      String title, AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        Text(
          l10n.customizeAppSettings,
          style: GoogleFonts.poppins(
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
    return Card(
      elevation: 0,
      color: themeConfig.getSurfaceColor(isDarkMode),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isLocked
              ? themeConfig.getBorderColor(isDarkMode)
              : themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
          child: Icon(icon, color: isLocked ? Colors.grey : color, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              )
            : null,
        trailing: Icon(
          isLocked ? Icons.lock_outline : Icons.arrow_forward_ios_outlined,
          size: 16,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
      ),
    );
  }

  void _showLanguageSelector(BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
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
                  style: GoogleFonts.poppins(
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
                final isSelected = localizationService.currentLanguageCode == entry.key;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? themeConfig.getPrimaryColor(isDarkMode)
                        : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  title: Text(
                    entry.value,
                    style: GoogleFonts.poppins(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  onTap: () async {
                    final success = await localizationService.changeLanguage(entry.key);
                    if (success) {
                      Get.back();
                    }
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

  Widget _buildProfileSection(AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor:
                    themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                child: const CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.name ?? l10n.defaultName,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.email ?? l10n.dataNotFound,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.role ?? l10n.dataNotFound,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
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
                icon: Icon(
                  Icons.edit_outlined,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                onPressed: () {
                  // Edit profile action
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
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
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
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
          size: 16,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
        ),
      ],
    );
  }
}
