import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(

            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: themeConfig
                        .getPrimaryColor(isDarkMode)
                        .withOpacity(0.1),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<HomeController>(
                        assignId: true,
                        builder: (logic) {
                          return Text(
                            logic.store?.name ?? 'তথ্য খুজে পাওয়া যায়নি',
                            style: GoogleFonts.notoSansBengali(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: themeConfig.getTextPrimaryColor(
                                  isDarkMode),
                            ),
                          );
                        },
                      ),
                      GetBuilder<HomeController>(
                        assignId: true,
                        builder: (logic) {
                          return Text(
                            logic.store?.businessType ?? 'তথ্য খুজে পাওয়া যায়নি',
                            style: GoogleFonts.notoSansBengali(
                              fontSize: 12,
                              color: themeConfig.getTextSecondaryColor(
                                  isDarkMode),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: themeConfig
                          .getErrorColor(isDarkMode)
                          .withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Stack(
                        children: [
                          const Icon(Icons.notifications_outlined),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: themeConfig.getErrorColor(isDarkMode),
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 8,
                                minHeight: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {},
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: themeConfig
                          .getPrimaryColor(isDarkMode)
                          .withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                      color: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: themeConfig.getBackgroundColor(isDarkMode),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'পণ্য অনুসন্ধান করুন',
                      style: GoogleFonts.notoSansBengali(
                        fontSize: 14,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    //TODO : Add search functionality
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.tune),
                      onPressed: () {},
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards Grid
            Text(
              'সারাংশিক তথ্য',
              style: GoogleFonts.notoSansBengali(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            Text(
              'সারাংশিক তথ্য সম্পর্কিত বিবরণ শো করুন সম্পর্কিত বিবরণ শো করুন',
              style: GoogleFonts.notoSansBengali(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _SummaryCard(
                  title: 'মোট পণ্য',
                  value: '১৫০',
                  icon: Icons.inventory_2_outlined,
                  color: Colors.blue,
                  subtitle: 'সর্বমোট পণ্যের সংখ্যা',
                ),
                _SummaryCard(
                  title: 'মোট বিক্রয়',
                  value: '৳২৫,০০০',
                  icon: Icons.shopping_cart_outlined,
                  color: Colors.green,
                  subtitle: 'আজকের মোট বিক্রয়',
                ),
                _SummaryCard(
                  title: 'ক্যাটাগরি',
                  value: '৮',
                  icon: Icons.category_outlined,
                  color: Colors.orange,
                  subtitle: 'সকল ক্যাটাগরি',
                ),
                _SummaryCard(
                  title: 'গ্রাহক',
                  value: '৪৫',
                  icon: Icons.people_outline,
                  color: Colors.purple,
                  subtitle: 'সর্বমোট গ্রাহক',
                ),
                _SummaryCard(
                  title: 'আজকের অর্ডার',
                  value: '১২',
                  icon: Icons.shopping_bag_outlined,
                  color: Colors.teal,
                  subtitle: 'নতুন অর্ডার',
                ),
                _SummaryCard(
                  title: 'মোট লাভ',
                  value: '৳১৫,০০০',
                  icon: Icons.trending_up,
                  color: Colors.indigo,
                  subtitle: 'আজকের মোট লাভ',
                ),
              ],
            ),

            const SizedBox(height: 24),
            Text(
              'সাম্প্রতিক বিক্রয়',
              style: GoogleFonts.notoSansBengali(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            Text(
              'সাম্প্রতিক বিক্রয় তালিকা শো করুন সম্প্রতিক বিক্রয় তালিকা শো করুন',
              style: GoogleFonts.notoSansBengali(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 16),
            _RecentSalesList(),

            const SizedBox(height: 24),

            Text(
              'স্টক শেষ হতে চলেছে',
              style: GoogleFonts.notoSansBengali(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getErrorColor(isDarkMode),
              ),
            ),
            Text(
              'স্টক শেষ হতে ৩ দিন আগে কয়েকটি পণ্যের স্টক শেষ হচ্ছে',
              style: GoogleFonts.notoSansBengali(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),

            const SizedBox(height: 16),
            _LowStockProductsList(),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.notoSansBengali(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.notoSansBengali(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.notoSansBengali(
                  fontSize: 12,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentSalesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
              themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: themeConfig.getPrimaryColor(isDarkMode),
              ),
            ),
            title: Text(
              'Product ${index + 1}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            subtitle: Text(
              '৳${(1000 + index * 200).toString()}',
              style: GoogleFonts.poppins(
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            trailing: Text(
              '2 hours ago',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LowStockProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
              themeConfig.getWarningColor(isDarkMode).withOpacity(0.1),
              child: Icon(
                Icons.warning_amber_outlined,
                color: themeConfig.getWarningColor(isDarkMode),
              ),
            ),
            title: Text(
              'Product ${index + 1}',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            subtitle: Text(
              'Only ${5 - index} items left',
              style: GoogleFonts.poppins(
                color: themeConfig.getWarningColor(isDarkMode),
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Restock',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
