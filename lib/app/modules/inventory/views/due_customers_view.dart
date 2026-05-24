import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../controllers/due_customers_controller.dart';

class DueCustomersView extends GetView<DueCustomersController> {
  const DueCustomersView({super.key});

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
        l10n.dueCustomersList,
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
                  Obx(() => _buildStatCard(
                        l10n.totalDueCustomers,
                        '${controller.dueCustomers.length} ${l10n.people}',
                        Icons.people,
                        themeConfig,
                        isDarkMode,
                      )),
                  Obx(() => _buildStatCard(
                        l10n.totalDue,
                        '${controller.dueCustomers.fold(0.0, (sum, customer) => sum + customer.totalDue)}৳',
                        Icons.account_balance_wallet,
                        themeConfig,
                        isDarkMode,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.dueCustomers.isEmpty
                        ? Center(
                            child: Text(
                              l10n.noDueCustomers,
                              style: TextStyle(
                                color: themeConfig.getTextPrimaryColor(isDarkMode),
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.dueCustomers.length,
                            itemBuilder: (context, index) {
                      final customer = controller.dueCustomers[index];
                      return GestureDetector(
                        onTap: () => _showPaymentDialog(
                          context,
                          customer,
                          themeConfig,
                          isDarkMode,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: themeConfig.getSurfaceColor(isDarkMode),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 5,
                              bottom: 5,
                            ),
                            title: Text(
                              customer.name,
                              style: TextStyle(
                                color: themeConfig.getTextPrimaryColor(isDarkMode),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${l10n.phone}: ${customer.phone}',
                                  style: TextStyle(
                                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                                  ),
                                ),

                              ],
                            ),
                            trailing: Text(
                              '${customer.totalDue}৳',
                              style: TextStyle(
                                color: themeConfig.getTextPrimaryColor(isDarkMode),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ),
                        ),
                      );
                    },
                  ),
      ),
    ),

          ],
        ),
      ),
    );
  }

  void _showPaymentDialog(
    BuildContext context,
    dynamic customer,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    final TextEditingController amountController = TextEditingController();
    final l10n = AppLocalizations.of(context)!;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.payDue,
                  style: TextStyle(
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeConfig.getBackgroundColor(isDarkMode),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${l10n.customerName}: ${customer.name}',
                    style: TextStyle(
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${l10n.totalDue}: ${customer.totalDue}৳',
                    style: TextStyle(
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: l10n.enterAmount,
                filled: true,
                fillColor: themeConfig.getBackgroundColor(isDarkMode),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: themeConfig.getPrimaryColor(isDarkMode),
                  ),
                ),
                suffixText: '৳',
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final amount = double.tryParse(amountController.text) ?? 0;
                      controller.updateDuePayment(customer, amount);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.pay,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: themeConfig.getPrimaryColor(isDarkMode),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: themeConfig.getTextPrimaryColor(isDarkMode),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}


