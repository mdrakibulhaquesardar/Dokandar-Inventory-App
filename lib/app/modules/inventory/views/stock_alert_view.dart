import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/stock_alert_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/Custom_AppBar.dart';

class StockAlertView extends GetView<StockAlertController> {
  const StockAlertView({super.key});

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
        l10n.stockAlert,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.lowStockProducts.isEmpty) {
            return Center(
              child: Text(
                l10n.dataNotFound,
                style: SafeGoogleFonts.poppins(
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: controller.lowStockProducts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final product = controller.lowStockProducts[index];
              return Card(
                elevation: 0,
                color: themeConfig.getSurfaceColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    product.name,
                    style: SafeGoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Text(
                    '${l10n.stockAlert}: ${product.stockQuantity.toStringAsFixed(0)}',
                    style: SafeGoogleFonts.poppins(
                      color: themeConfig.getWarningColor(isDarkMode),
                      fontSize: 12,
                    ),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () => Get.toNamed(Routes.ALL_PRODUCTS),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                    child: Text(
                      l10n.addToStock,
                      style: SafeGoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

