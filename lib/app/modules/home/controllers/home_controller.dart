import 'package:dokandar_app_inventory/app/data/models/product.dart';
import 'package:dokandar_app_inventory/app/data/models/sale.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../data/models/store.dart';
import '../../../data/services/database_service.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var store = Rxn<Store>(); // Made store observable

  RxInt totalProducts = 0.obs;
  RxInt totalCustomers = 0.obs;
  RxDouble totalSales = 0.0.obs;
  RxInt totalCategories = 0.obs;
  RxInt todaySalesCount = 0.obs;

  // all sale variable
  RxList<Sale> recentSale = <Sale>[].obs;

  // all products variable
  RxList<Product> allLowStokeProduct = <Product>[].obs;






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
      // Fetch all statistics from the database
      final allProducts = await Get.find<DatabaseService>().getAllProducts();
      final allCustomers = await Get.find<DatabaseService>().getAllCustomers();
      final allSales = await Get.find<DatabaseService>().getTotalSalesToday();
      final allCategories = await Get.find<DatabaseService>().getAllCategories();

      // Update the observable variables
      totalProducts.value = allProducts.length;
      totalCustomers.value = allCustomers.length;
      totalSales.value = allSales;
      totalCategories.value = allCategories.length;

      debugPrint("Total Products: ${totalProducts.value}");
      debugPrint("Total Customers: ${totalCustomers.value}");
      debugPrint("Total Sales: ${totalSales.value}");
    } catch (e) {
      debugPrint("Error fetching statistics: $e");
    }
  }

  Future<void> getRecentSales() async {
    final allSales = await Get.find<DatabaseService>().getSalesToday();
    recentSale.assignAll(allSales);
  }

  Future<void> getTodaySalesCount() async {
    final allSales = await Get.find<DatabaseService>().getSalesToday();
    recentSale.assignAll(allSales);
  }

  Future<void> getLowStockProducts() async {
    final lowStockProducts = await Get.find<DatabaseService>().getLowStockProducts();
    allLowStokeProduct.assignAll(lowStockProducts);
    printInfo(info: "Low stock products: ${allLowStokeProduct.length}");
  }




  //Refresh the statistics

  void refreshStatistics() {
    Future.wait([
      getAllStatistics(),
      getRecentSales(),
      getLowStockProducts(),
    ]).then((_) {
      // Show a toast message after refreshing
      Fluttertoast.showToast(
        msg: "রিফ্রেশ করা হয়েছে",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAllStatistics();
    getRecentSales();
    getLowStockProducts();

  }

  @override
  void onReady() {
    super.onReady();
    getStoreInfo();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
