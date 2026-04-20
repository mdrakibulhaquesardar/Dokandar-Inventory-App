import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_theme_config.dart';

class LoadingOverlay {
  static bool isOpen = false;
  static final themeConfig = Get.find<AppThemeConfig>();

  static void show({
    String? message,
  }) {
    if (!isOpen) {
      isOpen = true;
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeConfig.getSurfaceColor(Get.isDarkMode),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: themeConfig
                        .getTextPrimaryColor(Get.isDarkMode)
                        .withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: themeConfig.getTextPrimaryColor(Get.isDarkMode),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false,
        barrierColor:
            themeConfig.getTextPrimaryColor(Get.isDarkMode).withOpacity(0.5),
        useSafeArea: true,
      );
    }
  }

  static void hide() {
    if (isOpen) {
      isOpen = false;
      Get.back();
    }
  }
}
