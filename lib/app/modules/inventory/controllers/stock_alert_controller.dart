import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/product.dart';

class StockAlertController extends GetxController {
  final RxList<Product> lowStockProducts = <Product>[].obs;
  DatabaseService get _db => Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchLowStock();
  }

  Future<void> fetchLowStock() async {
    final items = await _db.getLowStockProducts();
    lowStockProducts.assignAll(items);
  }
}
