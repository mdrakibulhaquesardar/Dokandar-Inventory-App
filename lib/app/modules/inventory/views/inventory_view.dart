import 'package:dokandar_app_inventory/app/config/app_config.dart';
import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.totalProducts,
                            style: SafeGoogleFonts.poppins(
                              fontSize: 14,
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            final number = l10n.localeName == 'bn'
                                ? controller.totalProducts.value
                                    .translateNumberToBengali()
                                : controller.totalProducts.value.toString();
                            return Text(
                              '$number ${l10n.pieces}',
                              style: SafeGoogleFonts.poppins(
                                fontSize: 20,
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
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.totalPrice,
                            style: SafeGoogleFonts.poppins(
                              fontSize: 14,
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Obx(() {
                            final price = controller.totalProductsPrice.value;
                            final appConfig = Get.find<AppConfig>();
                            String displayPrice;
                            if (l10n.localeName == 'bn') {
                              // Format first, then translate each digit
                              final formatted = price
                                  .toStringAsFixed(AppConfig.decimalPlaces);
                              const numberMap = {
                                '0': '০',
                                '1': '১',
                                '2': '২',
                                '3': '৩',
                                '4': '৪',
                                '5': '৫',
                                '6': '৬',
                                '7': '৭',
                                '8': '৮',
                                '9': '৯',
                              };
                              displayPrice = formatted.split('').map((char) {
                                return numberMap[char] ?? char;
                              }).join();
                            } else {
                              displayPrice = price
                                  .toStringAsFixed(AppConfig.decimalPlaces);
                            }
                            return Text(
                              '${appConfig.getCurrencySymbol()}$displayPrice',
                              style: SafeGoogleFonts.poppins(
                                fontSize: 20,
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
            const SizedBox(height: 20),
            Text(
              l10n.quickAccess,
              style: SafeGoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              l10n.quickAccessDescription,
              style: SafeGoogleFonts.poppins(
                fontSize: 12,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickChip(
                  label: l10n.allProducts,
                  icon: Icons.inventory_2_outlined,
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.ALL_PRODUCTS),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.salesHistory,
                  icon: Icons.receipt_long_outlined,
                  color: themeConfig.getPrimaryColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.ALL_SALES),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.allCustomers,
                  icon: Icons.person_outline,
                  color: themeConfig.getInfoColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.ALL_CUSTOMER),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.allSuppliers,
                  icon: Icons.people_outline,
                  color: themeConfig.getInfoColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.ALL_SUPPLIERS),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.storeExpenses,
                  icon: Icons.attach_money_outlined,
                  color: themeConfig.getInfoColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.STORE_EXPENSES),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.allEmployees,
                  icon: Icons.person_add_alt_1_outlined,
                  color: themeConfig.getInfoColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.ALL_EMPLOYEES),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.duePayment,
                  icon: Icons.payments_outlined,
                  color: themeConfig.getWarningColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.PAY_DUE),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.stockAlert,
                  icon: Icons.warning_amber_outlined,
                  color: themeConfig.getWarningColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.STOCK_ALERT),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildQuickChip(
                  label: l10n.transactionHistory,
                  icon: Icons.swap_horiz_outlined,
                  color: themeConfig.getSuccessColor(isDarkMode),
                  onTap: () => Get.toNamed(Routes.TRANSACTION_HISTORY),
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              l10n.otherFunctions,
              style: SafeGoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              l10n.otherFunctionsDescription,
              style: SafeGoogleFonts.poppins(
                fontSize: 12,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 6),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
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
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.stockAlert,
                    'icon': Icons.notification_important_outlined,
                    'color': themeConfig.getWarningColor(isDarkMode),
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.generateReport,
                    'icon': Icons.assessment_outlined,
                    'color': themeConfig.getWarningColor(isDarkMode),
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.userManagement,
                    'icon': Icons.people_outlined,
                    'color': Colors.purple,
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.rolesPermissions,
                    'icon': Icons.shield_outlined,
                    'color': Colors.orange,
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.analytics,
                    'icon': Icons.analytics_outlined,
                    'color': Colors.teal,
                    'isLocked': false,
                  },
                  {
                    'title': l10nLocal.fileManagement,
                    'icon': Icons.folder_outlined,
                    'color': Colors.indigo,
                    'isLocked': false,
                  },
                ];
                return Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: themeConfig.getSurfaceColor(isDarkMode),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.toNamed(Routes.PAY_DUE);
                            break;
                          case 1:
                            // Navigate to Product Category
                            Get.toNamed(Routes.CATEGORY);
                            break;
                          case 2:
                            Get.toNamed(Routes.TRANSACTION_HISTORY);
                            break;
                          case 3:
                            Get.toNamed(Routes.ALL_SUPPLIERS);
                            break;
                          case 4:
                            Get.toNamed(Routes.STOCK_ALERT);
                            break;
                          case 5:
                            Get.toNamed(Routes.GENERATE_REPORT);
                            break;
                          case 6:
                            Get.toNamed(Routes.USERS);
                            break;
                          case 7:
                            Get.toNamed(Routes.ROLES);
                            break;
                          case 8:
                            Get.toNamed(Routes.ANALYTICS);
                            break;
                          case 9:
                            Get.toNamed(Routes.FILES);
                            break;
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: ListTile(
                        dense: true,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -3),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        leading: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: (items[index]['color'] as Color)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            items[index]['icon'] as IconData,
                            color: items[index]['color'] as Color,
                            size: 18,
                          ),
                        ),
                        title: Text(
                          items[index]['title'] as String,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                        subtitle: Text(
                          l10nLocal.viewDetails,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 11,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                        trailing: Icon(
                          items[index]['isLocked'] as bool
                              ? Icons.lock
                              : Icons.chevron_right,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                          size: 18,
                        ),
                      ),
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

  Widget _buildOptionCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      AppThemeConfig themeConfig,
      bool isDarkMode,
      bool isLocked,
      BuildContext context) {
    final l10nLocal = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: screenWidth > 400 ? 10 : 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, color: color, size: 22),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: SafeGoogleFonts.poppins(
                        fontSize: screenWidth > 400 ? 13 : 12,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: isLocked
                      ? Icon(
                          Icons.lock,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                          size: 12,
                        )
                      : Text(
                          l10nLocal.newLabel,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            color: color,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickChip({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: SafeGoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
