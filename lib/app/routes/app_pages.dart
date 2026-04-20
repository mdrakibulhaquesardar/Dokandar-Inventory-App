import 'package:dokandar_app_inventory/app/modules/setting/views/subscription_view.dart';
import 'package:get/get.dart';

import '../modules/app_lock/bindings/app_lock_binding.dart';
import '../modules/app_lock/views/lock_screen_view.dart';
import '../modules/app_lock/views/manage_pin_view.dart';
import '../modules/data_management/bindings/data_management_binding.dart';
import '../modules/data_management/views/backup_data_view.dart';
import '../modules/data_management/views/restore_data_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventory/bindings/inventory_binding.dart';
import '../modules/inventory/views/all_category_view.dart';
import '../modules/inventory/views/all_customer_view.dart';
import '../modules/inventory/views/all_products_view.dart';
import '../modules/inventory/views/all_sales_view.dart';
import '../modules/inventory/views/due_customers_view.dart';
import '../modules/inventory/views/inventory_view.dart';
import '../modules/inventory/views/all_suppliers_view.dart';
import '../modules/inventory/views/all_employees_view.dart';
import '../modules/inventory/views/store_expenses_view.dart';
import '../modules/inventory/views/transaction_history_view.dart';
import '../modules/inventory/views/stock_alert_view.dart';
import '../modules/inventory/views/report_generator_view.dart';
import '../modules/setting/views/store_settings_view.dart';

import '../modules/sell/bindings/sell_binding.dart';
import '../modules/sell/views/checkout_view.dart';
import '../modules/sell/views/invoice_preview_view.dart';
import '../modules/sell/views/sell_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/about_app_view.dart';
import '../modules/setting/views/feedback_view.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/setting/views/support_view.dart';
import '../modules/setting/views/edit_profile_view.dart';
import '../modules/setting/views/privacy_policy_view.dart';
import '../modules/setting/views/terms_view.dart';
import '../modules/home/views/search_view.dart';
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
      name: _Paths.APP_LOCK,
      page: () => const LockScreenView(),
      binding: AppLockBinding(),
      transition: Transition.fadeIn,
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
      name: _Paths.MANAGE_PIN,
      page: () => const ManagePinView(),
      binding: AppLockBinding(),
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
      name: _Paths.ALL_SALES,
      page: () => const AllSalesView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ALL_SUPPLIERS,
      page: () => const AllSuppliersView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ALL_EMPLOYEES,
      page: () => const AllEmployeesView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STORE_EXPENSES,
      page: () => const StoreExpensesView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TRANSACTION_HISTORY,
      page: () => const TransactionHistoryView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STOCK_ALERT,
      page: () => const StockAlertView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.GENERATE_REPORT,
      page: () => const ReportGeneratorView(),
      binding: InventoryBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STORE_SETTINGS,
      page: () => const StoreSettingsView(),
      binding: SettingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: SettingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => const PrivacyPolicyView(),
      binding: SettingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TERMS,
      page: () => const TermsView(),
      binding: SettingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PAY_DUE,
      page: () => const DueCustomersView(),
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
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => const FeedbackView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_APP,
      page: () => const AboutAppView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.INVOICE_PREVIEW,
      page: () => const InvoicePreviewView(),
      binding: SellBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
