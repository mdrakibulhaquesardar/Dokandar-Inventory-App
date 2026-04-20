import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../widgets/Custom_AppBar.dart';

/// A view that displays subscription plans and allows users to purchase them.
/// This view shows the current plan, available subscription packages, and their features.
class SubscriptionView extends GetView {
  const SubscriptionView({super.key});

  // Constants for subscription plans
  static const String _freePlanName = 'ফ্রি';
  static const String _premiumTitle = 'প্রিমিয়াম সাবস্ক্রিপশন নিন!';
  static const String _premiumSubtitle =
      'আপনার প্রয়োজন অনুযায়ী সাবস্ক্রিপশন প্যাকেজ বেছে নিয়ে বড় সুবিধা পান';
  static const String _currentPlanText = 'বর্তমান প্ল্যান: ';
  static const String _featuresTitle = 'ফ্রি প্ল্যানের সুবিধাসমূহ:';
  static const String _packagesTitle = 'সাবস্ক্রিপশন প্যাকেজসমূহ';
  static const String _buyNowText = 'এখনি কিনুন';

  // Feature list for free plan
  static const List<String> _freePlanFeatures = [
    '১০টি পর্যন্ত পণ্য যোগ করতে পারবেন',
    '৫টি পর্যন্ত গ্রাহক যোগ করতে পারবেন',
    'বেসিক রিপোর্ট দেখতে পারবেন',
    '৭ দিনের ট্রায়াল পিরিয়ড',
  ];

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        'সাবস্ক্রিপশন',
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(themeConfig, isDarkMode),
              const SizedBox(height: 24),
              _buildCurrentPlanSection(themeConfig, isDarkMode),
              const SizedBox(height: 24),
              _buildSubscriptionPackages(themeConfig, isDarkMode),
              const SizedBox(height: 16),
              _buildAdditionalInfo(themeConfig, isDarkMode),
              const SizedBox(height: 24),
              _buildNextButton(themeConfig, isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title and subtitle
  Widget _buildHeader(AppThemeConfig themeConfig, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _premiumTitle,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _premiumSubtitle,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

  /// Builds the current plan section showing free plan features
  Widget _buildCurrentPlanSection(AppThemeConfig themeConfig, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.blue.shade700,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '$_currentPlanText$_freePlanName',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _featuresTitle,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 8),
          ..._freePlanFeatures.map((feature) => _buildFeatureItem(feature)),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPackages(
      AppThemeConfig themeConfig, bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _packagesTitle,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildSubscriptionPlan(
                  themeConfig,
                  isDarkMode,
                  '৩ মাস',
                  '৳২৯৯',
                  '৳৯৯/মাস',
                  15,
                  false,
                  'জুলাই ২০২৫',
                  'Access to basic features and support.'),
              const SizedBox(width: 16),
              _buildSubscriptionPlan(
                  themeConfig,
                  isDarkMode,
                  '৬ মাস',
                  '৳৫৯৯',
                  '৳৯৯/মাস',
                  25,
                  true,
                  'অক্টোবর ২০২৫',
                  'Includes premium features and priority support.'),
              const SizedBox(width: 16),
              _buildSubscriptionPlan(
                  themeConfig,
                  isDarkMode,
                  '১ মাস',
                  '৳৯৯',
                  '৳৯৯/মাস',
                  null,
                  false,
                  'এপ্রিল ২০২৫',
                  'Trial period with limited features.'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(AppThemeConfig themeConfig, bool isDarkMode) {
    return Text(
      'আপনার সাবস্ক্রিপশন প্যাকেজ বেছে নিয়ে আরও সুবিধা নিন। আমাদের প্রিমিয়াম প্ল্যানের মাধ্যমে আপনি আরও বেশি সুবিধা পাবেন।',
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: themeConfig.getTextSecondaryColor(isDarkMode),
      ),
    );
  }

  Widget _buildSubscriptionPlan(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    String duration,
    String price,
    String perMonth,
    int? savePercentage,
    bool isSelected,
    String startDate,
    String details, // New parameter for additional details
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected
            ? themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.05)
            : themeConfig.getSurfaceColor(isDarkMode),
        border: isSelected
            ? Border.all(
                color: themeConfig.getPrimaryColor(isDarkMode), width: 1)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: MediaQuery.of(Get.context!).size.width * 0.58,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    duration,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  if (savePercentage != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'সেভ $savePercentage%',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                details, // Display additional details
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    perMonth,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'আপনার বর্তমান অফার শেষ হলে $startDate থেকে নিয়মিত প্লাস রেট প্রযোজ্য হবে।',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(AppThemeConfig themeConfig, bool isDarkMode) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the next page
          // Get.toNamed('/nextPage'); // Replace with your actual route
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        ),
        child: Text(
          _buyNowText,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: themeConfig.getSurfaceColor(isDarkMode),
          ),
        ),
      ),
    );
  }

  /// Builds a feature item with an icon and text
  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.blue.shade700,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
