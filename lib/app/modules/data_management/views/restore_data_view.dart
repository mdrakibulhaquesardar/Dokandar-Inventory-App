import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_theme_config.dart';
import '../controllers/data_management_controller.dart';

class RestoreDataView extends GetView<DataManagementController> {
  const RestoreDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        title: Text(
          'স্থানীয় স্টোরেজ থেকে পুনরুদ্ধার',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(themeConfig, isDarkMode),
              const SizedBox(height: 24),
              _buildActionCards(themeConfig, isDarkMode),
              const SizedBox(height: 24),
              _buildInfoSection(themeConfig, isDarkMode),
              const SizedBox(height: 24),
              _buildRestoreButton(themeConfig, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(AppThemeConfig themeConfig, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.history,
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Obx(() => Text(
                    controller.lastBackupDate.value.isNotEmpty
                        ? 'সর্বশেষ ব্যাকআপ ${controller.lastBackupDate.value}'
                        : 'কোন ব্যাকআপ নেই',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards(AppThemeConfig themeConfig, bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            themeConfig,
            isDarkMode,
            Icons.folder_open,
            'ব্যাকআপ ফাইল নির্বাচন করুন',
            'আপনার ফোনের মেমরি থেকে ব্যাকআপ ফাইল নির্বাচন করুন।',
            Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            themeConfig,
            isDarkMode,
            Icons.restore,
            'ডেটা পুনরুদ্ধার করুন',
            'নির্বাচিত ব্যাকআপ ফাইল থেকে ডেটা পুনরুদ্ধার করুন',
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(AppThemeConfig themeConfig, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'গুরুত্বপূর্ণ তথ্য',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoItem(
            Icons.warning_amber_rounded,
            'পুনরুদ্ধার করার আগে, আপনার বর্তমান ডেটা ব্যাকআপ করার পরামর্শ দেওয়া হয়।',
            themeConfig,
            isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.storage,
            'পুনরুদ্ধার করার সময়, বর্তমান ডেটা মুছে যাবে এবং ব্যাকআপ ফাইলের ডেটা দিয়ে প্রতিস্থাপিত হবে।',
            themeConfig,
            isDarkMode,
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.security,
            'শুধুমাত্র বৈধ ব্যাকআপ ফাইল থেকে ডেটা পুনরুদ্ধার করা যাবে।',
            themeConfig,
            isDarkMode,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
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

  Widget _buildRestoreButton(AppThemeConfig themeConfig, bool isDarkMode) {
    return Obx(() => Column(
          children: [
            if (controller.isRestoring.value)
              Column(
                children: [
                  LinearProgressIndicator(
                    value: controller.restoreProgress.value,
                    backgroundColor: themeConfig
                        .getTextSecondaryColor(isDarkMode)
                        .withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      themeConfig.getPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            if (controller.restoreStatus.value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  controller.restoreStatus.value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: controller.restoreStatus.value.contains('সফল')
                        ? Colors.green
                        : controller.restoreStatus.value.contains('ব্যর্থ')
                            ? Colors.red
                            : themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: controller.isRestoring.value
                    ? null
                    : () => controller.startRestore(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restore,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.isRestoring.value
                          ? 'পুনরুদ্ধার করা হচ্ছে...'
                          : 'ডেটা পুনরুদ্ধার করুন',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
