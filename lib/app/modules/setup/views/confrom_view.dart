import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../controllers/setup_controller.dart';

class ConfromView extends GetView<SetupController> {
  const ConfromView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
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
                controller.storeNameController.text,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color:
                      themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'ধাপ ৩/৩',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                ' ${controller.nameController.text} আপনার দোকান ব্যবস্থাপনার উন্নতি করুন',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              Text(
                'আমাদের শক্তিশালী দোকান ব্যবস্থাপনা টুল দিয়ে আপনার দোকান পরিচালনা শুরু করুন।',
                style: GoogleFonts.poppins(
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 24),
              _buildFeatureCard(
                icon: Icons.store,
                title: 'আপনার দোকানের সকল কার্যক্রম ট্র্যাক করুন',
                description:
                    'একটি সুবিধাজনক স্থানে ইনভেন্টরি, বিক্রয় এবং লেনদেন পরিচালনা করুন।',
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
              ),

              _buildFeatureCard(
                icon: Icons.bar_chart,
                title: 'স্মার্ট ব্যবসায়িক অন্তর্দৃষ্টি',
                description:
                    'সঠিক সিদ্ধান্ত নেওয়ার জন্য বিস্তারিত রিপোর্ট এবং বিশ্লেষণ পান।',
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
              ),

              _buildFeatureCard(
                icon: Icons.lock,
                title: 'নিরাপদ এবং গোপনীয়',
                description:
                    'আপনার দোকানের তথ্য সুরক্ষিত এবং শুধুমাত্র আপনার জন্য অ্যাক্সেসযোগ্য।',
                themeConfig: themeConfig,
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themeConfig.getSurfaceColor(isDarkMode),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: themeConfig
                        .getPrimaryColor(isDarkMode)
                        .withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'আপনার দোকান পরিচালনা শুরু করুন',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'আমাদের শক্তিশালী দোকান ব্যবস্থাপনা টুল দিয়ে শুরু করুন',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  controller.saveSetupData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'শুরু করুন',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: themeConfig.getBackgroundColor(isDarkMode),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
  }) {
    return Card(
      elevation: 0,
      color: themeConfig.getSurfaceColor(isDarkMode),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: themeConfig.getPrimaryColor(isDarkMode),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
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
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
