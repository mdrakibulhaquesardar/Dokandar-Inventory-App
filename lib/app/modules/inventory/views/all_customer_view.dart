
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../data/models/customer.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/AllCustomerController.dart';

class AllCustomerView extends GetView<AllCustomerController> {
  const AllCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar:customAppBar(
        themeConfig,
        isDarkMode,
        l10n.customerList,
        true,
        false,
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
                      l10n.totalCustomers,
                      controller.customers.length.translateNumberToBengali()
                          .toString(),
                      Icons.people,
                      themeConfig,
                      isDarkMode,
                      context,
                    );
                  }),
                  Obx(() {
                    return _buildStatCard(
                      l10n.newCustomers,
                      controller.customers
                          .where((customer) => customer.totalPurchases == 0)
                          .length
                          .translateNumberToBengali()
                          .toString(),
                      Icons.person_add,
                      themeConfig,
                      isDarkMode,
                      context,
                    );
                  }),
                  Obx(() {
                    return _buildStatCard(
                      l10n.totalDue,
                      controller.customers
                          .where((customer) => customer.hasDue)
                          .fold(0.0, (sum, customer) => sum + customer.totalDue)
                          .translateNumberToBengali().toString(),
                      Icons.money_off,
                      themeConfig,
                      isDarkMode,
                      context,
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
    final l10n = AppLocalizations.of(context)!;
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
                        Expanded(
                          child: Text(
                            customerPhone,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            
                            style: TextStyle(
                          
                              fontSize: 14,
                              color: themeConfig.getTextSecondaryColor(isDarkMode),
                              fontWeight: FontWeight.w500,
                            ),
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
                            '${l10n.totalPurchases}: $totalPurchase৳',
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
                            '${l10n.dueAmount}: $totalDue৳',
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
                    l10n.newCustomers,
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
    final l10n = AppLocalizations.of(context)!;
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
                      l10n.customerInfo,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${l10n.totalPurchases}: ${customer.totalPurchases.toStringAsFixed(
                                  2)}৳',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: themeConfig.getPrimaryColor(isDarkMode),
                              ),
                            ),
                            Text(
                              '  |  ${l10n.dueAmount}: ${customer.totalDue.toStringAsFixed(2)}৳',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: themeConfig.getPrimaryColor(isDarkMode),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          customer.hasDue ? l10n.customerHasDue : l10n.customerNoDue,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: customer.hasDue
                                ? Colors.red
                                : themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                        ),
                        //last purchase date
                        Text(
                          '${l10n.lastPurchase}: ${customer.updatedAt != null ? customer.updatedAt!.toLocal().toString().split(' ')[0] : 'N/A'}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: l10n.name,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: l10n.phoneNumber,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: l10n.address,
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
                          l10n.save,
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
                              title: Text(l10n.deleteCustomer),
                              content: Text(l10n.confirmDeleteCustomer),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(l10n.cancel),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.deleteCustomer(customer.id);
                                    Navigator.pop(context); // Close dialog
                                    Navigator.pop(
                                        context); // Close bottom sheet
                                  },
                                  child: Text(
                                    l10n.delete,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Text(
                      l10n.deleteCustomer,
                      style: const TextStyle(color: Colors.red),
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
    final l10n = AppLocalizations.of(context)!;
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
                    l10n.addCustomer,
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
                        return l10n.nameRequired;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.name,
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
                        return l10n.phoneRequired;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: l10n.phoneNumber,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      labelText: l10n.address,
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
                            l10n.add,
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
    AppThemeConfig themeConfig, bool isDarkMode, BuildContext context) {
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
