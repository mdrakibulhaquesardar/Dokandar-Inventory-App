import 'package:dokandar_app_inventory/app/data/models/product.dart';
import 'package:dokandar_app_inventory/app/data/models/sale.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/store.dart';
import '../../../../mock/mock_data_service.dart';
import '../../notifications/controllers/notifications_controller.dart';

class HomeController extends GetxController {
  final _mock = const MockDataService();

  var currentIndex = 0.obs;
  var store = Rxn<Store>();

  RxInt totalProducts = 0.obs;
  RxInt totalCustomers = 0.obs;
  RxDouble totalSales = 0.0.obs;
  RxInt totalCategories = 0.obs;
  RxInt todaySalesCount = 0.obs;
  RxDouble totalRevenue = 0.0.obs;

  RxList<Sale> recentSale = <Sale>[].obs;
  RxList<Product> allLowStokeProduct = <Product>[].obs;

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

  Future<void> getStoreInfo() async {
    store.value = await _mock.getStore();
  }

  Future<void> getAllStatistics() async {
    final products = await _mock.getAllProducts();
    final customers = await _mock.getAllCustomers();
    final sales = await _mock.getAllSales();
    final categories = await _mock.getAllCategories();

    totalProducts.value = products.length;
    totalCustomers.value = customers.length;
    totalSales.value = sales.fold(0.0, (sum, s) => sum + s.totalAmount);
    totalCategories.value = categories.length;
  }

  Future<void> getRecentSales() async {
    final allSales = await _mock.getAllSales();
    recentSale.assignAll(allSales.take(5));
  }

  Future<void> getLowStockProducts() async {
    final lowStockProducts = await _mock.getLowStockProducts();
    allLowStokeProduct.assignAll(lowStockProducts);
  }

  Future<void> getTotalRevenue() async {
    totalRevenue.value = await _mock.getTotalRevenue();
  }

  Future<void> searchProducts(String query) async {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }
    final results = await _mock.searchProducts(query);
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
    // Ensure NotificationsController is available for dashboard badge
    if (!Get.isRegistered<NotificationsController>()) {
      Get.lazyPut<NotificationsController>(() => NotificationsController());
    }
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
    getTotalRevenue();
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
