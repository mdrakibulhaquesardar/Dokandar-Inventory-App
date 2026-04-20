import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/app_theme_config.dart';
import '../../../widgets/Custom_AppBar.dart';

class SupportView extends GetView {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      appBar: customAppBar(
          themeConfig, isDarkMode, 'সাপোর্ট এন্ড হেল্প', true, false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Usage Section
              _buildSection(
                title: 'অ্যাপটি কিভাবে ব্যবহার করবেন',
                subtitle: 'শুরু করার জন্য কিছু টিপস',
                icon: Icons.help_outline,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(
                      title: 'শুরু করার জন্য',
                      description:
                          'আমাদের ইনভেন্টরি ম্যানেজমেন্ট সিস্টেমের বেসিক শিখুন',
                      icon: Icons.play_circle_outline,
                    ),
                    _buildInfoCard(
                      title: 'পণ্য ব্যবস্থাপনা',
                      description:
                          'পণ্য যোগ করুন, সম্পাদনা করুন এবং ট্র্যাক করুন',
                      icon: Icons.inventory_2_outlined,
                    ),
                    _buildInfoCard(
                      title: 'বিক্রয় ও রিপোর্ট',
                      description:
                          'বিক্রয় ট্র্যাক করুন এবং বিস্তারিত রিপোর্ট তৈরি করুন',
                      icon: Icons.analytics_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Modules Section
              _buildSection(
                title: 'উপলব্ধ মডিউলসমূহ',
                subtitle: 'আপনার ব্যবসার জন্য উপযোগী',
                icon: Icons.apps,
                content: SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildModuleCard(
                        title: 'ইনভেন্টরি ম্যানেজমেন্ট',
                        description: 'স্টক লেভেল ট্র্যাক এবং ম্যানেজ করুন',
                        icon: Icons.inventory,
                      ),
                      _buildModuleCard(
                        title: 'বিক্রয় ট্র্যাকিং',
                        description: 'বিক্রয় এবং আয় মনিটর করুন',
                        icon: Icons.shopping_cart,
                      ),
                      _buildModuleCard(
                        title: 'গ্রাহক ব্যবস্থাপনা',
                        description: 'গ্রাহকের তথ্য এবং অর্ডার ম্যানেজ করুন',
                        icon: Icons.people_outline,
                      ),
                      _buildModuleCard(
                        title: 'রিপোর্ট ও অ্যানালিটিক্স',
                        description: 'বিস্তারিত ব্যবসায়িক ইনসাইট তৈরি করুন',
                        icon: Icons.bar_chart,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Video Tutorials Section
              _buildSection(
                title: 'ভিডিও টিউটোরিয়াল',
                subtitle: 'শিখুন এবং দক্ষতা অর্জন করুন',
                icon: Icons.video_library,
                content: Column(
                  children: [
                    _buildVideoCard(
                      title: 'শুরু করার গাইড',
                      description: '৫ মিনিটে বেসিক শিখুন',
                      thumbnail: 'assets/images/video_placeholder.png',
                    ),
                    _buildVideoCard(
                      title: 'এডভান্সড ফিচার',
                      description: 'এডভান্সড ফিচারগুলো আয়ত্ত করুন',
                      thumbnail: 'assets/images/video_placeholder.png',
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
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    softWrap: true,
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
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.blue, size: 36),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 14,
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

  Widget _buildVideoCard({
    required String title,
    required String description,
    required String thumbnail,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Icon(Icons.play_circle_filled,
                      size: 60, color: Colors.grey[600]),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '5:30',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
