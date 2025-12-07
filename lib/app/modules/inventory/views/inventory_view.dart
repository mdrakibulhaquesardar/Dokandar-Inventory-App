import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/inventory_controller.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.inventory,
        false,
        true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 0,
                    color: themeConfig.getSurfaceColor(isDarkMode),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.totalProducts,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color:
                              themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return Text(
                              '${controller.totalProducts.value.translateNumberToBengali()} টি',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card(
                    elevation: 0,
                    color: themeConfig.getSurfaceColor(isDarkMode),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.totalPrice,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color:
                              themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            return Text(
                              '৳${controller.totalProductsPrice.value.translateNumberToBengali()}',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              l10n.quickAccess,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              l10n.quickAccessDescription,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.95,
              children: [
                _buildOptionCard(
                  l10n.allProducts,
                  Icons.inventory_2_outlined,
                  themeConfig.getPrimaryColor(isDarkMode),
                      () {
                    Get.toNamed(Routes.ALL_PRODUCTS);
                  },
                  themeConfig,
                  isDarkMode,
                  false,
                  context,
                ),
                _buildOptionCard(
                  l10n.salesHistory,
                  Icons.receipt_long_outlined,
                  themeConfig.getPrimaryColor(isDarkMode),
                      () {
                    Get.toNamed(Routes.ALL_SALES);
                      },
                  themeConfig,
                  isDarkMode,
                  false,
                  context,
                ),
                _buildOptionCard(
                  l10n.allCustomers,
                  Icons.person_outline,
                  themeConfig.getInfoColor(isDarkMode),
                      () {
                    Get.toNamed(Routes.ALL_CUSTOMER);
                  },
                  themeConfig,
                  isDarkMode,
                  false,
                  context,
                ),
                _buildOptionCard(
                  l10n.allSuppliers,
                  Icons.people_outline,
                  themeConfig.getInfoColor(isDarkMode),
                      () {},
                  themeConfig,
                  isDarkMode,
                  true,
                  context,
                ),
                _buildOptionCard(
                  l10n.storeExpenses,
                  Icons.attach_money_outlined,
                  themeConfig.getInfoColor(isDarkMode),
                      () {},
                  themeConfig,
                  isDarkMode,
                  true,
                  context,
                ),
                _buildOptionCard(
                  l10n.allEmployees,
                  Icons.person_add_alt_1_outlined,
                  themeConfig.getInfoColor(isDarkMode),
                      () {},
                  themeConfig,
                  isDarkMode,
                  true,
                  context,
                ),

              ],
            ),
            const SizedBox(height: 24),
            Text(
              l10n.otherFunctions,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              l10n.otherFunctionsDescription,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                final l10nLocal = AppLocalizations.of(context)!;
                final items = [
                  {
                    'title': l10nLocal.duePayment,
                    'icon': Icons.attach_money_outlined,
                    'color': themeConfig.getPrimaryColor(isDarkMode),
                    'isLocked': false,
                  },

                  {
                    'title': l10nLocal.productCategories,
                    'icon': Icons.history,
                    'color': themeConfig.getPrimaryColor(isDarkMode),
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.transactionHistory,
                    'icon': Icons.category,
                    'color': themeConfig.getSuccessColor(isDarkMode),
                    'isLocked': false,

                  },
                  {
                    'title': l10nLocal.supplierManagement,
                    'icon': Icons.people_outline,
                    'color': themeConfig.getInfoColor(isDarkMode),
                    'isLocked': true,
                  },
                  {
                    'title': l10nLocal.stockAlert,
                    'icon': Icons.notification_important_outlined,
                    'color': themeConfig.getWarningColor(isDarkMode),
                    'isLocked': true,
                  },
                  {
                    'title': l10nLocal.generateReport,
                    'icon': Icons.assessment_outlined,
                    'color': themeConfig.getWarningColor(isDarkMode),
                    'isLocked': true,
                  },
                ];
                return Card(
                  elevation: 0,
                  color: themeConfig.getSurfaceColor(isDarkMode),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      //TODO : Implement navigation to respective screen
                      switch (index) {
                        case 0:
                         Get.toNamed(Routes.PAY_DUE);
                          break;
                        case 1:
                        // Navigate to Product Category
                          Get.toNamed(Routes.CATEGORY);
                          break;
                        case 2:
                        // Navigate to Supplier Management
                          break;
                        case 3:
                        // Navigate to Stock Alert
                          break;
                        case 4:
                        // Navigate to Report Generation
                          break;
                      }
                    },
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: items[index]['color'] as Color,
                      child: Icon(
                        items[index]['icon'] as IconData, // Cast to IconData
                        color: themeConfig.getSurfaceColor(isDarkMode),
                        size: 20,
                      ),
                    ),
                    title: Text(
                      items[index]['title'] as String, // Cast to String
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    subtitle: Text(
                      l10nLocal.viewDetails,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    trailing: items[index]['isLocked'] as bool
                        ? Icon(
                      Icons.lock,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                      size: 20,
                    )
                        : Icon(
                      Icons.account_tree_outlined,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                      size: 20,
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

  Widget _buildOptionCard(String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      AppThemeConfig themeConfig,
      bool isDarkMode,
      bool isLocked,
      BuildContext context) {
    final l10nLocal = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      color: themeConfig.getSurfaceColor(isDarkMode),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: MediaQuery
                  .of(Get.context!)
                  .size
                  .width > 400 ? 16 : 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: color.withOpacity(0.1),
                      child: Icon(icon, color: color, size: 20),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery
                          .of(Get.context!)
                          .size
                          .width > 400
                          ? 14
                          : 12,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isLocked
                    ? Icon(
                  Icons.lock,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                  size: 14,
                )
                    : Text(
                  l10nLocal.newLabel,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
