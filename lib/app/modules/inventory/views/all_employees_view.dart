import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../data/models/employee.dart';
import '../../../widgets/Custom_AppBar.dart';

class AllEmployeesView extends GetView<EmployeeController> {
  const AllEmployeesView({super.key});

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
        l10n.allEmployees,
        true,
        false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () => _showEmployeeForm(context, themeConfig, isDarkMode),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.employees.isEmpty) {
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
            itemCount: controller.employees.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final employee = controller.employees[index];
              return Card(
                elevation: 0,
                color: themeConfig.getSurfaceColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    employee.name,
                    style: SafeGoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (employee.role != null && employee.role!.isNotEmpty)
                        Text(
                          employee.role!,
                          style: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 12,
                          ),
                        ),
                      if (employee.phone != null && employee.phone!.isNotEmpty)
                        Text(
                          employee.phone!,
                          style: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 12,
                          ),
                        ),
                      Text(
                        'Salary: ${employee.salary.toStringAsFixed(2)}',
                        style: SafeGoogleFonts.poppins(
                          color: themeConfig.getSuccessColor(isDarkMode),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        controller.setFormFromEmployee(employee);
                        _showEmployeeForm(context, themeConfig, isDarkMode,
                            employee: employee);
                      } else if (value == 'delete') {
                        controller.deleteEmployee(employee.id);
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

  void _showEmployeeForm(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode, {
    Employee? employee,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = employee != null;
    final employeeToEdit = employee; // Store for editing
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
                _buildTextField('Role', controller.roleController),
                _buildTextField(l10n.phone, controller.phoneController,
                    keyboardType: TextInputType.phone),
                _buildTextField(l10n.email, controller.emailController,
                    keyboardType: TextInputType.emailAddress),
                _buildTextField(l10n.address, controller.addressController,
                    maxLines: 2),
                _buildTextField('Salary', controller.salaryController,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isEditing && employeeToEdit != null) {
                        final updated = controller.buildEmployeeFromForm(
                            existingCode: employeeToEdit.employeeCode ?? '');
                        await controller.updateEmployee(
                            employeeToEdit, updated);
                      } else {
                        await controller.addEmployee();
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
                SizedBox(
                    height:
                        MediaQuery.of(bottomSheetContext).viewInsets.bottom > 0
                            ? 16
                            : 0),
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
