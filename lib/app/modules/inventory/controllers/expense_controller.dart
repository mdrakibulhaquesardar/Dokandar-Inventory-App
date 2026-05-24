import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/expense.dart';
import '../../../utils/vibration_helper.dart';

class ExpenseController extends GetxController {
  final RxList<Expense> expenses = <Expense>[].obs;

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();
  final noteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  final _db = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
  }

  Future<void> fetchExpenses() async {
    final data = await _db.getAllExpenses();
    expenses.assignAll(data);
  }

  Future<bool> addExpense() async {
    if (titleController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Title and amount are required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    final amount = double.tryParse(amountController.text.trim()) ?? 0;
    final expense = Expense(
      title: titleController.text.trim(),
      amount: amount,
      category: categoryController.text.trim().isEmpty
          ? null
          : categoryController.text.trim(),
      note:
          noteController.text.trim().isEmpty ? null : noteController.text.trim(),
      date: selectedDate,
    );
    await _db.saveExpense(expense);
    await fetchExpenses();
    VibrationHelper.onSuccess();
    clearForm();
    return true;
  }

  Future<bool> updateExpense(Expense original, Expense updated) async {
    if (updated.title.trim().isEmpty || updated.amount <= 0) {
      Get.snackbar('Error', 'Title and valid amount are required',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    updated.id = original.id;
    await _db.updateExpense(updated);
    await fetchExpenses();
    VibrationHelper.onSuccess();
    return true;
  }

  Future<void> deleteExpense(int id) async {
    await _db.deleteExpense(id);
    expenses.removeWhere((e) => e.id == id);
    VibrationHelper.onImportantAction();
  }

  void setFormFromExpense(Expense expense) {
    titleController.text = expense.title;
    amountController.text = expense.amount.toStringAsFixed(0);
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
      note:
          noteController.text.trim().isEmpty ? null : noteController.text.trim(),
      date: selectedDate,
    );
  }

  void clearForm() {
    titleController.clear();
    amountController.clear();
    categoryController.clear();
    noteController.clear();
    selectedDate = DateTime.now();
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

