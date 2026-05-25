import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/employee_controller.dart';
import 'package:dokandar_app_inventory/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Statistics Section
            Obx(() {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: themeConfig.getSurfaceColor(isDarkMode),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: themeConfig.getBorderColor(isDarkMode).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      l10n.totalEmployees,
                      controller.totalEmployeesCount.translateNumberToBengali(),
                      Icons.people_outline,
                      themeConfig,
                      isDarkMode,
                    ),
                    _buildStatCard(
                      l10n.activeEmployees,
                      controller.activeEmployeesCount.translateNumberToBengali(),
                      Icons.check_circle_outline,
                      themeConfig,
                      isDarkMode,
                    ),
                    _buildStatCard(
                      l10n.monthlyPayroll,
                      '${controller.totalMonthlyPayroll.translateNumberToBengali()}৳',
                      Icons.payments_outlined,
                      themeConfig,
                      isDarkMode,
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),

            // Search Bar & Filter Section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => controller.searchQuery.value = value,
                    style: SafeGoogleFonts.poppins(
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: '${l10n.search}...',
                      hintStyle: SafeGoogleFonts.poppins(
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      fillColor: themeConfig.getSurfaceColor(isDarkMode),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: themeConfig.getBorderColor(isDarkMode).withOpacity(0.5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: themeConfig.getPrimaryColor(isDarkMode),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Filter Chips Bar
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', l10n.allEmployees, themeConfig, isDarkMode),
                    const SizedBox(width: 8),
                    _buildFilterChip('Active', l10n.active, themeConfig, isDarkMode),
                    const SizedBox(width: 8),
                    _buildFilterChip('Inactive', l10n.inactive, themeConfig, isDarkMode),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),

            // Employee List Section
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filtered = controller.filteredEmployees;
                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: themeConfig.getTextSecondaryColor(isDarkMode).withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.dataNotFound,
                          style: SafeGoogleFonts.poppins(
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final employee = filtered[index];
                    return _buildEmployeeCard(context, employee, themeConfig, isDarkMode);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () {
          controller.clearForm();
          _showEmployeeForm(context, themeConfig, isDarkMode);
        },
        child: const Icon(Icons.person_add_alt_1_outlined, color: Colors.white),
      ),
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
      children: [
        Icon(
          icon,
          color: themeConfig.getPrimaryColor(isDarkMode),
          size: 20,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: SafeGoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: SafeGoogleFonts.poppins(
            fontSize: 11,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    String value,
    String label,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    final isSelected = controller.statusFilter.value == value;
    return ChoiceChip(
      label: Text(
        label,
        style: SafeGoogleFonts.poppins(
          color: isSelected ? Colors.white : themeConfig.getTextSecondaryColor(isDarkMode),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          controller.statusFilter.value = value;
        }
      },
      selectedColor: themeConfig.getPrimaryColor(isDarkMode),
      backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? Colors.transparent
              : themeConfig.getBorderColor(isDarkMode).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(
    BuildContext context,
    Employee employee,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final fallbackInitial = employee.name.isNotEmpty ? employee.name[0].toUpperCase() : '?';

    return InkWell(
      onTap: () => _showEmployeeDetails(context, employee, themeConfig, isDarkMode),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Styled Avatar with status indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                  child: Text(
                    fallbackInitial,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 22,
                      color: themeConfig.getPrimaryColor(isDarkMode),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: employee.isActive ? themeConfig.getSuccessColor(isDarkMode) : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: themeConfig.getSurfaceColor(isDarkMode),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // Employee Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          employee.name,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getTextPrimaryColor(isDarkMode),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (employee.role != null && employee.role!.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            employee.role!,
                            style: SafeGoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (employee.phone != null && employee.phone!.isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 14,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          employee.phone!,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 12,
                            color: themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        size: 14,
                        color: themeConfig.getSuccessColor(isDarkMode),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${l10n.salary}: ${employee.salary.translateNumberToBengali()}৳',
                        style: SafeGoogleFonts.poppins(
                          fontSize: 12,
                          color: themeConfig.getSuccessColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: themeConfig.getTextSecondaryColor(isDarkMode).withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmployeeDetails(
    BuildContext context,
    Employee employee,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final fallbackInitial = employee.name.isNotEmpty ? employee.name[0].toUpperCase() : '?';
    final formattedDate = employee.joinedAt != null
        ? DateFormat('dd MMM yyyy').format(employee.joinedAt!)
        : 'N/A';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Container(
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: themeConfig.getBorderColor(isDarkMode),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
                  child: Text(
                    fallbackInitial,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 26,
                      color: themeConfig.getPrimaryColor(isDarkMode),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      if (employee.role != null && employee.role!.isNotEmpty)
                        Text(
                          employee.role!,
                          style: SafeGoogleFonts.poppins(
                            fontSize: 14,
                            color: themeConfig.getPrimaryColor(isDarkMode),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: employee.isActive
                        ? themeConfig.getSuccessColor(isDarkMode).withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    employee.isActive ? l10n.active : l10n.inactive,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: employee.isActive ? themeConfig.getSuccessColor(isDarkMode) : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Details table
            _buildDetailRow(context, Icons.badge_outlined, l10n.employeeId, employee.employeeCode ?? 'N/A', themeConfig, isDarkMode),
            _buildDetailRow(context, Icons.phone_outlined, l10n.phone, employee.phone ?? 'N/A', themeConfig, isDarkMode),
            _buildDetailRow(context, Icons.email_outlined, l10n.email, employee.email ?? 'N/A', themeConfig, isDarkMode),
            _buildDetailRow(context, Icons.location_on_outlined, l10n.address, employee.address ?? 'N/A', themeConfig, isDarkMode),
            _buildDetailRow(
              context,
              Icons.payments_outlined,
              l10n.salary,
              '${employee.salary.translateNumberToBengali()}৳ / month',
              themeConfig,
              isDarkMode,
              valueColor: themeConfig.getSuccessColor(isDarkMode),
              isBold: true,
            ),
            _buildDetailRow(context, Icons.calendar_month_outlined, l10n.joiningDate, formattedDate, themeConfig, isDarkMode),
            if (employee.notes != null && employee.notes!.isNotEmpty)
              _buildDetailRow(context, Icons.notes_outlined, l10n.notes, employee.notes!, themeConfig, isDarkMode),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(bottomSheetContext); // Close details sheet
                      controller.setFormFromEmployee(employee);
                      _showEmployeeForm(context, themeConfig, isDarkMode, employee: employee);
                    },
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    label: Text(
                      l10n.edit,
                      style: SafeGoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  _showDeleteConfirmation(context, employee, themeConfig, isDarkMode, bottomSheetContext);
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                label: Text(
                  l10n.deleteEmployee,
                  style: SafeGoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    AppThemeConfig themeConfig,
    bool isDarkMode, {
    Color? valueColor,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: SafeGoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: SafeGoogleFonts.poppins(
                fontSize: 13,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                color: valueColor ?? themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
          ),
        ],
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => Form(
        key: controller.formKey,
        child: Container(
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top notch bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: themeConfig.getBorderColor(isDarkMode),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Form Title
                Text(
                  isEditing ? l10n.editEmployee : l10n.addNewEmployee,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 20),

                // Text Fields
                _buildFormField(
                  labelText: l10n.name,
                  controller: controller.nameController,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? l10n.nameRequired : null,
                ),
                _buildFormField(
                  labelText: l10n.rolePosition,
                  controller: controller.roleController,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? l10n.roleRequired : null,
                ),
                _buildFormField(
                  labelText: l10n.phone,
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.phoneRequired;
                    }
                    if (value.trim().length < 5) {
                      return l10n.invalidPhone;
                    }
                    return null;
                  },
                ),
                _buildFormField(
                  labelText: l10n.email,
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  validator: (value) {
                    if (value != null && value.trim().isNotEmpty) {
                      if (!GetUtils.isEmail(value.trim())) {
                        return l10n.invalidEmail;
                      }
                    }
                    return null;
                  },
                ),
                _buildFormField(
                  labelText: l10n.address,
                  controller: controller.addressController,
                  maxLines: 2,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),
                _buildFormField(
                  labelText: l10n.salary,
                  controller: controller.salaryController,
                  keyboardType: TextInputType.number,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.salaryRequired;
                    }
                    final num = double.tryParse(value.trim());
                    if (num == null || num <= 0) {
                      return l10n.salaryRequired;
                    }
                    return null;
                  },
                ),
                _buildFormField(
                  labelText: l10n.notes,
                  controller: controller.notesController,
                  maxLines: 2,
                  themeConfig: themeConfig,
                  isDarkMode: isDarkMode,
                ),

                // Joining Date Row Selection
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 20, color: themeConfig.getPrimaryColor(isDarkMode)),
                      const SizedBox(width: 10),
                      Text(
                        '${l10n.joiningDate}: ',
                        style: SafeGoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        final date = controller.joinedAt.value;
                        final label = date != null ? DateFormat('dd MMM yyyy').format(date) : l10n.optional;
                        return OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: themeConfig.getBorderColor(isDarkMode)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () async {
                            final now = DateTime.now();
                            final selected = await showDatePicker(
                              context: context,
                              initialDate: date ?? now,
                              firstDate: DateTime(now.year - 20),
                              lastDate: DateTime(now.year + 5),
                            );
                            if (selected != null) {
                              controller.joinedAt.value = selected;
                            }
                          },
                          child: Text(
                            label,
                            style: SafeGoogleFonts.poppins(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Active / Inactive Switch
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Icon(Icons.toggle_on_outlined, size: 22, color: themeConfig.getPrimaryColor(isDarkMode)),
                      const SizedBox(width: 10),
                      Text(
                        '${l10n.status}: ',
                        style: SafeGoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        final val = controller.isActive.value;
                        return Switch(
                          activeColor: themeConfig.getPrimaryColor(isDarkMode),
                          value: val,
                          onChanged: (newVal) => controller.isActive.value = newVal,
                        );
                      }),
                      const SizedBox(width: 8),
                      Obx(() {
                        return Text(
                          controller.isActive.value ? l10n.active : l10n.inactive,
                          style: SafeGoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: controller.isActive.value
                                ? themeConfig.getSuccessColor(isDarkMode)
                                : themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // Submit Button
                Obx(() {
                  final isSaving = controller.isLoading.value;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: isSaving
                          ? null
                          : () async {
                              final success = isEditing
                                  ? await controller.updateEmployeeDetails(employee)
                                  : await controller.addEmployee();
                              if (success && bottomSheetContext.mounted) {
                                Navigator.pop(bottomSheetContext);
                              }
                            },
                      child: isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              isEditing ? l10n.update : l10n.save,
                              style: SafeGoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String labelText,
    required TextEditingController controller,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: SafeGoogleFonts.poppins(
          fontSize: 14,
          color: themeConfig.getTextPrimaryColor(isDarkMode),
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: SafeGoogleFonts.poppins(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
            fontSize: 13,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: themeConfig.getBorderColor(isDarkMode)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: themeConfig.getBorderColor(isDarkMode).withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: themeConfig.getPrimaryColor(isDarkMode)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: themeConfig.getErrorColor(isDarkMode)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: themeConfig.getErrorColor(isDarkMode)),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Employee employee,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    BuildContext detailsContext,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.deleteEmployee,
          style: SafeGoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        content: Text(
          l10n.confirmDeleteEmployee,
          style: SafeGoogleFonts.poppins(
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              l10n.cancel,
              style: SafeGoogleFonts.poppins(
                color: themeConfig.getTextSecondaryColor(isDarkMode),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              Navigator.pop(dialogContext); // Close dialog
              Navigator.pop(detailsContext); // Close details bottom sheet
              await controller.deleteEmployee(employee.id);
            },
            child: Text(
              l10n.delete,
              style: SafeGoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
