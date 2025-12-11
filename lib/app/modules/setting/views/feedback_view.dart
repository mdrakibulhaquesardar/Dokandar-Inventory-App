import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.feedback,
        true,
        false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Feedback Form Section
              _buildSection(
                title: l10n.giveFeedback,
                subtitle: l10n.feedbackDescription,
                icon: Icons.feedback_outlined,
                content: Column(
                  children: [
                    _buildFeedbackForm(l10n),
                    const SizedBox(height: 24),
                    _buildSubmitButton(l10n),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Feedback Categories Section
              _buildSection(
                title: l10n.feedbackCategories,
                subtitle: l10n.feedbackCategoriesDescription,
                icon: Icons.category_outlined,
                content: SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFeedbackCategory(
                        title: l10n.bugReport,
                        description: l10n.bugReportDescription,
                        icon: Icons.bug_report_outlined,
                        onTap: () => controller.setCategory('bug'),
                      ),
                      _buildFeedbackCategory(
                        title: l10n.featureRequest,
                        description: l10n.featureRequestDescription,
                        icon: Icons.lightbulb_outline,
                        onTap: () => controller.setCategory('feature'),
                      ),
                      _buildFeedbackCategory(
                        title: l10n.generalFeedback,
                        description: l10n.generalFeedbackDescription,
                        icon: Icons.chat_bubble_outline,
                        onTap: () => controller.setCategory('general'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recent Feedback Section
              _buildSection(
                title: l10n.recentFeedback,
                subtitle: l10n.recentFeedbackDescription,
                icon: Icons.history,
                content: Column(
                  children: [
                    _buildRecentFeedback(
                      name: l10n.sampleUserName1,
                      title: l10n.appIsGreat,
                      description: l10n.appIsGreatDescription,
                      rating: 5,
                    ),
                    _buildRecentFeedback(
                      name: l10n.sampleUserName2,
                      title: l10n.someIssues,
                      description: l10n.someIssuesDescription,
                      rating: 3,
                    ),
                    _buildRecentFeedback(
                      name: l10n.sampleUserName3,
                      title: l10n.veryHelpful,
                      description: l10n.veryHelpfulDescription,
                      rating: 5,
                    ),
                    _buildRecentFeedback(
                      name: l10n.sampleUserName4,
                      title: l10n.newFeaturesNeeded,
                      description: l10n.needToAddNewFeatures,
                      rating: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget content,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 24),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        content,
      ],
    );
  }

  Widget _buildFeedbackForm(AppLocalizations l10n) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.writeYourFeedback,
              style: SafeGoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.feedbackTextController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: l10n.writeYourValuableFeedbackHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  l10n.rating,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() {
                  return Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(minWidth: 32, minHeight: 32),
                        onPressed: () => controller.setRating(index + 1),
                        icon: Icon(
                          Icons.star,
                          color: index < controller.rating.value
                              ? Colors.amber
                              : Colors.grey[300],
                          size: 24,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.submitFeedback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          l10n.submit,
          style: SafeGoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackCategory({
    required String title,
    required String description,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.blue, size: 24),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentFeedback({
    required String name,
    required String title,
    required String description,
    required int rating,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: const AssetImage(
                      "assets/images/blank-profile-picture.png"),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        title,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: index < rating ? Colors.amber : Colors.grey[300],
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: SafeGoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}


