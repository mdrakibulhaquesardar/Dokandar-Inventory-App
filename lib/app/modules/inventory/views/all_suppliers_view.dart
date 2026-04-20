import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/supplier_controller.dart';
import 'package:flutter/material.dart';
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
        onPressed: () => _showSupplierForm(context, themeConfig, isDarkMode),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.suppliers.isEmpty) {
            return Center(
              child: Text(
                l10n.dataNotFound,
                style: SafeGoogleFonts.poppins(
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                  fontSize: 16,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: controller.suppliers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final supplier = controller.suppliers[index];
              return Card(
                elevation: 0,
                color: themeConfig.getSurfaceColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    supplier.name,
                    style: SafeGoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (supplier.company != null && supplier.company!.isNotEmpty)
                        Text(
                          supplier.company!,
                          style: SafeGoogleFonts.poppins(
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 12,
                          ),
                        ),
                      if (supplier.phone != null && supplier.phone!.isNotEmpty)
                        Text(
                          supplier.phone!,
                          style: SafeGoogleFonts.poppins(
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 12,
                          ),
                        ),
                      Text(
                        '${l10n.totalDue}: ${supplier.totalDue.toStringAsFixed(2)}',
                        style: SafeGoogleFonts.poppins(
                          color: themeConfig.getWarningColor(isDarkMode),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        controller.setFormFromSupplier(supplier);
                        _showSupplierForm(
                          context,
                          themeConfig,
                          isDarkMode,
                          supplier: supplier,
                        );
                      } else if (value == 'delete') {
                        controller.deleteSupplier(supplier.id);
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(l10n.edit),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(l10n.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void _showSupplierForm(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode, {
    Supplier? supplier,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = supplier != null;
    final supplierToEdit = supplier; // Store non-null reference for editing
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEditing ? l10n.edit : l10n.add,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 12),
                _buildTextField(l10n.name, controller.nameController),
                _buildTextField(l10n.phone, controller.phoneController,
                    keyboardType: TextInputType.phone),
                _buildTextField(l10n.email, controller.emailController,
                    keyboardType: TextInputType.emailAddress),
                _buildTextField('Company', controller.companyController),
                _buildTextField(l10n.address, controller.addressController,
                    maxLines: 2),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isEditing && supplierToEdit != null) {
                        final updated = controller.buildSupplierFromForm(
                            existingCode: supplierToEdit.supplierCode ?? '');
                        await controller.updateSupplier(supplierToEdit, updated);
                      } else {
                        await controller.addSupplier();
                      }
                      if (bottomSheetContext.mounted) Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                    child: Text(
                      isEditing ? l10n.update : l10n.save,
                      style: SafeGoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(bottomSheetContext).viewInsets.bottom > 0 ? 16 : 0),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

