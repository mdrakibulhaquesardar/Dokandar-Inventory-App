import 'package:get/get.dart';

import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllCategoryController.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllCustomerController.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/AllProductController.dart';
import 'package:dokandar_app_inventory/app/modules/inventory/controllers/all_sales_controller.dart';
import '../controllers/due_customers_controller.dart';
import '../controllers/inventory_controller.dart';
import '../controllers/supplier_controller.dart';
import '../controllers/employee_controller.dart';
import '../controllers/expense_controller.dart';
import '../controllers/transaction_controller.dart';
import '../controllers/stock_alert_controller.dart';
import '../controllers/report_controller.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DueCustomersController>(
      () => DueCustomersController(),
    );

    Get.lazyPut<AllSalesController>(
      () => AllSalesController(),
    );
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
    Get.lazyPut<SupplierController>(
      () => SupplierController(),
    );
    Get.lazyPut<EmployeeController>(
      () => EmployeeController(),
    );
    Get.lazyPut<ExpenseController>(
      () => ExpenseController(),
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );
    Get.lazyPut<StockAlertController>(
      () => StockAlertController(),
    );
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
  }
}
