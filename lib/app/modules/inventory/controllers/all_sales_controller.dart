import 'package:get/get.dart';
import '../../../data/models/sale.dart';
import '../../../../mock/mock_data_service.dart';

class AllSalesController extends GetxController {
  final _mock = const MockDataService();
  final RxList<Sale> sales = <Sale>[].obs;
  final RxDouble totalSales = 0.0.obs;
  final RxDouble totalDue = 0.0.obs;
  final RxInt totalTransactions = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadSales();
  }

  final Rx<DateTime?> startDate = Rx<DateTime?>(null);
  final Rx<DateTime?> endDate = Rx<DateTime?>(null);
  final RxList<Sale> filteredSales = <Sale>[].obs;

  Future<void> loadSales() async {
    sales.value = await _mock.getAllSales();
    filterSales();
    _calculateStats();
  }

  void filterSales() {
    if (startDate.value == null && endDate.value == null) {
      filteredSales.value = sales;
    } else {
      filteredSales.value = sales.where((sale) {
        final saleDate = DateTime(
          sale.saleDate.year,
          sale.saleDate.month,
          sale.saleDate.day,
        );

        if (startDate.value != null && endDate.value != null) {
          return saleDate.isAfter(startDate.value!) &&
              saleDate.isBefore(endDate.value!.add(const Duration(days: 1)));
        } else if (startDate.value != null) {
          return saleDate.isAfter(startDate.value!);
        } else {
          return saleDate.isBefore(endDate.value!.add(const Duration(days: 1)));
        }
      }).toList();
    }
    _calculateStats();
  }

  void setDateRange(DateTime? start, DateTime? end) {
    startDate.value = start;
    endDate.value = end;
    filterSales();
  }

  void clearDateFilter() {
    startDate.value = null;
    endDate.value = null;
    filterSales();
  }

  void _calculateStats() {
    totalSales.value =
        filteredSales.fold(0.0, (sum, sale) => sum + sale.totalAmount);
    totalDue.value =
        filteredSales.fold(0.0, (sum, sale) => sum + sale.dueAmount);
    totalTransactions.value = filteredSales.length;
  }
}
