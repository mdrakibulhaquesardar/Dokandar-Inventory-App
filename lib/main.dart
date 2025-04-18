import 'package:dokandar_app_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/core/services/database_service.dart';
import 'app/controllers/persistent_navigation_controller.dart';
import 'app/modules/inventory/controllers/inventory_controller.dart';
import 'app/modules/sell/controllers/sell_controller.dart';
import 'app/modules/setting/controllers/setting_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/config/app_config.dart';
import 'app/config/app_theme_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services
  final dbService = await Get.putAsync(() => DatabaseService().init());
  await Get.putAsync(() => AppConfig().init());
  Get.put(AppThemeConfig());

  // Initialize controllers
  Get.put(PersistentNavigationController());
  Get.put(SettingController());
  Get.put(HomeController());
  Get.put(SellController());
  Get.put(InventoryController());

  // Check if user exists
  final hasUser = await dbService.hasUser();
  final initialRoute = hasUser ? Routes.MAIN : Routes.SETUP;

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: Get.find <AppConfig>().appCurrentName,
    theme: Get.find<AppThemeConfig>().getLightTheme(),
    darkTheme: Get.find<AppThemeConfig>().getDarkTheme(),
    themeMode: ThemeMode.system,
    initialRoute:   initialRoute,
    getPages: AppPages.routes,
    defaultTransition: Transition.fade,
    initialBinding: BindingsBuilder(() {
      Get.lazyPut<DatabaseService>(() => DatabaseService());
      Get.lazyPut<HomeController>(() => HomeController());
      Get.lazyPut<AppConfig>(() => AppConfig());
      Get.lazyPut<AppThemeConfig>(() => AppThemeConfig());
    }),
  ));
}
