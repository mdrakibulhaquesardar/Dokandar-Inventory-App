import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventory/views/inventory_view.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/inventory/controllers/inventory_controller.dart';
import '../modules/setting/controllers/setting_controller.dart';

class PersistentNavigationController extends GetxController {
  late PersistentTabController tabController;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = PersistentTabController(initialIndex: 0);

    // Ensure tab views (GetView<T>) have their controllers registered
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(() => HomeController());
    }
    if (!Get.isRegistered<InventoryController>()) {
      Get.lazyPut<InventoryController>(() => InventoryController());
    }
    if (!Get.isRegistered<SettingController>()) {
      Get.lazyPut<SettingController>(() => SettingController());
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Ensure controller is ready before navigation
  }

  List<Widget> buildScreens() {
    return [
      const HomeView(),
      const InventoryView(),
      const SettingView(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    final l10n = AppLocalizations.of(Get.context!)!;
    const iconSize = 20.0;
    const labelStyle = TextStyle(fontSize: 11);
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, size: iconSize),
        textStyle: labelStyle,
        title: l10n.home,
        activeColorPrimary:
            Get.find<AppThemeConfig>().getPrimaryColor(Get.isDarkMode),
        inactiveColorPrimary:
            Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.inventory_2_outlined, size: iconSize),
        textStyle: labelStyle,
        title: l10n.inventory,
        activeColorPrimary:
            Get.find<AppThemeConfig>().getPrimaryColor(Get.isDarkMode),
        inactiveColorPrimary:
            Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings, size: iconSize),
        textStyle: labelStyle,
        title: l10n.settings,
        activeColorPrimary:
            Get.find<AppThemeConfig>().getPrimaryColor(Get.isDarkMode),
        inactiveColorPrimary:
            Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
      ),
    ];
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
