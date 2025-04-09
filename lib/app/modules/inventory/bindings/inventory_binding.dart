import 'package:get/get.dart';

import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllCategoryController.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/all_customer_controller_controller.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllProductController.dart';

import '../controllers/inventory_controller.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCategoryController>(
      () => AllCategoryController(),
    );
    Get.lazyPut<AllCustomerControllerController>(
      () => AllCustomerControllerController(),
    );
    Get.lazyPut<AllProductController>(
      () => AllProductController(),
    );
    Get.lazyPut<InventoryController>(
      () => InventoryController(),
    );
  }
}
