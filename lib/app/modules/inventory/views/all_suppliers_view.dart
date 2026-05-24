import 'package:dokandar_app_inventory/app/config/app_config.dart';
import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/supplier_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../widgets/Custom_AppBar.dart';
import '../../../data/models/supplier.dart';

class AllSuppliersView extends GetView<SupplierController> {
  const AllSuppliersView({super.key});

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
        l10n.allSuppliers,
        true,
        false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () {
          controller.clearForm();
          _showSupplierForm(context, themeConfig, isDarkMode, l10n);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          // Stats Header
          _buildStatsHeader(themeConfig, isDarkMode, l10n),
          // Search Bar
          _buildSearchBar(themeConfig, isDarkMode, l10n),
          // Supplier List
          Expanded(
            child: Obx(() {
              if (controller.filteredSuppliers.isEmpty) {
                return _buildEmptyState(themeConfig, isDarkMode, l10n);
              }
              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                itemCount: controller.filteredSuppliers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final supplier = controller.filteredSuppliers[index];
                  return _buildSupplierCard(
                    context, supplier, themeConfig, isDarkMode, l10n,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    final appConfig = Get.find<AppConfig>();
    final currency = appConfig.getCurrencySymbol();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: themeConfig.getPrimaryColor(isDarkMode).withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() => _buildStatItem(
            icon: Icons.people_outline,
            label: l10n.totalSuppliers,
            value: controller.totalSuppliersCount.value.toString(),
            color: themeConfig.getPrimaryColor(isDarkMode),
            themeConfig: themeConfig,
            isDarkMode: isDarkMode,
          )),
          _buildStatDivider(themeConfig, isDarkMode),
          Obx(() => _buildStatItem(
            icon: Icons.shopping_cart_outlined,
            label: l10n.totalPurchase,
            value: '$currency${controller.totalPurchaseAmount.value.toStringAsFixed(0)}',
            color: themeConfig.getInfoColor(isDarkMode),
            themeConfig: themeConfig,
            isDarkMode: isDarkMode,
          )),
          _buildStatDivider(themeConfig, isDarkMode),
          Obx(() => _buildStatItem(
            icon: Icons.money_off_outlined,
            label: l10n.totalDue,
            value: '$currency${controller.totalDueAmount.value.toStringAsFixed(0)}',
            color: controller.totalDueAmount.value > 0
                ? themeConfig.getWarningColor(isDarkMode)
                : themeConfig.getSuccessColor(isDarkMode),
            themeConfig: themeConfig,
            isDarkMode: isDarkMode,
          )),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: SafeGoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        Text(
          label,
          style: SafeGoogleFonts.poppins(
            fontSize: 10,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatDivider(AppThemeConfig themeConfig, bool isDarkMode) {
    return Container(
      height: 40,
      width: 1,
      color: themeConfig.getBorderColor(isDarkMode),
    );
  }

  Widget _buildSearchBar(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: TextField(
        controller: controller.searchController,
        onChanged: controller.onSearchChanged,
        style: SafeGoogleFonts.poppins(
          color: themeConfig.getTextPrimaryColor(isDarkMode),
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: l10n.searchSuppliers,
          hintStyle: SafeGoogleFonts.poppins(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            size: 20,
          ),
          suffixIcon: Obx(() {
            if (controller.searchQuery.value.isNotEmpty) {
              return IconButton(
                icon: Icon(
                  Icons.clear,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                  size: 18,
                ),
                onPressed: controller.clearSearch,
              );
            }
            return const SizedBox.shrink();
          }),
          filled: true,
          fillColor: themeConfig.getSurfaceColor(isDarkMode),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: themeConfig.getBorderColor(isDarkMode),
              width: 0.8,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: themeConfig.getPrimaryColor(isDarkMode),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: themeConfig.getTextSecondaryColor(isDarkMode)
                .withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noSuppliers,
            style: SafeGoogleFonts.poppins(
              color: themeConfig.getTextSecondaryColor(isDarkMode),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first supplier',
            style: SafeGoogleFonts.poppins(
              color: themeConfig.getTextSecondaryColor(isDarkMode),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierCard(
    BuildContext context,
    Supplier supplier,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    final hasDue = supplier.totalDue > 0;
    final avatarColor = themeConfig.getPrimaryColor(isDarkMode);
    final appConfig = Get.find<AppConfig>();
    final currency = appConfig.getCurrencySymbol();

    return InkWell(
      onTap: () =>
          _showSupplierDetails(context, supplier, themeConfig, isDarkMode, l10n),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasDue
                ? themeConfig.getWarningColor(isDarkMode).withValues(alpha: 0.3)
                : themeConfig.getBorderColor(isDarkMode).withValues(alpha: 0.5),
            width: 0.8,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 22,
              backgroundColor: avatarColor.withValues(alpha: 0.12),
              child: Text(
                supplier.name[0].toUpperCase(),
                style: SafeGoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: avatarColor,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          supplier.name,
                          style: SafeGoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Due badge
                      if (hasDue)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: themeConfig
                                .getWarningColor(isDarkMode)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Due',
                            style: SafeGoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: themeConfig.getWarningColor(isDarkMode),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (supplier.company != null &&
                      supplier.company!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      supplier.company!,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 12,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (supplier.phone != null &&
                      supplier.phone!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      supplier.phone!,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 12,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  // Financial row
                  Row(
                    children: [
                      _buildFinancialBadge(
                        '$currency${supplier.totalPurchase.toStringAsFixed(0)}',
                        l10n.totalPurchase,
                        themeConfig.getInfoColor(isDarkMode),
                        themeConfig,
                        isDarkMode,
                      ),
                      const SizedBox(width: 6),
                      _buildFinancialBadge(
                        '$currency${supplier.totalPaid.toStringAsFixed(0)}',
                        l10n.totalPaid,
                        themeConfig.getSuccessColor(isDarkMode),
                        themeConfig,
                        isDarkMode,
                      ),
                      if (hasDue) ...[
                        const SizedBox(width: 6),
                        _buildFinancialBadge(
                          '$currency${supplier.totalDue.toStringAsFixed(0)}',
                          l10n.totalDue,
                          themeConfig.getWarningColor(isDarkMode),
                          themeConfig,
                          isDarkMode,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialBadge(
    String value,
    String label,
    Color color,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: SafeGoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            label,
            style: SafeGoogleFonts.poppins(
              fontSize: 9,
              color: themeConfig.getTextSecondaryColor(isDarkMode),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Supplier Details Bottom Sheet ───────────────────────────────────────

  void _showSupplierDetails(
    BuildContext context,
    Supplier supplier,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    final appConfig = Get.find<AppConfig>();
    final currency = appConfig.getCurrencySymbol();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      l10n.supplierInfo,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _actionIconButton(
                        Icons.edit_outlined,
                        themeConfig.getInfoColor(isDarkMode),
                        () {
                          Navigator.pop(ctx);
                          controller.setFormFromSupplier(supplier);
                          _showSupplierForm(
                            context, themeConfig, isDarkMode, l10n,
                            supplier: supplier,
                          );
                        },
                      ),
                      const SizedBox(width: 4),
                      _actionIconButton(
                        Icons.delete_outline,
                        themeConfig.getErrorColor(isDarkMode),
                        () {
                          Navigator.pop(ctx);
                          _showDeleteConfirmation(
                            context, supplier, themeConfig, isDarkMode, l10n,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Name & company
              _detailRow(Icons.person_outline, supplier.name,
                  themeConfig, isDarkMode, bold: true),
              if (supplier.company != null && supplier.company!.isNotEmpty)
                _detailRow(Icons.business_outlined, supplier.company!,
                    themeConfig, isDarkMode),
              if (supplier.phone != null && supplier.phone!.isNotEmpty)
                _detailRow(Icons.phone_outlined, supplier.phone!,
                    themeConfig, isDarkMode),
              if (supplier.email != null && supplier.email!.isNotEmpty)
                _detailRow(Icons.email_outlined, supplier.email!,
                    themeConfig, isDarkMode),
              if (supplier.address != null && supplier.address!.isNotEmpty)
                _detailRow(Icons.location_on_outlined, supplier.address!,
                    themeConfig, isDarkMode),
              const SizedBox(height: 12),
              // Financial Summary
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeConfig.getBackgroundColor(isDarkMode),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: themeConfig.getBorderColor(isDarkMode),
                    width: 0.8,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Financial Summary',
                      style: SafeGoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _financialRow(
                          l10n.totalPurchase,
                          '$currency${supplier.totalPurchase.toStringAsFixed(2)}',
                          themeConfig.getInfoColor(isDarkMode),
                          themeConfig,
                          isDarkMode,
                        ),
                        _financialRow(
                          l10n.totalPaid,
                          '$currency${supplier.totalPaid.toStringAsFixed(2)}',
                          themeConfig.getSuccessColor(isDarkMode),
                          themeConfig,
                          isDarkMode,
                        ),
                        _financialRow(
                          l10n.totalDue,
                          '$currency${supplier.totalDue.toStringAsFixed(2)}',
                          supplier.totalDue > 0
                              ? themeConfig.getWarningColor(isDarkMode)
                              : themeConfig.getSuccessColor(isDarkMode),
                          themeConfig,
                          isDarkMode,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Record Payment (only if there's a due)
              if (supplier.totalDue > 0) ...[
                const SizedBox(height: 16),
                Text(
                  l10n.recordPayment,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.paymentController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        style: SafeGoogleFonts.poppins(
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.paymentAmount,
                          hintStyle: SafeGoogleFonts.poppins(
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 13,
                          ),
                          prefixText: currency,
                          prefixStyle: SafeGoogleFonts.poppins(
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.recordPayment(supplier);
                        if (ctx.mounted) Navigator.pop(ctx);
                        Get.snackbar(
                          'Success',
                          l10n.paymentRecorded,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor:
                              themeConfig.getSuccessColor(isDarkMode),
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeConfig.getSuccessColor(isDarkMode),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        l10n.pay,
                        style: SafeGoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              // Created date
              if (supplier.createdAt != null) ...[
                const SizedBox(height: 12),
                Text(
                  '${l10n.createdAt}: ${supplier.createdAt!.toLocal().toString().split(' ')[0]}',
                  style: SafeGoogleFonts.poppins(
                    fontSize: 11,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionIconButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String text,
    AppThemeConfig themeConfig,
    bool isDarkMode, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: SafeGoogleFonts.poppins(
                fontSize: bold ? 15 : 13,
                fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _financialRow(
    String label,
    String value,
    Color color,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: SafeGoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: SafeGoogleFonts.poppins(
            fontSize: 10,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
      ],
    );
  }

  // ─── Delete Confirmation ───────────────────────────────────────────────────

  void _showDeleteConfirmation(
    BuildContext context,
    Supplier supplier,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.deleteSupplier,
          style: SafeGoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        content: Text(
          l10n.confirmDeleteSupplier,
          style: SafeGoogleFonts.poppins(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            fontSize: 13,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n.cancel,
              style: SafeGoogleFonts.poppins(
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteSupplier(supplier.id);
              Navigator.pop(ctx);
              Get.snackbar(
                'Success',
                l10n.supplierDeleted,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: themeConfig.getSuccessColor(isDarkMode),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: themeConfig.getErrorColor(isDarkMode),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              l10n.delete,
              style: SafeGoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Add / Edit Supplier Form ─────────────────────────────────────────────

  void _showSupplierForm(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    AppLocalizations l10n, {
    Supplier? supplier,
  }) {
    final isEditing = supplier != null;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? l10n.editSupplier : l10n.addSupplier,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Name
                _buildFormField(
                  label: l10n.name,
                  controller: controller.nameController,
                  icon: Icons.person_outline,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  isRequired: true,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l10n.supplierNameRequired
                      : null,
                ),
                _buildFormField(
                  label: l10n.company,
                  controller: controller.companyController,
                  icon: Icons.business_outlined,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildFormField(
                  label: l10n.phone,
                  controller: controller.phoneController,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildFormField(
                  label: l10n.email,
                  controller: controller.emailController,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildFormField(
                  label: l10n.address,
                  controller: controller.addressController,
                  icon: Icons.location_on_outlined,
                  maxLines: 2,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 8),
                // Save / Update button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        if (isEditing) {
                          final updated = controller.buildSupplierFromForm(
                            existingCode: supplier.supplierCode ?? '',
                          );
                          await controller.updateSupplier(supplier, updated);
                          if (ctx.mounted) Navigator.pop(ctx);
                          Get.snackbar(
                            'Success',
                            l10n.supplierUpdated,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                themeConfig.getSuccessColor(isDarkMode),
                            colorText: Colors.white,
                          );
                        } else {
                          await controller.addSupplier();
                          if (ctx.mounted) Navigator.pop(ctx);
                          Get.snackbar(
                            'Success',
                            l10n.supplierAdded,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor:
                                themeConfig.getSuccessColor(isDarkMode),
                            colorText: Colors.white,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEditing ? l10n.update : l10n.save,
                      style: SafeGoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isRequired = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: SafeGoogleFonts.poppins(
          color: themeConfig.getTextPrimaryColor(isDarkMode),
          fontSize: 14,
        ),
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          labelStyle: SafeGoogleFonts.poppins(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            icon,
            size: 18,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeConfig.getPrimaryColor(isDarkMode),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeConfig.getBorderColor(isDarkMode),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeConfig.getErrorColor(isDarkMode),
            ),
          ),
        ),
      ),
    );
  }
}
