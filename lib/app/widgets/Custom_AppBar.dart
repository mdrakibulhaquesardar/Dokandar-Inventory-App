import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/app_theme_config.dart';

PreferredSize customAppBar(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    String title,
    bool isBackButtonVisible,
    bool isLogoVisible,
    ) {
  return PreferredSize(
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
          if (isBackButtonVisible)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
          if (isLogoVisible)
          Container(
            width: 35,
            height: 35,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo_only.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
        ],
      ),
    ),
  );
}
