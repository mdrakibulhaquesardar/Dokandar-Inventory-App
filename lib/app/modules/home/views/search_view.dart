import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/Custom_AppBar.dart';

class SearchView extends GetView<HomeController> {
  const SearchView({super.key});

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
        l10n.searchProducts,
        true,
        false,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    focusNode: controller.searchFocusNode,
                    autofocus: true,
                    onChanged: controller.searchProducts,
                    onSubmitted: (_) {
                      controller.unfocusSearch();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: l10n.searchProducts,
                      hintStyle: SafeGoogleFonts.notoSansBengali(
                        fontSize: 14,
                        color:
                            themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    style: SafeGoogleFonts.notoSansBengali(
                      fontSize: 14,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Search Results
          Expanded(
            child: Obx(() {
              if (controller.searchQuery.value.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Search for products',
                        style: SafeGoogleFonts.poppins(
                          fontSize: 16,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              if (controller.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No products found',
                        style: SafeGoogleFonts.poppins(
                          fontSize: 16,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final product = controller.searchResults[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 0,
                    color: themeConfig.getSurfaceColor(isDarkMode),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        product.name,
                        style: SafeGoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'SKU: ${product.sku}',
                            style: SafeGoogleFonts.poppins(
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Price: ৳${product.unitPrice.toStringAsFixed(2)}',
                                style: SafeGoogleFonts.poppins(
                                  color: themeConfig.getPrimaryColor(isDarkMode),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Stock: ${product.stockQuantity.toString()}',
                                style: SafeGoogleFonts.poppins(
                                  color: product.stockQuantity > 0
                                      ? themeConfig.getSuccessColor(isDarkMode)
                                      : themeConfig.getErrorColor(isDarkMode),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      onTap: () {
                        controller.unfocusSearch();
                        Get.toNamed(Routes.ALL_PRODUCTS);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

}

