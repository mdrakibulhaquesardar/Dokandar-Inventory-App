import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventory/views/inventory_view.dart';
import '../modules/setting/views/setting_view.dart';

class PersistentNavigationController extends GetxController {
  late PersistentTabController tabController;
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = PersistentTabController(initialIndex: 0);
  }

  List<Widget> buildScreens() {
    return [
      const HomeView(),
      const InventoryView(),
      const SettingView(),
    ];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'হোম',
        activeColorPrimary: Get.find<AppThemeConfig>().getPrimaryColor(Get.isDarkMode),
        inactiveColorPrimary: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.inventory),
        title: 'ইনভেন্টরি',
        activeColorPrimary: Get.find<AppThemeConfig>().getPrimaryColor(Get.isDarkMode),
        inactiveColorPrimary: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: 'সেটিং',
        activeColorPrimary: Get.find<AppThemeConfig>().getPrimaryColor(Get.isDarkMode),
        inactiveColorPrimary: Get.isDarkMode ? Colors.grey[300] : Colors.grey[600],
      ),
    ];
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}