import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';

class TransactionEntry {
  final String type; // sale or expense
  final String title;
  final double amount;
  final DateTime date;

  TransactionEntry({
    required this.type,
    required this.title,
    required this.amount,
    required this.date,
  });
}

class TransactionController extends GetxController {
  final RxList<TransactionEntry> transactions = <TransactionEntry>[].obs;
  DateTimeRange? filterRange;
  final RxString filterType = 'all'.obs; // all, sale, expense

  DatabaseService get _db => Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final sales = await _db.getAllSales();
    final expenses = await _db.getAllExpenses();

    final List<TransactionEntry> combined = [
      ...sales.map((s) => TransactionEntry(
            type: 'sale',
            title: 'Invoice ${s.invoiceNumber}',
            amount: s.totalAmount,
            date: s.saleDate,
          )),
      ...expenses.where((e) => e.date != null).map((e) => TransactionEntry(
            type: 'expense',
            title: e.title,
            amount: -e.amount,
            date: e.date!,
          )),
    ];

    combined.sort((a, b) => b.date.compareTo(a.date));
    transactions.assignAll(combined);
  }

  List<TransactionEntry> get filteredTransactions {
    return transactions.where((tx) {
      final inType = filterType.value == 'all' || tx.type == filterType.value;
      final inRange = filterRange == null ||
          (tx.date.isAfter(
                  filterRange!.start.subtract(const Duration(days: 1))) &&
              tx.date.isBefore(filterRange!.end.add(const Duration(days: 1))));
      return inType && inRange;
    }).toList();
  }

  void setType(String type) {
    filterType.value = type;
  }

  void setRange(DateTimeRange? range) {
    filterRange = range;
    update();
  }
}
