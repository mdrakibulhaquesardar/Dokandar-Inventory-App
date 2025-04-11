import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/store.dart';
import '../../../data/services/database_service.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var store = Rxn<Store>(); // Made store observable

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
    store.value = await Get.find<DatabaseService>().getStore(); // Update the observable
    if (store.value != null) {
      debugPrint("Store found: ${store.value!.name}");
    } else {
      debugPrint("No store found");
    }
  }

  @override
  void onInit() {
    super.onInit();

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
