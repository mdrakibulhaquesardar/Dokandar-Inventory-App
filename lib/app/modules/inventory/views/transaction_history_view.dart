import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/config/app_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/transaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../widgets/Custom_AppBar.dart';

class TransactionHistoryView extends GetView<TransactionController> {
  const TransactionHistoryView({super.key});

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
        l10n.transactionHistory,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFilters(context, themeConfig, isDarkMode, l10n),
            const SizedBox(height: 12),
            Expanded(
              child: GetBuilder<TransactionController>(
                builder: (_) {
                  final items = controller.filteredTransactions;
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        l10n.dataNotFound,
                        style: SafeGoogleFonts.poppins(
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final tx = items[index];
                      final isSale = tx.type == 'sale';
                      return Card(
                        elevation: 0,
                        color: themeConfig.getSurfaceColor(isDarkMode),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: (isSale
                                    ? themeConfig.getSuccessColor(isDarkMode)
                                    : themeConfig.getErrorColor(isDarkMode))
                                .withOpacity(0.1),
                            child: Icon(
                              isSale ? Icons.arrow_upward : Icons.arrow_downward,
                              color: isSale
                                  ? themeConfig.getSuccessColor(isDarkMode)
                                  : themeConfig.getErrorColor(isDarkMode),
                            ),
                          ),
                          title: Text(
                            tx.title,
                            style: SafeGoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: themeConfig.getTextPrimaryColor(isDarkMode),
                            ),
                          ),
                          subtitle: Obx(() {
                            final appConfig = Get.find<AppConfig>();
                            return Text(
                              appConfig.getFormattedDate(tx.date),
                              style: SafeGoogleFonts.poppins(
                                color:
                                    themeConfig.getTextSecondaryColor(isDarkMode),
                                fontSize: 12,
                              ),
                            );
                          }),
                          trailing: Obx(() {
                            final appConfig = Get.find<AppConfig>();
                            return Text(
                              '${appConfig.getCurrencySymbol()}${tx.amount.toStringAsFixed(2)}',
                              style: SafeGoogleFonts.poppins(
                                color: isSale
                                    ? themeConfig.getSuccessColor(isDarkMode)
                                    : themeConfig.getErrorColor(isDarkMode),
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context, AppThemeConfig themeConfig,
      bool isDarkMode, AppLocalizations l10n) {
    return Row(
      children: [
        ChoiceChip(
          label: Text('All'),
          selected: controller.filterType.value == 'all',
          onSelected: (_) => controller.setType('all'),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: Text(l10n.sales),
          selected: controller.filterType.value == 'sale',
          onSelected: (_) => controller.setType('sale'),
        ),
        const SizedBox(width: 8),
        ChoiceChip(
          label: Text('Expense'),
          selected: controller.filterType.value == 'expense',
          onSelected: (_) => controller.setType('expense'),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: () async {
            final now = DateTime.now();
            final picked = await showDateRangePicker(
              context: context,
              firstDate: DateTime(now.year - 2),
              lastDate: DateTime(now.year + 2),
              initialDateRange: controller.filterRange ??
                  DateTimeRange(
                    start: now.subtract(const Duration(days: 7)),
                    end: now,
                  ),
            );
            controller.setRange(picked);
          },
          icon: const Icon(Icons.filter_alt),
          label: Text('Filter'),
        ),
      ],
    );
  }
}

