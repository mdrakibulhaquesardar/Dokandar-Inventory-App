import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/models/sale.dart';
import '../../../../mock/mock_data_service.dart';

class ReportController extends GetxController {
  final _mock = const MockDataService();

  final RxString reportType = 'daily'.obs; // daily, weekly, monthly, custom
  DateTimeRange? customRange;
  final RxDouble totalSales = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _calculate();
  }

  void setReportType(String type) {
    reportType.value = type;
    _calculate();
  }

  void setRange(DateTimeRange range) {
    customRange = range;
    _calculate();
  }

  Future<void> _calculate() async {
    final sales = await _mock.getAllSales();
    final filtered = _filterSales(sales);
    totalSales.value =
        filtered.fold(0.0, (sum, sale) => sum + sale.totalAmount);
  }

  List<Sale> _filterSales(List<Sale> sales) {
    final now = DateTime.now();
    late DateTime start;
    late DateTime end;

    switch (reportType.value) {
      case 'weekly':
        start = now.subtract(const Duration(days: 7));
        end = now;
        break;
      case 'monthly':
        start = DateTime(now.year, now.month, 1);
        end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
        break;
      case 'custom':
        start = customRange?.start ?? now.subtract(const Duration(days: 7));
        end = customRange?.end ?? now;
        break;
      default:
        start = DateTime(now.year, now.month, now.day);
        end = start.add(const Duration(days: 1));
    }

    return sales
        .where(
          (s) =>
              s.saleDate.isAfter(start.subtract(const Duration(seconds: 1))) &&
              s.saleDate.isBefore(end.add(const Duration(seconds: 1))),
        )
        .toList();
  }
}
