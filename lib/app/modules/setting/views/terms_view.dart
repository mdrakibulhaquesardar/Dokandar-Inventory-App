import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../widgets/Custom_AppBar.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

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
        l10n.termsAndConditions,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'By using this app, you agree to use it responsibly. The app is provided as-is without warranties. You are responsible for backing up your data. We are not liable for any data loss or damages.',
          style: SafeGoogleFonts.poppins(
            fontSize: 14,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
      ),
    );
  }
}

