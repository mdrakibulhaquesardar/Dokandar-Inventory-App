import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {
   var currentIndex = 1.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed(Routes.HOME);
        break;
      case 1:
        Get.offAllNamed(Routes.INVENTORY);
        break;
      case 2:
        Get.offAllNamed(Routes.SELL);
        break;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
