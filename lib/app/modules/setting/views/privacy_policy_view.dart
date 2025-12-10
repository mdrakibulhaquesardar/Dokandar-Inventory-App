import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../widgets/Custom_AppBar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

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
        l10n.privacyPolicy,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'This app respects your privacy. We collect and use information only as necessary to provide our services. Your data is stored locally on your device and is not shared with third parties without your consent.',
          style: SafeGoogleFonts.poppins(
            fontSize: 14,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
      ),
    );
  }
}

