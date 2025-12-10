import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../data/models/expense.dart';
import '../../../widgets/Custom_AppBar.dart';

class StoreExpensesView extends GetView<ExpenseController> {
  const StoreExpensesView({super.key});

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
        l10n.storeExpenses,
        true,
        false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () => _showExpenseForm(context, themeConfig, isDarkMode),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final expenses = controller.expenses;
          if (expenses.isEmpty) {
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
            itemCount: expenses.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return Card(
                elevation: 0,
                color: themeConfig.getSurfaceColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    expense.title,
                    style: SafeGoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: themeConfig.getTextPrimaryColor(isDarkMode),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(expense.date ?? DateTime.now()),
                        style: SafeGoogleFonts.poppins(
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                          fontSize: 12,
                        ),
                      ),
                      if (expense.category != null)
                        Text(
                          expense.category!,
                          style: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 12,
                          ),
                        ),
                      if (expense.note != null)
                        Text(
                          expense.note!,
                          style: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '৳${expense.amount.toStringAsFixed(2)}',
                        style: SafeGoogleFonts.poppins(
                          color: themeConfig.getErrorColor(isDarkMode),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                        onSelected: (value) {
                          if (value == 'edit') {
                            controller.setFormFromExpense(expense);
                            _showExpenseForm(
                                context, themeConfig, isDarkMode,
                                expense: expense);
                          } else if (value == 'delete') {
                            controller.deleteExpense(expense.id);
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

  void _showExpenseForm(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode, {
    Expense? expense,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = expense != null;
    final expenseToEdit = expense; // Store non-null reference for editing
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
                _buildTextField('Title', controller.titleController),
                _buildTextField('Amount', controller.amountController,
                    keyboardType: TextInputType.number),
                _buildTextField(l10n.category, controller.categoryController),
                _buildTextField('Note', controller.noteController,
                    maxLines: 2),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(controller.selectedDate),
                      style: SafeGoogleFonts.poppins(
                        color:
                            themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          controller.selectedDate = picked;
                          controller.update();
                        }
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: Text('Select Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isEditing && expenseToEdit != null) {
                        final updated = controller.buildExpenseFromForm();
                        await controller.updateExpense(expenseToEdit, updated);
                      } else {
                        await controller.addExpense();
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

