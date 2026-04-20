import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../core/services/database_service.dart';

class InventoryController extends GetxController {
  var currentIndex = 1.obs;
  RxInt totalProducts = 0.obs;
  RxInt totalProductsPrice = 0.obs;

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
    // Ensure DatabaseService is available before accessing it
    if (Get.isRegistered<DatabaseService>()) {
      Get.find<DatabaseService>().getTotalProducts().then((value) {
        totalProducts.value = value;
      });
      Get.find<DatabaseService>().getTotalProductsPrice().then((value) {
        totalProductsPrice.value = value.toInt();
      });
    }
  }

  void increment() => count.value++;
}
