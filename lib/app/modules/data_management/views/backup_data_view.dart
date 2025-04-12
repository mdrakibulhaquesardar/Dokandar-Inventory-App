import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_theme_config.dart';
import '../controllers/data_management_controller.dart';

class BackupDataView extends GetView<DataManagementController> {
  const BackupDataView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: themeConfig
                          .getPrimaryColor(isDarkMode)
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.backup,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'স্থানীয় ব্যাকআপ',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: themeConfig.getSurfaceColor(isDarkMode),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'সর্বশেষ ব্যাকআপ ২০২৩-১০-০১',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      Icons.info_outline,
                      'ডেটা লস প্রতিরোধের জন্য আপনার পিসি বা ইউএসবি ফ্ল্যাশ ড্রাইভে ফাইল ব্যাকআপ করার পরামর্শ দেওয়া হয়।',
                      themeConfig,
                      isDarkMode,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.storage,
                      'আপনি যদি ফোনের মেমরিতে ফাইল ব্যাকআপ করেন, ব্যাকআপ ফাইলগুলি অভ্যন্তরীণ স্টোরেজ/ব্যাকআপে সংরক্ষিত হবে।',
                      themeConfig,
                      isDarkMode,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.security,
                      'আপনি যদি একটি শেয়ার করা ডিভাইসে ডেটা পাঠান, ব্যাকআপ ফাইলগুলি এমন একটি ডিভাইসে সংরক্ষিত হবে যা এটি ডিক্রিপ্ট করতে পারে না।',
                      themeConfig,
                      isDarkMode,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildBackupCard(
                      context,
                      themeConfig,
                      isDarkMode,
                      Icons.backup,
                      'স্থানীয় স্টোরেজে ব্যাকআপ',
                      'আপনার ফোনের মেমরি বা ইউএসবি ফ্ল্যাশ ড্রাইভে ফাইল ব্যাকআপ করুন।',
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildBackupCard(
                      context,
                      themeConfig,
                      isDarkMode,
                      Icons.settings_backup_restore,
                      'স্থানীয় স্টোরেজ থেকে পুনরুদ্ধার',
                      'মেমরি থেকে ব্যাকআপ ফাইল পুনরুদ্ধার করতে পারেন',
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'ব্যাকআপ তৈরি করুন',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),

              Text(
                'ব্যাকআপ তৈরি করতে, আপনার ফোনের মেমরিতে পর্যাপ্ত স্থান থাকতে হবে এবং ব্যাকআপ ফাইলগুলি আপনার ফোনের মেমরিতে সংরক্ষিত হবে।',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeConfig.getPrimaryColor(isDarkMode),
                      themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.8),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: themeConfig
                          .getPrimaryColor(isDarkMode)
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle backup creation
                  },
                  icon: const Icon(Icons.backup, color: Colors.white),
                  label: Text(
                    'নতুন ব্যাকআপ তৈরি করুন',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackupCard(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
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
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
        ),
      ],
    );
  }
}
