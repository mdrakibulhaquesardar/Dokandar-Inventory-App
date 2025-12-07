import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/app_config.dart';
import '../../../config/app_theme_config.dart';
import '../../../widgets/Custom_AppBar.dart';

class AboutAppView extends GetView {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.aboutApp,
        true,
        false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.2),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        backgroundImage: const AssetImage('assets/icon.png'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      Get.find <AppConfig>().appCurrentName,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      Get.find<AppConfig>().appCurrentDescription,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // App Info Section
              _buildSection(
                title: l10n.appInfo,
                subtitle: l10n.currentVersionAndDescription,
                icon: Icons.info_outline,
                content: Column(
                  children: [
                    _buildAppInfoCard(
                      title: l10n.currentVersion,
                      value: Get.find<AppConfig>().appCurrentVersion,
                      icon: Icons.phone_android,
                    ),
                    _buildAppInfoCard(
                      title: l10n.updateDate,
                      value: Get.find<AppConfig>().appLastUpdate,
                      icon: Icons.calendar_today,
                    ),
                    _buildAppInfoCard(
                      title: l10n.appSize,
                      value: Get.find<AppConfig>().appCurrentSize,
                      icon: Icons.storage,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Changelog Section
              _buildSection(
                title: l10n.changelog,
                subtitle: l10n.changelogDescription,
                icon: Icons.history,
                content: Column(
                  children: [
                    _buildChangelogItem(
                      version: Get.find<AppConfig>().appCurrentVersion,
                      date: Get.find<AppConfig>().appLastUpdate,
                      changes: Get.find<AppConfig>().appChangeLog,
                      l10n: l10n,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Developer Info Section
              if (!AppConfig.enablePersonalUse)
              _buildSection(
                title: l10n.developerInfo,
                subtitle: l10n.developerInfoDescription,
                icon: Icons.code,
                content: Column(
                  children: [
                    _buildDeveloperCard(
                      name: Get.find<AppConfig>().appDeveloperName,
                      role: l10n.developer,
                      email: Get.find<AppConfig>().appSupportEmail,
                      website: Get.find<AppConfig>().appWebsite,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Legal Section
              _buildSection(
                title: l10n.legalInfo,
                subtitle: l10n.legalInfoDescription,
                icon: Icons.gavel,
                content: Column(
                  children: [
                    _buildLegalItem(
                      title: l10n.privacyPolicy,
                      onTap: () {},
                    ),
                    _buildLegalItem(
                      title: l10n.termsAndConditions,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget content,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        content,
      ],
    );
  }

  Widget _buildAppInfoCard({
    required String title,
    required String value,
    required IconData icon,

  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildChangelogItem({
    required String version,
    required String date,
    required List<String> changes,
    required AppLocalizations l10n,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.version} $version',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...changes.map((change) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          change,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard({
    required String name,
    required String role,
    required String email,
    required String website,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              role,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            _buildContactItem(
              icon: Icons.email,
              text: email,
            ),
            _buildContactItem(
              icon: Icons.language,
              text: website,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
