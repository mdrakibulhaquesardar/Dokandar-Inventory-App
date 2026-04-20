import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/expense.dart';
import '../../../utils/vibration_helper.dart';

class ExpenseController extends GetxController {
  DatabaseService get _db => Get.find<DatabaseService>();
  final expenses = <Expense>[].obs;

  // Form controllers
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final data = await _db.getAllExpenses();
    expenses.assignAll(data);
  }

  void setFormFromExpense(Expense expense) {
    titleController.text = expense.title;
    amountController.text = expense.amount.toStringAsFixed(2);
    categoryController.text = expense.category ?? '';
    noteController.text = expense.note ?? '';
    selectedDate = expense.date ?? DateTime.now();
  }

  Expense buildExpenseFromForm() {
    final amount = double.tryParse(amountController.text.trim()) ?? 0;
    return Expense(
      title: titleController.text.trim(),
      amount: amount,
      category: categoryController.text.trim().isEmpty
          ? null
          : categoryController.text.trim(),
      note: noteController.text.trim().isEmpty
          ? null
          : noteController.text.trim(),
      date: selectedDate,
    );
  }

  Future<void> addExpense() async {
    final expense = buildExpenseFromForm();
    await _db.saveExpense(expense);
    expenses.add(expense);
    VibrationHelper.onSuccess();
  }

  Future<void> updateExpense(Expense original, Expense updated) async {
    updated.id = original.id;
    await _db.updateExpense(updated);
    final index = expenses.indexWhere((e) => e.id == original.id);
    if (index != -1) {
      expenses[index] = updated;
    }
    VibrationHelper.onSuccess();
  }

  Future<void> deleteExpense(int? id) async {
    if (id == null) return;
    await _db.deleteExpense(id);
    expenses.removeWhere((e) => e.id == id);
    VibrationHelper.onImportantAction();
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    categoryController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
