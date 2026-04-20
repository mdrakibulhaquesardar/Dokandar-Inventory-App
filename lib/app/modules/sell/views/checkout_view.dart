import 'package:dokandar_app_inventory/app/widgets/Custom_AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../controllers/invoice_generator_controller.dart';
import '../controllers/sell_controller.dart';

class CheckoutView extends GetView<SellController> {
  const CheckoutView({super.key});

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
        l10n.completeOrder,
        true,
        false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 90.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Section
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: themeConfig
                                    .getPrimaryColor(isDarkMode)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.receipt_outlined,
                                color: themeConfig.getPrimaryColor(isDarkMode),
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.orderSummary,
                              style: SafeGoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                l10n.newOrder,
                                style: SafeGoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Obx(() =>
                            Column(
                              children: [
                                ...controller.cartItems
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final item = entry.value;
                                  return Column(
                                    children: [
                                      Obx(() {
                                        final appConfig = Get.find<AppConfig>();
                                        return _buildCostRow(
                                          item.productName,
                                          item.quantity.toInt(),
                                          '${appConfig.getCurrencySymbol()}${item.totalPrice.toStringAsFixed(2)}',
                                          themeConfig,
                                          isDarkMode,
                                        );
                                      }),
                                      const SizedBox(height: 6),
                                    ],
                                  );
                                }),
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: themeConfig
                                        .getPrimaryColor(isDarkMode)
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.total,
                                        style: SafeGoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: themeConfig
                                              .getTextPrimaryColor(isDarkMode),
                                        ),
                                      ),
                                      Obx(() {
                                        final appConfig = Get.find<AppConfig>();
                                        return Text(
                                          '${appConfig.getCurrencySymbol()}${controller.total.value.toStringAsFixed(2)}',
                                          style: SafeGoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: themeConfig
                                                .getPrimaryColor(isDarkMode),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Customer and Payment Section
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: themeConfig.getSurfaceColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: themeConfig
                                    .getAccentColor(isDarkMode)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: themeConfig.getAccentColor(isDarkMode),
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.customerInfo,
                              style: SafeGoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            ),
                            Text(
                              ' ${l10n.optional}',
                              style: SafeGoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: themeConfig
                                    .getTextSecondaryColor(isDarkMode),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: themeConfig.getBackgroundColor(isDarkMode),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: '0',
                                child: Text(
                                  l10n.unknown,
                                  style: SafeGoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              ...controller.customers
                                  .map((customer) =>
                                  DropdownMenuItem<String>(
                                    value: customer.id.toString(),
                                    child: Text(
                                      customer.name,
                                      style: SafeGoogleFonts.poppins(
                                        fontSize: 13,
                                      ),
                                    ),
                                  )),
                            ],
                            onChanged: (value) =>
                                controller.setSelectedCustomer(value ?? '0'),
                            initialValue: '0',
                            style: SafeGoogleFonts.poppins(
                              fontSize: 13,
                              color: themeConfig.getTextPrimaryColor(isDarkMode),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: l10n.discount,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: themeConfig.getPrimaryColor(isDarkMode),
                                      width: 1.5,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.discount_outlined,
                                    color:
                                    themeConfig.getAccentColor(isDarkMode),
                                    size: 18,
                                  ),
                                  labelStyle: SafeGoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                ),
                                style: SafeGoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: controller.setDiscount,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: l10n.dueAmount,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: themeConfig.getPrimaryColor(isDarkMode),
                                      width: 1.5,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color:
                                    themeConfig.getAccentColor(isDarkMode),
                                    size: 18,
                                  ),
                                  labelStyle: SafeGoogleFonts.poppins(
                                    fontSize: 13,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                ),
                                style: SafeGoogleFonts.poppins(
                                  fontSize: 13,
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: controller.setDueAmount,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: l10n.orderNote,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: themeConfig.getPrimaryColor(isDarkMode),
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.note_outlined,
                              color: themeConfig.getAccentColor(isDarkMode),
                              size: 18,
                            ),
                            labelStyle: SafeGoogleFonts.poppins(
                              fontSize: 13,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                          style: SafeGoogleFonts.poppins(
                            fontSize: 13,
                          ),
                          onChanged: controller.setOrderNote,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeConfig.getSurfaceColor(isDarkMode),
                border: Border(
                  top: BorderSide(
                    color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    // Invoice Button
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final invoiceController = Get.put(InvoiceGeneratorController());
                          if (!invoiceController.isStoreInitialized.value) {
                            Get.snackbar(
                              'Error',
                              'Store information not initialized yet. Please wait...',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                            return;
                          }
                          await invoiceController.generateInvoicePdf();
                          Get.toNamed(Routes.INVOICE_PREVIEW);
                        },
                        icon: const Icon(
                          Icons.receipt_long_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Obx(() {
                          return Text(
                            Get.put(InvoiceGeneratorController()).isStoreInitialized.value
                                ? l10n.invoice
                                : l10n.generating,
                            style: SafeGoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeConfig.getAccentColor(isDarkMode),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Confirm Order Button
                    Expanded(
                      flex: 3,
                      child: ElevatedButton.icon(
                        onPressed: () => controller.processSale(),
                        icon: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: Text(
                          l10n.confirmOrder,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, int quantity, String amount,
      AppThemeConfig themeConfig, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$label x $quantity",
            style: SafeGoogleFonts.poppins(
              fontSize: 14,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          amount,
          style: SafeGoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

}


