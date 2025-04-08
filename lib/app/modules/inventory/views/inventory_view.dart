import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/inventory_controller.dart';

class InventoryView extends GetView<InventoryController> {
  const InventoryView({super.key});
  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('InventoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InventoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    
    );
  }
}
