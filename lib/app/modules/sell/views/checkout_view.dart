import 'package:dokandar_app_inventory/app/widgets/Custom_AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
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
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeConfig.getBackgroundColor(isDarkMode),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: themeConfig
                                    .getPrimaryColor(isDarkMode)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.receipt_outlined,
                                color: themeConfig.getPrimaryColor(isDarkMode),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.orderSummary,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                l10n.newOrder,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                                      _buildCostRow(
                                        item.productName,
                                        item.quantity.toInt(),
                                        '৳ ${item.totalPrice.toStringAsFixed(
                                            2)}',
                                        themeConfig,
                                        isDarkMode,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  );
                                }),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: themeConfig
                                        .getPrimaryColor(isDarkMode)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.total,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: themeConfig
                                              .getTextPrimaryColor(isDarkMode),
                                        ),
                                      ),
                                      Text(
                                        '৳ ${controller.total.value
                                            .toStringAsFixed(2)}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: themeConfig
                                              .getPrimaryColor(isDarkMode),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Customer and Payment Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeConfig.getBackgroundColor(isDarkMode),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: themeConfig
                                    .getAccentColor(isDarkMode)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: themeConfig.getAccentColor(isDarkMode),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.customerInfo,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color:
                                themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            ),
                            Text(
                              ' ${l10n.optional}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: themeConfig
                                    .getTextSecondaryColor(isDarkMode),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                          ),
                          items: [
                            DropdownMenuItem<String>(
                              value: '0',
                              child: Text(
                                l10n.unknown,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            ...controller.customers
                                .map((customer) =>
                                DropdownMenuItem<String>(
                                  value: customer.id.toString(),
                                  child: Text(
                                    customer.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                    ),
                                  ),
                                )),
                          ],
                          onChanged: (value) =>
                              controller.setSelectedCustomer(value ?? '0'),
                          value: '0',
                          // Default value
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: l10n.discount,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.discount_outlined,
                                    color:
                                    themeConfig.getAccentColor(isDarkMode),
                                    size: 18,
                                  ),
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
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
                                  ),
                                  prefixIcon: Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color:
                                    themeConfig.getAccentColor(isDarkMode),
                                    size: 18,
                                  ),
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
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
                            ),
                            prefixIcon: Icon(
                              Icons.note_outlined,
                              color: themeConfig.getAccentColor(isDarkMode),
                              size: 18,
                            ),
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 14,
                            ),
                          ),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
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
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                // Invoice Button
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () =>
                        Get.put(InvoiceGeneratorController()).generateInvoice(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: themeConfig.getAccentColor(isDarkMode),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: themeConfig
                                .getAccentColor(isDarkMode)
                                .withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.receipt_long_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Obx(() {
                              return Text(
                                Get.put(InvoiceGeneratorController()).isStoreInitialized.value
                                    ? l10n.invoice
                                    : l10n.generating,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Confirm Order Button
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () => controller.processSale(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: themeConfig.getPrimaryColor(isDarkMode),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: themeConfig
                                .getPrimaryColor(isDarkMode)
                                .withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              l10n.confirmOrder,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildCostRow(String label, int quantity, String amount,
      AppThemeConfig themeConfig, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$label x $quantity",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

}
