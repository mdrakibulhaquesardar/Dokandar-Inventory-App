import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../data/models/product.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/sell_controller.dart';

class SellView extends GetView<SellController> {
  const SellView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        'বিক্রয় কাউন্টার',
        false,
        true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) => controller.searchProducts(value),
                        decoration: InputDecoration(
                          hintText: 'পণ্য খুঁজুন...',
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          hintStyle: TextStyle(
                            color: themeConfig
                                .getTextPrimaryColor(isDarkMode)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.qr_code_scanner,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                      ),
                      onPressed: () {
                        // TODO: Implement barcode scanning
                      },
                    ),
                  ],
                ),
                Obx(() => controller.searchResults.isNotEmpty &&
                        controller.isSearching.value
                    ? Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: themeConfig.getSurfaceColor(isDarkMode),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: controller.searchResults.length,
                          itemBuilder: (context, index) {
                            final product = controller.searchResults[index];
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              title: Text(
                                product.name,
                                style: TextStyle(
                                  color: themeConfig
                                      .getTextPrimaryColor(isDarkMode),
                                ),
                              ),
                              subtitle: Text(
                                '৳ ${product.unitPrice}',
                                style: TextStyle(
                                  color:
                                      themeConfig.getPrimaryColor(isDarkMode),
                                ),
                              ),
                              onTap: () {
                                controller.addToCart(product);
                                controller.isSearching.value = false;
                              },
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
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = controller.cartItems[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      elevation: 0,
                      child: InkWell(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: themeConfig
                                  .getPrimaryColor(isDarkMode)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.inventory_2,
                              size: 24,
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                          title: Text(
                            product.productName,
                            style: TextStyle(
                              color:
                                  themeConfig.getTextPrimaryColor(isDarkMode),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            '৳ ${product.unitPrice}',
                            style: TextStyle(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
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
                                        size: 20,
                                      ),
                                      onPressed: () =>
                                          controller.decreaseQuantity(index),
                                      padding: const EdgeInsets.all(4),
                                      constraints: const BoxConstraints(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        '${controller.getQuantity(index).toInt()}',
                                        style: TextStyle(
                                          color: themeConfig
                                              .getTextPrimaryColor(isDarkMode),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: themeConfig
                                            .getPrimaryColor(isDarkMode),
                                        size: 20,
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
                      ),
                    );
                  },
                )),
          ),
          // Cart Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'মোট পণ্য: ${controller.cartItems.length}',
                          style: TextStyle(
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                        Text(
                          '৳ ${controller.total.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: themeConfig.getPrimaryColor(isDarkMode),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:  () {
                      if (controller.cartItems.isNotEmpty) {
                        Get.toNamed(Routes.CHECKOUT);
                      } else {
                        Fluttertoast.showToast(
                          msg: 'কোন পণ্য যোগ করা হয়নি',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: themeConfig.getErrorColor(isDarkMode),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'বিক্রয় সম্পন্ন করুন',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
