import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../config/app_config.dart';
import '../../../utils/DateTimeUtils.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/AllProductController.dart';

class AllProductsView extends GetView<AllProductController> {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.yourProducts,
        true,
        false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: themeConfig.getSurfaceColor(isDarkMode),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return _buildInfoCard(
                          context,
                          l10n.totalProducts,
                          '${controller.products.length}',
                          Icons.inventory_2,
                          themeConfig,
                          isDarkMode,
                          false);
                    }),
                    Obx(() {
                      return _buildInfoCard(
                        context,
                        l10n.stockOut,
                        '${controller.products.where((product) => product.stockQuantity < AppConfig.lowStockThreshold).length}',
                        Icons.warning,
                        themeConfig,
                        isDarkMode,
                        controller.products
                            .any((product) => product.stockQuantity < AppConfig.lowStockThreshold),
                      );
                    }),
                    Obx(() {
                      return _buildInfoCard(
                          context,
                          l10n.totalPrice,
                          '৳${controller.products.fold(0.0, (sum, item) => sum + item.unitPrice * item.stockQuantity).toStringAsFixed(2)}',
                          Icons.attach_money,
                          themeConfig,
                          isDarkMode,
                          false);
                    }),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.recentProducts,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.85,
                            decoration: BoxDecoration(
                              color: themeConfig.getBackgroundColor(isDarkMode),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.editProduct,
                                  style: SafeGoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: themeConfig
                                        .getTextPrimaryColor(isDarkMode),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: TextEditingController(
                                              text: product.name),
                                          decoration: InputDecoration(
                                            labelText: l10n.productName,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                          ),
                                          onChanged: (value) =>
                                          product.name = value,
                                        ),

                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: TextEditingController(
                                              text: product.stockQuantity
                                                  .toString()),
                                          decoration: InputDecoration(
                                            labelText: l10n.stockQuantity,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                          product.stockQuantity =
                                              double.tryParse(value) ?? 0,
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: TextEditingController(
                                              text:
                                              product.unitPrice.toString()),
                                          decoration: InputDecoration(
                                            labelText: l10n.sellingPrice,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                          product.unitPrice =
                                              double.tryParse(value) ?? 0,
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: TextEditingController(
                                              text: product.buyingPrice
                                                  .toString()),
                                          decoration: InputDecoration(
                                            labelText: l10n.buyingPrice,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) =>
                                          product.buyingPrice =
                                              double.tryParse(value) ?? 0,
                                        ),

                                        const SizedBox(height: 16),
                                        // Text Created At in left side
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: themeConfig
                                                  .getTextSecondaryColor(
                                                  isDarkMode)
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                              BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.trending_up,
                                                      size: 16,
                                                      color: themeConfig
                                                          .getPrimaryColor(
                                                          isDarkMode),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      '${l10n.profit}: ${product.profitMargin.toStringAsFixed(2)}%',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: themeConfig
                                                            .getPrimaryColor(
                                                            isDarkMode),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${l10n.unitProfit}:',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: themeConfig
                                                            .getTextSecondaryColor(
                                                            isDarkMode),
                                                      ),
                                                    ),
                                                    Text(
                                                      '৳${(product.unitPrice - product.buyingPrice).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: themeConfig
                                                            .getTextPrimaryColor(
                                                            isDarkMode),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${l10n.totalProfit}:',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: themeConfig
                                                            .getTextSecondaryColor(
                                                            isDarkMode),
                                                      ),
                                                    ),
                                                    Text(
                                                      '৳${((product.unitPrice - product.buyingPrice) * product.stockQuantity).toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: themeConfig
                                                            .getTextPrimaryColor(
                                                            isDarkMode),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${l10n.totalPrice}:',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: themeConfig
                                                            .getTextSecondaryColor(
                                                            isDarkMode),
                                                      ),
                                                    ),
                                                    Obx(() {
                                                      final appConfig = Get.find<AppConfig>();
                                                      return Text(
                                                        '${appConfig.getCurrencySymbol()}${(product.unitPrice * product.stockQuantity).toStringAsFixed(2)}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: themeConfig
                                                              .getTextPrimaryColor(
                                                              isDarkMode),
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                ),
                                                const Divider(height: 16),
                                                Text(
                                                  '${l10n.createdAt}: ${DateTimeUtils.convertToBengaliDate(product.createdAt)}',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontStyle: FontStyle.italic,
                                                    color: themeConfig
                                                        .getTextSecondaryColor(
                                                        isDarkMode),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                              l10n.deleteProduct,
                                              style: SafeGoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            content: Text(
                                              l10n.confirmDeleteProduct,
                                              style: SafeGoogleFonts.poppins(),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child: Text(
                                                  l10n.no,
                                                  style: TextStyle(
                                                    color: themeConfig
                                                        .getTextSecondaryColor(
                                                        isDarkMode),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  controller.deleteProduct(
                                                      product.id);
                                                  Get.back();
                                                  Get.back();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        12),
                                                  ),
                                                ),
                                                child: Text(l10n.yesDelete),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: Text(
                                        l10n.delete,
                                        style: TextStyle(
                                          color: themeConfig
                                              .getErrorColor(isDarkMode),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        l10n.cancel,
                                        style: TextStyle(
                                          color:
                                          themeConfig.getTextSecondaryColor(
                                              isDarkMode),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.updateProduct(product);
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: themeConfig
                                            .getPrimaryColor(isDarkMode),
                                        foregroundColor: themeConfig
                                            .getBackgroundColor(isDarkMode),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(l10n.save),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: themeConfig
                              .getPrimaryColor(isDarkMode)
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.inventory,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                          size: 30,
                        ),
                      ),
                      title: Text(
                        product.name,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: product.stockQuantity < AppConfig.lowStockThreshold
                                      ? Colors.red.withValues(alpha: 0.1)
                                      : Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${l10n.stock}: ${product.stockQuantity}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: product.stockQuantity < AppConfig.lowStockThreshold
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: themeConfig
                                      .getPrimaryColor(isDarkMode)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Obx(() {
                                  final appConfig = Get.find<AppConfig>();
                                  return Text(
                                    '${appConfig.getCurrencySymbol()}${product.unitPrice}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                      themeConfig.getPrimaryColor(isDarkMode),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Obx(() {
                            final appConfig = Get.find<AppConfig>();
                            return Text(
                              '${l10n.profit}: ${product.profitMargin.toStringAsFixed(2)}% | ${l10n.totalPrice}: ${appConfig.getCurrencySymbol()}${(product.unitPrice * product.stockQuantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        foregroundColor: themeConfig.getTextPrimaryColor(isDarkMode),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: themeConfig.getBackgroundColor(isDarkMode),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.addNewProduct,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: l10n.productName,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onChanged: (value) =>
                            controller.newProduct['name'] = value,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: l10n.category,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: controller.allCategories
                                .map((category) => DropdownMenuItem(
                              value: category.name,
                              child: Text(category.name),
                            ))
                                .toList(),
                            onChanged: (value) =>
                            controller.newProduct['category'] = value,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: l10n.stockQuantity,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                            controller.newProduct['stockQuantity'] =
                                double.tryParse(value) ?? 0,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: l10n.sellingPrice,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                            controller.newProduct['unitPrice'] =
                                double.tryParse(value) ?? 0,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: l10n.buyingPrice,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                            controller.newProduct['buyingPrice'] =
                                double.tryParse(value) ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          l10n.cancel,
                          style: TextStyle(
                            color:
                            themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          controller.saveNewProduct();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          themeConfig.getPrimaryColor(isDarkMode),
                          foregroundColor:
                          themeConfig.getBackgroundColor(isDarkMode),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.save),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        label: Text(
          l10n.addProduct,
          style: TextStyle(
            color: themeConfig.getBackgroundColor(isDarkMode),
          ),
        ),
        icon: Icon(
          Icons.add,
          color: themeConfig.getBackgroundColor(isDarkMode),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      AppThemeConfig themeConfig,
      bool isDarkMode,
      bool isStockOut) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: (screenWidth - 40) / 3,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isStockOut
                ? themeConfig.getErrorColor(isDarkMode)
                : themeConfig.getPrimaryColor(isDarkMode),
            size: 20,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: SafeGoogleFonts.poppins(
              fontSize: 10,
              color: isStockOut
                  ? themeConfig.getErrorColor(isDarkMode)
                  : themeConfig.getTextSecondaryColor(isDarkMode),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: SafeGoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isStockOut
                  ? themeConfig.getErrorColor(isDarkMode)
                  : themeConfig.getTextPrimaryColor(isDarkMode),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}


