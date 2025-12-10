import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../config/app_config.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/sell_controller.dart';

class SellView extends GetView<SellController> {
  const SellView({super.key});
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
        l10n.salesCounter,
        false,
        true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.inventory_2_outlined,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
            onPressed: () {
              Get.toNamed(Routes.ALL_PRODUCTS);
            },
            tooltip: l10n.allProducts,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => controller.searchProducts(value),
                  decoration: InputDecoration(
                    hintText: l10n.searchProducts,
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: themeConfig
                          .getTextPrimaryColor(isDarkMode)
                          .withOpacity(0.5),
                    ),
                  ),
                ),
                Obx(() => controller.searchResults.isNotEmpty &&
                        controller.isSearching.value
                    ? Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: themeConfig.getSurfaceColor(isDarkMode),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            final product = controller.searchResults[index];
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: themeConfig.getBorderColor(isDarkMode).withOpacity(0.1),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                title: Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: themeConfig
                                        .getTextPrimaryColor(isDarkMode),
                                  ),
                                ),
                                subtitle: Obx(() {
                                  final appConfig = Get.find<AppConfig>();
                                  return Text(
                                    '${appConfig.getCurrencySymbol()} ${product.unitPrice}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          themeConfig.getPrimaryColor(isDarkMode),
                                    ),
                                  );
                                }),
                                onTap: () {
                                  controller.addToCart(product);
                                  controller.isSearching.value = false;
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = controller.cartItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        color: themeConfig.getSurfaceColor(isDarkMode),
                        borderRadius: BorderRadius.circular(8),
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
                            Icons.inventory_2,
                            size: 20,
                            color: themeConfig.getPrimaryColor(isDarkMode),
                          ),
                        ),
                        title: Text(
                          product.productName,
                          style: TextStyle(
                            color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Obx(() {
                          final appConfig = Get.find<AppConfig>();
                          return Text(
                            '${appConfig.getCurrencySymbol()} ${product.unitPrice}',
                            style: TextStyle(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          );
                        }),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: themeConfig
                                      .getPrimaryColor(isDarkMode)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: themeConfig
                                            .getPrimaryColor(isDarkMode),
                                        size: 18,
                                      ),
                                      onPressed: () =>
                                          controller.decreaseQuantity(index),
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Text(
                                        '${controller.getQuantity(index).toInt()}',
                                        style: TextStyle(
                                          color: themeConfig
                                              .getTextPrimaryColor(isDarkMode),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: themeConfig
                                            .getPrimaryColor(isDarkMode),
                                        size: 18,
                                      ),
                                      onPressed: () =>
                                          controller.increaseQuantity(index),
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    );
                  },
                )),
          ),
          // Cart Summary
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${l10n.totalProducts}: ${controller.cartItems.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                        Obx(() {
                          final appConfig = Get.find<AppConfig>();
                          return Text(
                            '${appConfig.getCurrencySymbol()} ${controller.total.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          );
                        }),
                      ],
                    )),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:  () {
                      if (controller.cartItems.isNotEmpty) {
                        Get.toNamed(Routes.CHECKOUT);
                      } else {
                        Fluttertoast.showToast(
                          msg: l10n.noProductsAdded,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: themeConfig.getErrorColor(isDarkMode),
                          textColor: Colors.white,
                          fontSize: 14.0,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      l10n.completeSale,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
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
