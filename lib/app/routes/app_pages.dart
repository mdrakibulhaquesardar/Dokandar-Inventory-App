import 'package:get/get.dart';

import '../modules/data_management/bindings/data_management_binding.dart';
import '../modules/data_management/views/backup_data_view.dart';
import '../modules/data_management/views/restore_data_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventory/bindings/inventory_binding.dart';
import '../modules/inventory/views/all_category_view.dart';
import '../modules/inventory/views/all_customer_view.dart';
import '../modules/inventory/views/all_products_view.dart';
import '../modules/inventory/views/inventory_view.dart';
import '../modules/sell/bindings/sell_binding.dart';
import '../modules/sell/views/checkout_view.dart';
import '../modules/sell/views/sell_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/setup/bindings/setup_binding.dart';
import '../modules/setup/views/confrom_view.dart';
import '../modules/setup/views/setup_view.dart';
import '../modules/setup/views/store_setup_view.dart';
import '../views/main_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.CONFROM_SETUP,
      page: () => const ConfromView(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INVENTORY,
      page: () => const InventoryView(),
      binding: InventoryBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.SELL,
      page: () => const SellView(),
      binding: SellBinding(),
    ),
    GetPage(
      name: _Paths.SETUP,
      page: () => const SetupView(),
      binding: SetupBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STORE_SETUP,
      page: () => const StoreSetupView(),
      binding: SetupBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => const AllCategoryView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ALL_PRODUCTS,
      page: () => const AllProductsView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ALL_CUSTOMER,
      page: () => const AllCustomerView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: SellBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.BACKUP_DATA,
      page: () => const BackupDataView(),
      binding: DataManagementBinding(),
    ),
    GetPage(
      name: _Paths.RESTORE_DATA,
      page: () => const RestoreDataView(),
      binding: DataManagementBinding(),
    ),
  ];
}
