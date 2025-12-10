import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../utils/safe_google_fonts.dart';
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
        preferredSize: const Size.fromHeight(130),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Obx(() {
                      final storeName =
                          controller.store.value?.name ?? l10n.dataNotFound;
                      final firstLetter = storeName.isNotEmpty
                          ? storeName[0].toUpperCase()
                          : '?';
                      return CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            themeConfig.getPrimaryColor(isDarkMode),
                        child: Text(
                          firstLetter,
                          style: SafeGoogleFonts.notoSansBengali(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              controller.store.value?.name ?? l10n.dataNotFound,
                              style: SafeGoogleFonts.notoSansBengali(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            );
                          }),
                          Obx(() {
                            return Text(
                              controller.store.value?.businessType ??
                                  l10n.dataNotFound,
                              style: SafeGoogleFonts.notoSansBengali(
                                fontSize: 11,
                                color: themeConfig
                                    .getTextSecondaryColor(isDarkMode),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: themeConfig
                            .getPrimaryColor(isDarkMode)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh, size: 14),
                        onPressed: () {
                          controller.refresh();
                        },
                        color: themeConfig.getPrimaryColor(isDarkMode),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.SEARCH);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: themeConfig.getBackgroundColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 18,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.searchProducts,
                            style: SafeGoogleFonts.notoSansBengali(
                              fontSize: 13,
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Cards Grid
              Text(
                l10n.summaryInfo,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.summaryInfoDescription,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.6,
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

              const SizedBox(height: 20),
              Text(
                l10n.recentSales,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.recentSalesDescription,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 12),
              _RecentSalesList(),

              const SizedBox(height: 20),

              controller.allLowStokeProduct.isEmpty
                  ? const SizedBox()
                  : Text(
                      l10n.stockAlert,
                      style: SafeGoogleFonts.notoSansBengali(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
              controller.allLowStokeProduct.isEmpty
                  ? const SizedBox()
                  : Text(
                      l10n.stockAlertDescription,
                      style: SafeGoogleFonts.notoSansBengali(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),

              const SizedBox(height: 2),
              controller.allLowStokeProduct.isEmpty
                  ? SizedBox()
                  : _LowStockProductsList(),
            ],
          ),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Text(
                value,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              Text(
                subtitle,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 11,
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        return controller.recentSale.isEmpty
            ? Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeConfig.getSurfaceColor(isDarkMode),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    l10n.noRecentSales,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
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
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: themeConfig
                              .getBorderColor(isDarkMode)
                              .withOpacity(0.1),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      leading: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: themeConfig
                              .getPrimaryColor(isDarkMode)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 18,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                        ),
                      ),
                      title: Text(
                        controller.recentSale[index].items[0].productName,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      subtitle: Text(
                        '৳${controller.recentSale[index].totalAmount.translateNumberToBengali()}',
                        style: SafeGoogleFonts.poppins(
                          fontSize: 12,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                      trailing: Text(
                        "${controller.recentSale[index].items[0].quantity.toInt().translateNumberToBengali()} পিস",
                        style: SafeGoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
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
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.allLowStokeProduct.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeConfig
                          .getBorderColor(isDarkMode)
                          .withOpacity(0.1),
                      width: 0.5,
                    ),
                  ),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: themeConfig
                          .getWarningColor(isDarkMode)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.warning_amber_outlined,
                      size: 18,
                      color: themeConfig.getWarningColor(isDarkMode),
                    ),
                  ),
                  title: Text(
                    controller.allLowStokeProduct[index].name,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Text(
                    l10n.stockInPieces(controller
                        .allLowStokeProduct[index].stockQuantity
                        .toInt()
                        .translateNumberToBengali()),
                    style: SafeGoogleFonts.poppins(
                      fontSize: 12,
                      color: themeConfig.getWarningColor(isDarkMode),
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.ALL_PRODUCTS);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      l10n.addToStock,
                      style: SafeGoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
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
