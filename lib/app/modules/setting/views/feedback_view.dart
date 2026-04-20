import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../widgets/Custom_AppBar.dart';

class FeedbackView extends GetView {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        'ফিডব্যাক',
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
                title: 'আপনার মতামত দিন',
                subtitle: 'আমাদের উন্নতির জন্য আপনার মূল্যবান মতামত',
                icon: Icons.feedback_outlined,
                content: Column(
                  children: [
                    _buildFeedbackForm(),
                    const SizedBox(height: 24),
                    _buildSubmitButton(),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Feedback Categories Section
              _buildSection(
                title: 'ফিডব্যাক ক্যাটাগরি',
                subtitle: 'আপনি কোন ধরনের ফিডব্যাক দিতে চান?',
                icon: Icons.category_outlined,
                content: SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFeedbackCategory(
                        title: 'বাগ রিপোর্ট',
                        description: 'অ্যাপে কোন সমস্যা খুঁজে পেয়েছেন?',
                        icon: Icons.bug_report_outlined,
                      ),
                      _buildFeedbackCategory(
                        title: 'ফিচার রিকোয়েস্ট',
                        description: 'নতুন কোন ফিচার চান?',
                        icon: Icons.lightbulb_outline,
                      ),
                      _buildFeedbackCategory(
                        title: 'সাধারণ ফিডব্যাক',
                        description: 'আপনার অভিজ্ঞতা শেয়ার করুন',
                        icon: Icons.chat_bubble_outline,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Recent Feedback Section
              _buildSection(
                title: 'সাম্প্রতিক ফিডব্যাক',
                subtitle: 'অন্যান্য ব্যবহারকারীদের মতামত',
                icon: Icons.history,
                content: Column(
                  children: [
                    _buildRecentFeedback(
                      name: 'রহিম আলী',
                      title: 'অ্যাপটি খুব ভালো',
                      description:
                          'এই অ্যাপটি ব্যবহার করে আমার ব্যবসার অনেক উন্নতি হয়েছে',
                      rating: 5,
                    ),
                    _buildRecentFeedback(
                      name: 'করিম আহমেদ',
                      title: 'কিছু সমস্যা আছে',
                      description: 'কখনও কখনও অ্যাপটি ধীর হয়ে যায়',
                      rating: 3,
                    ),
                    _buildRecentFeedback(
                      name: 'ফাতেমা বেগম',
                      title: 'অত্যন্ত সহায়ক',
                      description: 'সাপোর্ট টিম খুব দ্রুত সাড়া দেয়',
                      rating: 5,
                    ),
                    _buildRecentFeedback(
                      name: 'জাহিদ হাসান',
                      title: 'নতুন ফিচার দরকার',
                      description: 'অ্যাপে কিছু নতুন ফিচার যুক্ত করা দরকার',
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
                  color: Colors.blue.withOpacity(0.1),
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
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
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

  Widget _buildFeedbackForm() {
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
              'আপনার ফিডব্যাক লিখুন',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'আপনার মূল্যবান মতামত লিখুন...',
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
                  'রেটিং:',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    color: index < 4 ? Colors.amber : Colors.grey[300],
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'সাবমিট করুন',
          style: GoogleFonts.poppins(
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
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
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
                style: GoogleFonts.poppins(
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
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
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
              style: GoogleFonts.poppins(
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
