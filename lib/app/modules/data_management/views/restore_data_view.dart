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
                width: 35,
                height: 35,
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
                  Icons.settings_backup_restore,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'স্থানীয় স্টোরেজ থেকে পুনরুদ্ধার',
                style: GoogleFonts.poppins(
                  fontSize: 18,
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
              Row(
                children: [
                  Expanded(
                    child: _buildRestoreCard(
                      context,
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
                    child: _buildRestoreCard(
                      context,
                      themeConfig,
                      isDarkMode,
                      Icons.restore,
                      'ডেটা পুনরুদ্ধার করুন',
                      'নির্বাচিত ব্যাকআপ ফাইল থেকে ডেটা পুনরুদ্ধার করুন',
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
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
                          Icons.info_outline,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'পুনরুদ্ধার সম্পর্কে তথ্য',
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
                      Icons.warning_amber_rounded,
                      'পুনরুদ্ধার করার আগে, আপনার বর্তমান ডেটা ব্যাকআপ করার পরামর্শ দেওয়া হয়।',
                      themeConfig,
                      isDarkMode,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.storage,
                      'পুনরুদ্ধার করার সময়, বর্তমান ডেটা মুছে যাবে এবং ব্যাকআপ ফাইলের ডেটা দিয়ে প্রতিস্থাপিত হবে।',
                      themeConfig,
                      isDarkMode,
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      Icons.security,
                      'শুধুমাত্র বৈধ ব্যাকআপ ফাইল থেকে ডেটা পুনরুদ্ধার করা যাবে।',
                      themeConfig,
                      isDarkMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'ডেটা পুনরুদ্ধার করুন',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'পুনরুদ্ধার করতে, আপনার ফোনের মেমরিতে ',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  children: [
                    TextSpan(
                      text: ' দোকানদার নাম ফোল্ডার',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                      ),
                    ),
                    TextSpan(
                      text: ' থেকে একটি বৈধ ব্যাকআপ ফাইল নির্বাচন করুন।',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.isRestoring.value)
                        LinearProgressIndicator(
                          value: controller.restoreProgress.value,
                          backgroundColor: themeConfig
                              .getTextSecondaryColor(isDarkMode)
                              .withOpacity(0.1),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            themeConfig.getPrimaryColor(isDarkMode),
                          ),
                        ),
                      if (controller.restoreStatus.value.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          controller.restoreStatus.value,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color:
                                controller.restoreStatus.value.contains('সফল')
                                    ? Colors.green
                                    : controller.restoreStatus.value
                                            .contains('ব্যর্থ')
                                        ? Colors.red
                                        : themeConfig
                                            .getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ],
                    ],
                  )),
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
                child: Obx(() => ElevatedButton.icon(
                      onPressed: controller.isRestoring.value
                          ? null
                          : () => controller.startRestore(),
                      icon: const Icon(Icons.restore, color: Colors.white),
                      label: Text(
                        controller.isRestoring.value
                            ? 'পুনরুদ্ধার করা হচ্ছে...'
                            : 'ডেটা পুনরুদ্ধার করুন',
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
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRestoreCard(
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
        borderRadius: BorderRadius.circular(10),
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
