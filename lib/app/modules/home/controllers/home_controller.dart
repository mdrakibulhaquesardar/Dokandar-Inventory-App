import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/store.dart';
import '../../../data/services/database_service.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  Store? store;

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
    store = await Get.find<DatabaseService>().getStore();
    if (store != null) {
      if (kDebugMode) {
        print("Store found: ${store!.name}");
      }
    } else {
      if (kDebugMode) {
        print("No store found");
      }
    }
  }
  @override
  void onInit() {
    super.onInit();
    getStoreInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
