import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

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
                      Obx(() {
                        return Text(
                          controller.store.value?.name ??
                              l10n.dataNotFound,
                          style: GoogleFonts.notoSansBengali(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeConfig.getTextPrimaryColor(
                                isDarkMode),
                          ),
                        );
                      }),
                      Obx(() {
                        return Text(
                          controller.store.value?.businessType ??
                              l10n.dataNotFound,
                          style: GoogleFonts.notoSansBengali(
                            fontSize: 12,
                            color: themeConfig.getTextSecondaryColor(
                                isDarkMode),
                          ),
                        );
                      }),
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
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        controller.refresh();
                      },
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
                      l10n.searchProducts,
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
              l10n.summaryInfo,
              style: GoogleFonts.notoSansBengali(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            Text(
              l10n.summaryInfoDescription,
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
                Obx(() {
                  return _SummaryCard(
                    title: l10n.totalProducts,
                    value: controller.totalProducts.value.toString(),
                    icon: Icons.inventory_2_outlined,
                    color: Colors.blue,
                    subtitle: l10n.totalProducts,
                    context: context,
                  );
                }),
                Obx(() {
                  return _SummaryCard(
                    title: l10n.totalSales,
                    value: '৳${controller.totalSales.value.toString()}',
                    icon: Icons.shopping_cart_outlined,
                    color: Colors.green,
                    subtitle: l10n.totalSales,
                    context: context,
                  );
                }),
                Obx(() {
                  return _SummaryCard(
                    title: l10n.categories,
                    value: controller.totalCategories.value.toString(),
                    icon: Icons.category_outlined,
                    color: Colors.orange,
                    subtitle: l10n.categories,
                    context: context,
                  );
                }),
                Obx(() {
                  return _SummaryCard(
                    title: l10n.customers,
                    value: controller.totalCustomers.value.toString(),
                    icon: Icons.people_outline,
                    color: Colors.purple,
                    subtitle: l10n.customers,
                    context: context,
                  );
                }),
                Obx(() {
                  return _SummaryCard(
                    title: l10n.todaysOrders,
                    value: controller.recentSale.length.toString(),
                    icon: Icons.shopping_bag_outlined,
                    color: Colors.teal,
                    subtitle: l10n.newOrder,
                    context: context,
                  );
                }),
                Obx(() {
                  return _SummaryCard(
                    title: l10n.totalProfit,
                    value: controller.totalRevenue.value.toString(),
                    icon: Icons.trending_up,
                    color: Colors.indigo,
                    subtitle: l10n.totalProfit,
                    context: context,
                  );
                }),
              ],
            ),

            const SizedBox(height: 24),
            Text(
              l10n.recentSales,
              style: GoogleFonts.notoSansBengali(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            Text(
              l10n.recentSalesDescription,
              style: GoogleFonts.notoSansBengali(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 16),
            _RecentSalesList(),

            const SizedBox(height: 24),


            controller.allLowStokeProduct.isEmpty
                ? SizedBox()
                : Text(
              l10n.stockAlert,
              style: GoogleFonts.notoSansBengali(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            controller.allLowStokeProduct.isEmpty
                ? SizedBox()
                : Text(
              l10n.stockAlertDescription,
              style: GoogleFonts.notoSansBengali(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),

            const SizedBox(height: 0),
            controller.allLowStokeProduct.isEmpty
                ? SizedBox()
                : _LowStockProductsList(),
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
  final BuildContext context;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
    required this.context,
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

class _RecentSalesList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;


    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        return controller.recentSale.isEmpty
            ? Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              l10n.noRecentSales,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          ),

        )
            : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.recentSale.length,
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
                controller.recentSale[index].items[0].productName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              subtitle: Text(
                '৳${controller.recentSale[index].totalAmount
                    .translateNumberToBengali()}',
                style: GoogleFonts.poppins(
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              trailing: Text(
                "${controller.recentSale[index].items[0].quantity.toInt()
                    .translateNumberToBengali()} পিস",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _LowStockProductsList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.allLowStokeProduct.length,
          itemBuilder: (context, index) {
            return Obx(() {
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
                  controller.allLowStokeProduct[index].name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                subtitle: Text(
                  'স্টকে ${controller.allLowStokeProduct[index].stockQuantity
                      .toInt().translateNumberToBengali()} পিস',
                  style: GoogleFonts.poppins(
                    color: themeConfig.getWarningColor(isDarkMode),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.ALL_PRODUCTS);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    l10n.addToStock,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }
}
