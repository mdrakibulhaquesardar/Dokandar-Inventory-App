import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import '../../../utils/safe_google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Obx(() {
                      final storeName =
                          controller.store.value?.name ?? l10n.dataNotFound;
                      final firstLetter = storeName.isNotEmpty
                          ? storeName[0].toUpperCase()
                          : '?';
                      return CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            themeConfig.getPrimaryColor(isDarkMode),
                        child: Text(
                          firstLetter,
                          style: SafeGoogleFonts.notoSansBengali(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              controller.store.value?.name ?? l10n.dataNotFound,
                              style: SafeGoogleFonts.notoSansBengali(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    themeConfig.getTextPrimaryColor(isDarkMode),
                              ),
                            );
                          }),
                          Obx(() {
                            return Text(
                              controller.store.value?.businessType ??
                                  l10n.dataNotFound,
                              style: SafeGoogleFonts.notoSansBengali(
                                fontSize: 11,
                                color: themeConfig
                                    .getTextSecondaryColor(isDarkMode),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: themeConfig
                            .getPrimaryColor(isDarkMode)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.refresh, size: 14),
                        onPressed: () {
                          controller.refresh();
                        },
                        color: themeConfig.getPrimaryColor(isDarkMode),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.SEARCH);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: themeConfig.getBackgroundColor(isDarkMode),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 18,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            l10n.searchProducts,
                            style: SafeGoogleFonts.notoSansBengali(
                              fontSize: 13,
                              color:
                                  themeConfig.getTextSecondaryColor(isDarkMode),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Access Section
              Text(
                l10n.quickAccess,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.quickAccessDescription,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                decoration: BoxDecoration(
                  color: themeConfig.getSurfaceColor(isDarkMode),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickActionItem(
                      context,
                      icon: Icons.point_of_sale_outlined,
                      label: l10n.sellCounter,
                      color: Colors.green,
                      route: Routes.SELL,
                      themeConfig: themeConfig,
                      isDarkMode: isDarkMode,
                    ),
                    _buildQuickActionItem(
                      context,
                      icon: Icons.inventory_2_outlined,
                      label: l10n.addProduct,
                      color: Colors.blue,
                      route: Routes.ALL_PRODUCTS,
                      themeConfig: themeConfig,
                      isDarkMode: isDarkMode,
                    ),
                    _buildQuickActionItem(
                      context,
                      icon: Icons.receipt_long_outlined,
                      label: l10n.storeExpenses,
                      color: Colors.redAccent,
                      route: Routes.STORE_EXPENSES,
                      themeConfig: themeConfig,
                      isDarkMode: isDarkMode,
                    ),
                    _buildQuickActionItem(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      label: l10n.payDue,
                      color: Colors.amber[700]!,
                      route: Routes.PAY_DUE,
                      themeConfig: themeConfig,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Financial Summary Section Header
              Text(
                l10n.localeName == 'bn' ? 'আর্থিক বিবরণী' : 'Financial Summary',
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.localeName == 'bn' 
                    ? 'দোকানের মোট পাওনা, দেনা ও খরচের হিসাব' 
                    : 'Overview of receivables, payables & expenses',
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 12),

              // Financial Summary Card
              _buildFinancialSummaryCard(context, themeConfig, isDarkMode, l10n),
              const SizedBox(height: 20),

              // Summary Cards Grid
              Text(
                l10n.summaryInfo,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.summaryInfoDescription,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.6,
                children: [
                  Obx(() {
                    return _SummaryCard(
                      title: l10n.totalProducts,
                      value: controller.totalProducts.value.toString(),
                      icon: Icons.inventory_2_outlined,
                      color: Colors.blue,
                      subtitle: l10n.totalProducts,
                      context: context,
                    );
                  }),
                  Obx(() {
                    return _SummaryCard(
                      title: l10n.totalSales,
                      value: '৳${controller.totalSales.value.toString()}',
                      icon: Icons.shopping_cart_outlined,
                      color: Colors.green,
                      subtitle: l10n.totalSales,
                      context: context,
                    );
                  }),
                  Obx(() {
                    return _SummaryCard(
                      title: l10n.categories,
                      value: controller.totalCategories.value.toString(),
                      icon: Icons.category_outlined,
                      color: Colors.orange,
                      subtitle: l10n.categories,
                      context: context,
                    );
                  }),
                  Obx(() {
                    return _SummaryCard(
                      title: l10n.customers,
                      value: controller.totalCustomers.value.toString(),
                      icon: Icons.people_outline,
                      color: Colors.purple,
                      subtitle: l10n.customers,
                      context: context,
                    );
                  }),
                  Obx(() {
                    return _SummaryCard(
                      title: l10n.todaysOrders,
                      value: controller.recentSale.length.toString(),
                      icon: Icons.shopping_bag_outlined,
                      color: Colors.teal,
                      subtitle: l10n.newOrder,
                      context: context,
                    );
                  }),
                  Obx(() {
                    return _SummaryCard(
                      title: l10n.totalProfit,
                      value: controller.totalRevenue.value.toString(),
                      icon: Icons.trending_up,
                      color: Colors.indigo,
                      subtitle: l10n.totalProfit,
                      context: context,
                    );
                  }),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                l10n.localeName == 'bn' ? 'সাম্প্রতিক লেনদেন' : 'Recent Transactions',
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.localeName == 'bn'
                    ? 'বিক্রয় এবং ব্যয়ের একীভূত সাম্প্রতিক বিবরণী'
                    : 'Unified recent stream of sales and expenses',
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 10),
              const _RecentTransactionsList(),

              const SizedBox(height: 20),

              controller.allLowStokeProduct.isEmpty
                  ? const SizedBox()
                  : Text(
                      l10n.stockAlert,
                      style: SafeGoogleFonts.notoSansBengali(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
              controller.allLowStokeProduct.isEmpty
                  ? const SizedBox()
                  : Text(
                      l10n.stockAlertDescription,
                      style: SafeGoogleFonts.notoSansBengali(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),

              const SizedBox(height: 2),
              const SizedBox(height: 2),
              controller.allLowStokeProduct.isEmpty
                  ? SizedBox()
                  : _LowStockProductsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required String route,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: SafeGoogleFonts.notoSansBengali(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummaryCard(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return Row(
      children: [
        // Customer Due (Receivable)
        Expanded(
          child: Obx(() {
            final amount = controller.totalCustomerDue.value;
            final formattedAmount = l10n.localeName == 'bn'
                ? amount.toInt().translateNumberToBengali()
                : amount.toStringAsFixed(0);
            return _buildFinancialItem(
              context,
              title: l10n.localeName == 'bn' ? 'পাওনা (গ্রাহক)' : 'Receivables',
              amount: '৳$formattedAmount',
              icon: Icons.arrow_downward_rounded,
              color: themeConfig.getSuccessColor(isDarkMode),
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              onTap: () => Get.toNamed(Routes.PAY_DUE),
            );
          }),
        ),
        const SizedBox(width: 6),
        // Supplier Due (Payable)
        Expanded(
          child: Obx(() {
            final amount = controller.totalSupplierDue.value;
            final formattedAmount = l10n.localeName == 'bn'
                ? amount.toInt().translateNumberToBengali()
                : amount.toStringAsFixed(0);
            return _buildFinancialItem(
              context,
              title: l10n.localeName == 'bn' ? 'দেনা (সাপ্লায়ার)' : 'Payables',
              amount: '৳$formattedAmount',
              icon: Icons.arrow_upward_rounded,
              color: themeConfig.getWarningColor(isDarkMode),
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              onTap: () => Get.toNamed(Routes.ALL_SUPPLIERS),
            );
          }),
        ),
        const SizedBox(width: 6),
        // Total Expenses
        Expanded(
          child: Obx(() {
            final amount = controller.totalExpenses.value;
            final formattedAmount = l10n.localeName == 'bn'
                ? amount.toInt().translateNumberToBengali()
                : amount.toStringAsFixed(0);
            return _buildFinancialItem(
              context,
              title: l10n.localeName == 'bn' ? 'মোট খরচ' : 'Expenses',
              amount: '৳$formattedAmount',
              icon: Icons.money_off_rounded,
              color: themeConfig.getErrorColor(isDarkMode),
              themeConfig: themeConfig,
              isDarkMode: isDarkMode,
              onTap: () => Get.toNamed(Routes.STORE_EXPENSES),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFinancialItem(
    BuildContext context, {
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: SafeGoogleFonts.notoSansBengali(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                amount,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final BuildContext context;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.subtitle,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Text(
                value,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              Text(
                subtitle,
                style: SafeGoogleFonts.notoSansBengali(
                  fontSize: 11,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentTransactionsList extends GetView<HomeController> {
  const _RecentTransactionsList();

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;
    final localeCode = l10n.localeName;

    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        if (controller.transactionsStream.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history_toggle_off_outlined,
                    size: 40,
                    color: themeConfig.getTextSecondaryColor(isDarkMode).withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localeCode == 'bn' ? 'কোনো সাম্প্রতিক লেনদেন নেই' : 'No recent transactions',
                    style: SafeGoogleFonts.notoSansBengali(
                      fontSize: 14,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.transactionsStream.length,
          itemBuilder: (context, index) {
            final tx = controller.transactionsStream[index];
            final txColor = tx.isIncome 
                ? themeConfig.getSuccessColor(isDarkMode) 
                : themeConfig.getErrorColor(isDarkMode);
            
            final formattedAmount = localeCode == 'bn'
                ? tx.amount.toInt().translateNumberToBengali()
                : tx.amount.toStringAsFixed(0);

            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: index == controller.transactionsStream.length - 1
                      ? BorderSide.none
                      : BorderSide(
                          color: themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.1),
                          width: 0.5,
                        ),
                ),
              ),
              child: ListTile(
                dense: true,
                visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: txColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    tx.icon,
                    size: 16,
                    color: txColor,
                  ),
                ),
                title: Text(
                  tx.title,
                  style: SafeGoogleFonts.notoSansBengali(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: txColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tx.isIncome 
                              ? (localeCode == 'bn' ? 'বিক্রয়' : 'Sale')
                              : (localeCode == 'bn' ? 'খরচ' : 'Expense'),
                          style: SafeGoogleFonts.notoSansBengali(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: txColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 11,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          tx.subtitle,
                          style: SafeGoogleFonts.notoSansBengali(
                            fontSize: 11,
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 11,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatTxDate(tx.date, localeCode),
                        style: SafeGoogleFonts.notoSansBengali(
                          fontSize: 11,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                trailing: Text(
                  '${tx.isIncome ? '+' : '-'} ৳$formattedAmount',
                  style: SafeGoogleFonts.notoSansBengali(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: txColor,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  String _translateStringToBengaliDigits(String input) {
    const Map<String, String> numberMap = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };
    return input.split('').map((char) => numberMap[char] ?? char).join();
  }

  String _formatTxDate(DateTime date, String localeCode) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final txDate = DateTime(date.year, date.month, date.day);

    final timeStr = DateFormat('hh:mm a').format(date);
    final formattedTime = localeCode == 'bn' ? _translateStringToBengaliDigits(timeStr) : timeStr;

    if (txDate == today) {
      return localeCode == 'bn' ? 'আজ, $formattedTime' : 'Today, $formattedTime';
    } else if (txDate == yesterday) {
      return localeCode == 'bn' ? 'গতকাল, $formattedTime' : 'Yesterday, $formattedTime';
    } else {
      final dateStr = DateFormat('dd MMM yyyy').format(date);
      final formattedDate = localeCode == 'bn' ? _translateStringToBengaliDigits(dateStr) : dateStr;
      return '$formattedDate, $formattedTime';
    }
  }
}

class _LowStockProductsList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.allLowStokeProduct.length,
          itemBuilder: (context, index) {
            return Obx(() {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeConfig
                          .getBorderColor(isDarkMode)
                          .withValues(alpha: 0.1),
                      width: 0.5,
                    ),
                  ),
                ),
                child: ListTile(
                  dense: true,
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -3),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  leading: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: themeConfig
                          .getWarningColor(isDarkMode)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.warning_amber_outlined,
                      size: 16,
                      color: themeConfig.getWarningColor(isDarkMode),
                    ),
                  ),
                  title: Text(
                    controller.allLowStokeProduct[index].name,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Text(
                    l10n.stockInPieces(controller
                        .allLowStokeProduct[index].stockQuantity
                        .toInt()
                        .translateNumberToBengali()),
                    style: SafeGoogleFonts.poppins(
                      fontSize: 12,
                      color: themeConfig.getWarningColor(isDarkMode),
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.ALL_PRODUCTS);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      l10n.addToStock,
                      style: SafeGoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        );
      }),
    );
  }
}


