import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../data/models/product.dart';
import '../controllers/sell_controller.dart';

class CheckoutView extends GetView<SellController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Text(
                'চেকআউট',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
            ],
          ),
        ),
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
                              'অর্ডার সারাংশ',
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
                                'নতুন অর্ডার',
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
                        Obx(() => Column(
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
                                        '৳ ${item.totalPrice.toStringAsFixed(2)}',
                                        themeConfig,
                                        isDarkMode,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  );
                                }).toList(),
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
                                        'মোট',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: themeConfig
                                              .getTextPrimaryColor(isDarkMode),
                                        ),
                                      ),
                                      Text(
                                        '৳ ${controller.total.value.toStringAsFixed(2)}',
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
                              'গ্রাহক তথ্য',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color:
                                    themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            ),
                            Text(
                              ' (অবশ্যই নয়)',
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
                                'অজ্ঞাতপরিচয়',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            ...controller.customers
                                .map((customer) => DropdownMenuItem<String>(
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
                          value: '0', // Default value
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
                                  labelText: 'ডিসকাউন্ক (৳)',
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
                                  labelText: 'বাকি টাকা (৳)',
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
                            labelText: 'অর্ডার নোট (যদি থাকে)',
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
                        'অর্ডার নিশ্চিত করুন',
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

  Widget _buildTextField(String label, IconData icon,
      AppThemeConfig themeConfig, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: themeConfig.getTextSecondaryColor(isDarkMode).withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          prefixIcon: Icon(
            icon,
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
        keyboardType: TextInputType.number,
      ),
    );
  }
}
