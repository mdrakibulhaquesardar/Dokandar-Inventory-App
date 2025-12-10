import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../config/app_config.dart';
import '../../../widgets/Custom_AppBar.dart';

/// A view that displays subscription plans and allows users to purchase them.
/// This view shows the current plan, available subscription packages, and their features.
class SubscriptionView extends GetView {
  const SubscriptionView({super.key});

  // Get feature list for free plan from AppConfig
  List<String> _getFreePlanFeatures(AppLocalizations l10n, AppConfig config) {
    return [
      '${config.freeProductLimit} ${l10n.productsUpTo}',
      '${config.freeCustomerLimit} ${l10n.customersUpTo}',
      l10n.basicReports,
      '${config.trialDays} ${l10n.trialPeriodDays}',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.subscription,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 24),
              _buildCurrentPlanSection(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 24),
              _buildSubscriptionPackages(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 16),
              _buildAdditionalInfo(themeConfig, isDarkMode, l10n),
              const SizedBox(height: 24),
              _buildNextButton(themeConfig, isDarkMode, l10n),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title and subtitle
  Widget _buildHeader(AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.premiumSubscription,
          style: SafeGoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.premiumSubtitle,
          style: SafeGoogleFonts.poppins(
            fontSize: 16,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

  /// Builds the current plan section showing free plan features
  Widget _buildCurrentPlanSection(AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    final config = Get.find<AppConfig>();
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
                '${l10n.currentPlan} ${l10n.free}',
                style: SafeGoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            l10n.freePlanFeatures,
            style: SafeGoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
          ),
          const SizedBox(height: 8),
          ..._getFreePlanFeatures(l10n, config).map((feature) => _buildFeatureItem(feature)),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPackages(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    final config = Get.find<AppConfig>();
    final plans = config.subscriptionPlansData;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.subscriptionPackages,
          style: SafeGoogleFonts.poppins(
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
              if (plans['quarterly'] != null)
                _buildSubscriptionPlan(
                  themeConfig,
                  isDarkMode,
                  plans['quarterly']!['name'] ?? '',
                  plans['quarterly']!['price'] ?? '',
                  plans['quarterly']!['perMonth'] ?? '',
                  plans['quarterly']!['savePercentage'] as int?,
                  false,
                  plans['quarterly']!['expiryDate'] ?? '',
                  (plans['quarterly']!['features'] as List).isNotEmpty
                      ? (plans['quarterly']!['features'] as List)[0] ?? ''
                      : '',
                  l10n,
                ),
              if (plans['quarterly'] != null) const SizedBox(width: 16),
              if (plans['halfYearly'] != null)
                _buildSubscriptionPlan(
                  themeConfig,
                  isDarkMode,
                  plans['halfYearly']!['name'] ?? '',
                  plans['halfYearly']!['price'] ?? '',
                  plans['halfYearly']!['perMonth'] ?? '',
                  plans['halfYearly']!['savePercentage'] as int?,
                  true,
                  plans['halfYearly']!['expiryDate'] ?? '',
                  (plans['halfYearly']!['features'] as List).isNotEmpty
                      ? (plans['halfYearly']!['features'] as List)[0] ?? ''
                      : '',
                  l10n,
                ),
              if (plans['halfYearly'] != null) const SizedBox(width: 16),
              if (plans['monthly'] != null)
                _buildSubscriptionPlan(
                  themeConfig,
                  isDarkMode,
                  plans['monthly']!['name'] ?? '',
                  plans['monthly']!['price'] ?? '',
                  plans['monthly']!['perMonth'] ?? '',
                  plans['monthly']!['savePercentage'] as int?,
                  false,
                  plans['monthly']!['expiryDate'] ?? '',
                  (plans['monthly']!['features'] as List).isNotEmpty
                      ? (plans['monthly']!['features'] as List)[0] ?? ''
                      : '',
                  l10n,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Text(
      l10n.subscriptionAdditionalInfo,
      style: SafeGoogleFonts.poppins(
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
    AppLocalizations l10n,
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
                    style: SafeGoogleFonts.poppins(
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
                        '${l10n.save} $savePercentage%',
                        style: SafeGoogleFonts.poppins(
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
                style: SafeGoogleFonts.poppins(
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
                    style: SafeGoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    perMonth,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.subscriptionExpiryNote(startDate),
                style: SafeGoogleFonts.poppins(
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

  Widget _buildNextButton(AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
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
          l10n.buyNow,
          style: SafeGoogleFonts.poppins(
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
              style: SafeGoogleFonts.poppins(
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
