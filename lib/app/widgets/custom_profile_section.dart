import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/safe_google_fonts.dart';
import '../config/app_theme_config.dart';

class CustomProfileSection extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;
  final VoidCallback? onTap;

  const CustomProfileSection({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

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
                backgroundColor: themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl!) as ImageProvider
                      : const AssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    Text(
                      email,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 14,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

