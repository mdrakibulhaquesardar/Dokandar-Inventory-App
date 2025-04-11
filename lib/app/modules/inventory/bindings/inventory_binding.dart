import 'package:get/get.dart';

import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllCategoryController.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllCustomerController.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllProductController.dart';

import '../controllers/inventory_controller.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCategoryController>(
      () => AllCategoryController(),
    );
    Get.lazyPut<AllCustomerController>(
      () => AllCustomerController(),
    );
    Get.lazyPut<AllProductController>(
      () => AllProductController(),
    );
    Get.lazyPut<InventoryController>(
      () => InventoryController(),
    );
  }
}
