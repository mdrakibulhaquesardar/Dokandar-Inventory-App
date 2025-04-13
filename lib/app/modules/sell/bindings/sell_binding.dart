import 'package:get/get.dart';

import 'package:dokandar_app_inventory/app/modules/sell/controllers/invoice_generator_controller.dart';

import '../controllers/sell_controller.dart';

class SellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceGeneratorController>(
      () => InvoiceGeneratorController(),
    );
    Get.lazyPut<SellController>(
      () => SellController(),
    );
  }
}
