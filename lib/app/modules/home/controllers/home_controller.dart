import 'package:dokandar_app_inventory/app/data/models/product.dart';
import 'package:dokandar_app_inventory/app/data/models/sale.dart';
import 'package:dokandar_app_inventory/app/data/models/expense.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/store.dart';
import '../../../core/services/database_service.dart';

class DashboardTransaction {
  final String title;
  final String subtitle;
  final DateTime date;
  final double amount;
  final bool isIncome;
  final IconData icon;

  DashboardTransaction({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.amount,
    required this.isIncome,
    required this.icon,
  });
}

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var store = Rxn<Store>(); // Made store observable

  RxInt totalProducts = 0.obs;
  RxInt totalCustomers = 0.obs;
  RxDouble totalSales = 0.0.obs;
  RxInt totalCategories = 0.obs;
  RxInt todaySalesCount = 0.obs;
  RxDouble totalRevenue = 0.0.obs;

  // Financial summary observables
  RxDouble totalCustomerDue = 0.0.obs;
  RxDouble totalSupplierDue = 0.0.obs;
  RxDouble totalExpenses = 0.0.obs;

  // all sale variable
  RxList<Sale> recentSale = <Sale>[].obs;

  // all products variable
  RxList<Product> allLowStokeProduct = <Product>[].obs;

  // Recent transactions stream observable
  RxList<DashboardTransaction> transactionsStream = <DashboardTransaction>[].obs;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final RxString searchQuery = ''.obs;
  final RxList<Product> searchResults = <Product>[].obs;
  final RxString filterType = 'all'.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed(Routes.HOME);
        break;
      case 1:
        Get.toNamed(Routes.INVENTORY);
        break;
      case 2:
        Get.toNamed(Routes.SELL);
        break;
    }
  }

  void getStoreInfo() async {
    try {
      final storeData = await Get.find<DatabaseService>().getStore();
      store.value = storeData;
      if (store.value != null) {
        debugPrint("Store found: ${store.value!.name}");
      } else {
        debugPrint("No store found");
      }
    } catch (e) {
      debugPrint("Error fetching store info: $e");
    }
  }

  Future<void> getAllStatistics() async {
    try {
      final db = Get.find<DatabaseService>();
      
      // Fetch all statistics from the database
      final allProducts = await db.getAllProducts();
      final allCustomers = await db.getAllCustomers();
      final allSalesToday = await db.getTotalSalesToday();
      final allCategories = await db.getAllCategories();
      
      // Additional financial statistics
      final allSuppliers = await db.getAllSuppliers();
      final allExpensesList = await db.getAllExpenses();

      // Update the observable variables
      totalProducts.value = allProducts.length;
      totalCustomers.value = allCustomers.length;
      totalSales.value = allSalesToday;
      totalCategories.value = allCategories.length;

      // Compute dues and expenses
      totalCustomerDue.value = allCustomers.fold(0.0, (sum, c) => sum + c.totalDue);
      totalSupplierDue.value = allSuppliers.fold(0.0, (sum, s) => sum + s.totalDue);
      totalExpenses.value = allExpensesList.fold(0.0, (sum, e) => sum + e.amount);

      debugPrint("Total Products: ${totalProducts.value}");
      debugPrint("Total Customers: ${totalCustomers.value}");
      debugPrint("Total Sales Today: ${totalSales.value}");
      debugPrint("Total Customer Dues: ${totalCustomerDue.value}");
      debugPrint("Total Supplier Dues: ${totalSupplierDue.value}");
    } catch (e) {
      debugPrint("Error fetching statistics: $e");
    }
  }

  Future<void> getRecentSales() async {
    final allSales = await Get.find<DatabaseService>().getSalesToday();
    recentSale.assignAll(allSales);
  }

  Future<void> getTodaySales() async {
    final allSales = await Get.find<DatabaseService>().getSalesToday();
    recentSale.assignAll(allSales);
  }

  Future<void> getLowStockProducts() async {
    final lowStockProducts = await Get.find<DatabaseService>().getLowStockProducts();
    allLowStokeProduct.assignAll(lowStockProducts);
    printInfo(info: "Low stock products: ${allLowStokeProduct.length}");
  }

  // totalRevenue
  Future<void> getTotalRevenue() async {
    final revenue = await Get.find<DatabaseService>().totalRevenue();
    totalRevenue.value = revenue;
  }

  Future<void> getRecentTransactions() async {
    try {
      final db = Get.find<DatabaseService>();
      final sales = await db.getAllSales();
      final expenses = await db.getAllExpenses();

      final List<DashboardTransaction> list = [];

      // Add Sales
      for (var sale in sales) {
        final title = sale.items.isNotEmpty 
            ? sale.items.map((i) => i.productName).join(', ') 
            : 'পণ্য বিক্রয়';
        list.add(DashboardTransaction(
          title: title,
          subtitle: 'রশিদ: #${sale.invoiceNumber}',
          date: sale.saleDate,
          amount: sale.totalAmount,
          isIncome: true,
          icon: Icons.point_of_sale_outlined,
        ));
      }

      // Add Expenses
      for (var exp in expenses) {
        list.add(DashboardTransaction(
          title: exp.title,
          subtitle: exp.category ?? 'দোকান খরচ',
          date: exp.date ?? DateTime.now(),
          amount: exp.amount,
          isIncome: false,
          icon: Icons.receipt_long_outlined,
        ));
      }

      // Sort by date descending
      list.sort((a, b) => b.date.compareTo(a.date));

      // Keep recent 10 items
      transactionsStream.assignAll(list.take(10).toList());
    } catch (e) {
      debugPrint("Error fetching recent transactions: $e");
    }
  }

  Future<void> searchProducts(String query) async {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    final results = await Get.find<DatabaseService>().searchProducts(query);
    final filtered = _applyFilter(results);
    searchResults.assignAll(filtered);
  }

  void setFilter(String type) {
    filterType.value = type;
    if (searchController.text.isNotEmpty) {
      searchProducts(searchController.text);
    }
  }

  List<Product> _applyFilter(List<Product> products) {
    switch (filterType.value) {
      case 'low_stock':
        return products.where((p) => p.isLowStock).toList();
      default:
        return products;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllStatistics();
    getRecentSales();
    getLowStockProducts();
    getRecentTransactions();
  }

  @override
  void onReady() {
    super.onReady();
    getStoreInfo();
  }

  @override
  void refresh() {
    super.refresh();
    getAllStatistics();
    getRecentSales();
    getLowStockProducts();
    getTodaySales();
    getTotalRevenue();
    getRecentTransactions();
  }

  void unfocusSearch() {
    searchFocusNode.unfocus();
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
