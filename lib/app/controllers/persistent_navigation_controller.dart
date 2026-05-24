import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/home/views/home_view.dart';
import '../modules/inventory/views/inventory_view.dart';
import '../modules/sell/views/sell_view.dart';
import '../modules/setting/views/setting_view.dart';

class PersistentNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  List<Widget> buildScreens() {
    return [
      const HomeView(),
      const InventoryView(),
      const SellView(),
      const SettingView(),
    ];
  }
}
