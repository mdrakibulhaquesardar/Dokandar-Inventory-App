import 'package:dokandar_app_inventory/app/core/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/extensions.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/all_sales_controller.dart';

class AllSalesView extends GetView<AllSalesController> {
  const AllSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        'বিক্রয় তালিকা',
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeConfig.getSurfaceColor(isDarkMode),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    return _buildStatCard(
                      'মোট বিক্রয়',
                      controller.totalSales.value.toString(),
                      Icons.shopping_cart,
                      themeConfig,
                      isDarkMode,
                    );
                  }),
                  Obx(() {
                    return _buildStatCard(
                      'মোট লেনদেন',
                      controller.totalTransactions.value.toString(),
                      Icons.receipt_long,
                      themeConfig,
                      isDarkMode,
                    );
                  }),
                  Obx(() {
                    return _buildStatCard(
                      'মোট বাকি',
                      controller.totalDue.value.toString(),
                      Icons.money_off,
                      themeConfig,
                      isDarkMode,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.sales.isEmpty) {
                  return Center(
                    child: Text(
                      'কোন বিক্রয় নেই',
                      style: TextStyle(
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                        fontSize: 16,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.sales.length,
                  itemBuilder: (context, index) {
                    final sale = controller.sales[index];
                    return _buildSaleCard(
                      sale,
                      themeConfig,
                      isDarkMode,
                      context,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleCard(
      sale, AppThemeConfig themeConfig, bool isDarkMode, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
        ),
      ),
      child: ListTile(
        onTap: () => _showSaleDetails(context, sale, themeConfig, isDarkMode),
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoice: ${sale.invoiceNumber}',
                  style: TextStyle(
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FutureBuilder<String?>(
                    future: Get.find<DatabaseService>()
                        .getCustomerNameById(sale.customerId),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? 'অজ্ঞাত',
                        style: TextStyle(
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                          fontSize: 12,
                        ),
                      );
                    }),
              ],
            ),
            const Spacer(),
            Text(
              '${sale.totalAmount}৳',
              style: TextStyle(
                color: themeConfig.getPrimaryColor(isDarkMode),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                const SizedBox(width: 4),
                Text(
                  sale.saleDate.toString().split(' ')[0],
                  style: TextStyle(
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
                const Spacer(),
                if (sale.dueAmount > 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'বাকি: ${sale.dueAmount}৳',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSaleDetails(
      BuildContext context, sale, AppThemeConfig themeConfig, bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'বিক্রয় বিবরণ',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 16),
            // Sale details
            _buildDetailRow(
                'ইনভয়েস নং:', sale.invoiceNumber, themeConfig, isDarkMode),
            _buildDetailRow('তারিখ:', sale.saleDate.toString().split(' ')[0],
                themeConfig, isDarkMode),
            _buildDetailRow(
                'মোট মূল্য:', '${sale.totalAmount}৳', themeConfig, isDarkMode),
            _buildDetailRow(
                'ডিসকাউন্ট:', '${sale.discount}৳', themeConfig, isDarkMode),
            _buildDetailRow(
                'প্রদত্ত:', '${sale.paidAmount}৳', themeConfig, isDarkMode),
            _buildDetailRow(
                'বাকি:', '${sale.dueAmount}৳', themeConfig, isDarkMode),

            const SizedBox(height: 16),
            Text(
              'পণ্য তালিকা',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sale.items.length,
              itemBuilder: (context, index) {
                final item = sale.items[index];
                return ListTile(
                  dense: true,
                  title: Text(
                    item.productName,
                    style: TextStyle(
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Text(
                    '${item.quantity} × ${item.unitPrice}৳',
                    style: TextStyle(
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                  trailing: Text(
                    '${item.totalPrice}৳',
                    style: TextStyle(
                      color: themeConfig.getPrimaryColor(isDarkMode),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String label, String value, AppThemeConfig themeConfig, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: themeConfig.getTextPrimaryColor(isDarkMode),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStatCard(String title, String value, IconData icon,
    AppThemeConfig themeConfig, bool isDarkMode) {
  return Column(
    children: [
      Icon(
        icon,
        color: themeConfig.getPrimaryColor(isDarkMode),
        size: 18,
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: themeConfig.getTextPrimaryColor(isDarkMode),
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
      ),
    ],
  );
}
