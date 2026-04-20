import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_theme_config.dart';
import '../utils/safe_google_fonts.dart';

PreferredSize customAppBar(
  AppThemeConfig themeConfig,
  bool isDarkMode,
  String title,
  bool isBackButtonVisible,
  bool isLogoVisible, {
  List<Widget>? actions,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(56),
    child: SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          children: [
            if (isBackButtonVisible)
              IconButton(
                icon: const Icon(Icons.arrow_back, size: 20),
                onPressed: () {
                  // Use Navigator directly to avoid snackbar-related back issues.
                  final navigator = Get.key.currentState;
                  if (navigator != null && navigator.canPop()) {
                    navigator.pop();
                  }
                },
                color: themeConfig.getTextPrimaryColor(isDarkMode),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            if (isLogoVisible)
              Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo_only.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            Expanded(
              child: Text(
                title,
                style: SafeGoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
            ),
            if (actions != null) ...actions,
          ],
        ),
      ),
    ),
  );
}
