import 'dart:developer';

import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../data/models/customer.dart';
import '../controllers/AllCustomerController.dart';

class AllCustomerView extends GetView<AllCustomerController> {
  const AllCustomerView({super.key});

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
                'আপনার গ্রাহকগণ',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
                onPressed: () =>
                    _showCustomerDetails(
                        context, controller.customers[0], themeConfig,
                        isDarkMode),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: themeConfig.getSurfaceColor(isDarkMode),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    return _buildStatCard(
                      'মোট গ্রাহক',
                      controller.customers.length.translateNumberToBengali()
                          .toString(),
                      Icons.people,
                      themeConfig,
                      isDarkMode,
                    );
                  }),
                  Obx(() {
                    return _buildStatCard(
                      'নতুন গ্রাহক',
                      controller.customers
                          .where((customer) => customer.totalPurchases == 0)
                          .length
                          .translateNumberToBengali()
                          .toString(),
                      Icons.person_add,
                      themeConfig,
                      isDarkMode,
                    );
                  }),
                  Obx(() {
                    return _buildStatCard(
                      'মোট বাকি টাকা',
                      controller.customers
                          .where((customer) => customer.hasDue)
                          .fold(0.0, (sum, customer) => sum + customer.totalDue)
                          .translateNumberToBengali().toString(),
                      Icons.money_off,
                      themeConfig,
                      isDarkMode,
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.customers.length,
                  itemBuilder: (context, index) {
                    return _buildCustomerList(
                      index,
                      controller.customers[index].name,
                      controller.customers[index].phone,
                      controller.customers[index].totalPurchases.toInt(),
                      controller.customers[index].totalDue.toInt(),
                      controller.customers[index].hasDue,
                      themeConfig,
                      isDarkMode,
                      context,
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () => _showAddCustomerForm(context, themeConfig, isDarkMode),
        child: const Icon(Icons.person_add),
      ),
    );
  }

  InkWell _buildCustomerList(int index,
      String customerName,
      String customerPhone,
      int totalPurchase,
      int totalDue,
      bool hasDue,
      AppThemeConfig themeConfig,
      bool isDarkMode,
      BuildContext context) {
    return InkWell(
      onTap: () =>
          _showCustomerDetails(
              context, controller.customers[index], themeConfig, isDarkMode),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                child: Text(
                  customerName[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: themeConfig.getPrimaryColor(isDarkMode),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          customerName,
                          style: TextStyle(
                            fontSize: 18,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          customerPhone,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                            themeConfig.getTextSecondaryColor(isDarkMode),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: themeConfig
                                .getPrimaryColor(isDarkMode)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'মোট ক্রয়: $totalPurchase৳',
                            style: TextStyle(
                              fontSize: 12,
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        hasDue
                            ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'বাকি: $totalDue৳',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
              // new user tag
              if (totalPurchase.toInt() == 0)
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: themeConfig
                        .getPrimaryColor(isDarkMode)
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'নতুন গ্রাহক',
                    style: TextStyle(
                      fontSize: 12,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomerDetails(BuildContext context, Customer customer,
      AppThemeConfig themeConfig, bool isDarkMode) {
    final nameController = TextEditingController(text: customer.name);
    final phoneController = TextEditingController(text: customer.phone);
    final addressController =
    TextEditingController(text: customer.address ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Container(
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'গ্রাহকের তথ্য',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    Text(
                      'মোট ক্রয়: ${customer.totalPurchases.toStringAsFixed(
                          2)}৳',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'নাম',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'ফোন নম্বর',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'ঠিকানা',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: themeConfig.getPrimaryColor(
                              isDarkMode),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          controller.updateCustomer(
                            customer.copyWith(
                              name: nameController.text,
                              phone: phoneController.text,
                              address: addressController.text,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text(
                          'সংরক্ষণ করুন',
                          style: TextStyle(
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Show delete confirmation dialog
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: const Text('গ্রাহক মুছে ফেলুন'),
                              content: const Text(
                                  'আপনি কি নিশ্চিত যে আপনি এই গ্রাহককে মুছে ফেলতে চান?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('বাতিল'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.deleteCustomer(customer.id);
                                    Navigator.pop(context); // Close dialog
                                    Navigator.pop(
                                        context); // Close bottom sheet
                                  },
                                  child: const Text(
                                    'মুছে ফেলুন',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    child: const Text(
                      'গ্রাহক মুছে ফেলুন',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
    );
  }

  void _showAddCustomerForm(BuildContext context, AppThemeConfig themeConfig,
      bool isDarkMode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Form(
            key: controller.formKey,
            child: Container(
              decoration: BoxDecoration(
                color: themeConfig.getSurfaceColor(isDarkMode),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'নতুন গ্রাহক যোগ করুন',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'নাম অবশ্যই পূরণ করতে হবে';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'নাম',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: controller.phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ফোন নম্বর অবশ্যই পূরণ করতে হবে';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'ফোন নম্বর',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: 'ঠিকানা',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            themeConfig.getPrimaryColor(isDarkMode),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            // Add new customer
                            if (controller.formKey.currentState!.validate()) {
                              // Add new customer
                              controller.addCustomer(
                                controller.nameController.text,
                                controller.phoneController.text,
                                controller.addressController.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'যোগ করুন',
                            style: TextStyle(
                              color: themeConfig.getTextPrimaryColor(
                                  isDarkMode),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
    );
  }
}

Widget _buildStatCard(String title, String value, IconData icon,
    AppThemeConfig themeConfig, bool isDarkMode) {
  return Column(
    children: [
      Icon(
        icon,
        color: themeConfig.getPrimaryColor(isDarkMode),
        size: 18,
      ),
      const SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: themeConfig.getTextPrimaryColor(isDarkMode),
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
      ),
    ],
  );
}
