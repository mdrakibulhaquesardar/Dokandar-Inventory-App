import 'package:dokandar_app_inventory/app/utils/DateTimeUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/services/database_service.dart';
import '../controllers/setting_controller.dart';
import '../../../config/app_theme_config.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    DatabaseService databaseService = Get.find<DatabaseService>();

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
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
              Text(
                'সেটিংস',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'বেটা ভার্সন',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(themeConfig, isDarkMode),
            const SizedBox(height: 24),
            _buildSectionTitle('অ্যাপ সেটিংস', themeConfig, isDarkMode),
            const SizedBox(height: 8),
            _buildSettingCard(
              'থিম',
              Icons.palette_outlined,
              themeConfig.getPrimaryColor(isDarkMode),
                  () {},
              themeConfig,
              isDarkMode,
            ),
            _buildSettingCard(
              'ভাষা',
              Icons.language_outlined,
              themeConfig.getPrimaryColor(isDarkMode),
                  () {},
              themeConfig,
              isDarkMode,
            ),
            const SizedBox(height: 10),
            _buildSectionTitle('ডাটা ম্যানেজমেন্ট', themeConfig, isDarkMode),
            const SizedBox(height: 8),
            _buildSettingCard(
              'ব্যাকআপ ডাটা',
              Icons.backup_outlined,
              Colors.green,
                  () {},
              themeConfig,
              isDarkMode,
            ),
            _buildSettingCard(
              'রিস্টোর ডাটা',
              Icons.restore_outlined,
              Colors.orange,
                  () {},
              themeConfig,
              isDarkMode,
            ),
            const SizedBox(height: 10),
            _buildSectionTitle('দোকান সেটআপ', themeConfig, isDarkMode),
            const SizedBox(height: 8),
            _buildSettingCard(
              'দোকানের তথ্য',
              Icons.store_outlined,
              Colors.blue,
                  () {},
              themeConfig,
              isDarkMode,
            ),
            _buildSettingCard(
              'ক্যাটাগরি ম্যানেজমেন্ট',
              Icons.category_outlined,
              Colors.purple,
                  () {},
              themeConfig,
              isDarkMode,
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('সাপোর্ট এবং সহায়তা', themeConfig, isDarkMode),
            const SizedBox(height: 8),
            _buildSettingCard(
              'সাপোর্ট সেন্টার',
              Icons.support_agent_outlined,
              Colors.teal,
                  () {},
              themeConfig,
              isDarkMode,
            ),
            _buildSettingCard(
              'ফিডব্যাক',
              Icons.feedback_outlined,
              Colors.amber,
                  () {},
              themeConfig,
              isDarkMode,
            ),
            _buildSettingCard(
              'অ্যাপ ভার্সন',
              Icons.info_outline,
              Colors.grey,
                  () {},
              themeConfig,
              isDarkMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppThemeConfig themeConfig,
      bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        Text(
          'আপনার অ্যাপ সেটিংস কাস্টমাইজ করুন',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingCard(String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      AppThemeConfig themeConfig,
      bool isDarkMode,) {
    return Card(
      elevation: 0,
      color: themeConfig.getSurfaceColor(isDarkMode),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
      ),
    );
  }

  Widget _buildProfileSection(AppThemeConfig themeConfig, bool isDarkMode) {
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
                backgroundColor:
                themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                child: const CircleAvatar(
                  radius: 38,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.name ?? 'রাকিব',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.email ?? "তথ্য খুজে পাওয়া যায়নি",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: themeConfig.getTextSecondaryColor(
                                isDarkMode),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    GetBuilder<SettingController>(
                      assignId: true,
                      builder: (logic) {
                        return Text(
                          logic.user?.role ?? "তথ্য খুজে পাওয়া যায়নি",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: themeConfig.getPrimaryColor(isDarkMode),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                onPressed: () {
                  // Edit profile action
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeConfig.getBackgroundColor(isDarkMode),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                GetBuilder<SettingController>(
                  assignId: true,
                  builder: (logic) {
                    return _buildInfoRow(
                      'স্টোর:',
                      logic.store?.name ?? 'তথ্য খুজে পাওয়া যায়নি',
                      Icons.store_outlined,
                      themeConfig,
                      isDarkMode,
                    );
                  },
                ),
                const SizedBox(height: 8),
                GetBuilder<SettingController>(
                  assignId: true,
                  builder: (logic) {
                    return _buildInfoRow(
                      'যোগদান:',
                      logic.user?.createdAt != null
                          ? DateTimeUtils.convertToBengaliDate(
                          logic.user!.createdAt)
                          : 'তারিখ খুজে পাওয়া যায়নি',
                      Icons.calendar_today_outlined,
                      themeConfig,
                      isDarkMode,
                    );
                  },
                ),
                const SizedBox(height: 8),
                GetBuilder<SettingController>(
                  assignId: true,
                  builder: (logic) {
                    return _buildInfoRow(
                      'মোবাইল:',
                      logic.user?.phone ?? 'মোবাইল নাম্বার নেই',
                      Icons.phone_outlined,
                      themeConfig,
                      isDarkMode,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label,
      String value,
      IconData icon,
      AppThemeConfig themeConfig,
      bool isDarkMode,) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
        ),
      ],
    );
  }
}