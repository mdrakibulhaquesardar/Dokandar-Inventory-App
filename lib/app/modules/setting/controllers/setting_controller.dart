import 'package:dokandar_app_inventory/app/data/models/store.dart';
import 'package:dokandar_app_inventory/app/data/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';

class SettingController extends GetxController {
  User? user;

  Store? store;

  void getUserInfo() async {
    if (!Get.isRegistered<DatabaseService>()) return;
    user = await Get.find<DatabaseService>().getUser();
    if (user != null) {
      debugPrint("User found: ${user!.name}");
    } else {
      debugPrint("No user found");
    }
  }

  void getStoreInfo() async {
    if (!Get.isRegistered<DatabaseService>()) return;
    store = await Get.find<DatabaseService>().getStore();
    if (store != null) {
      if (kDebugMode) {
        debugPrint("Store found: ${store!.name}");
      }
    } else {
      if (kDebugMode) {
        debugPrint("No store found");
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getStoreInfo();
  }

  Future<void> updateStore(Store updated) async {
    if (!Get.isRegistered<DatabaseService>()) return;
    await Get.find<DatabaseService>().updateStore(updated);
    store = updated;
    update();
  }

  Future<void> updateUser(User updated) async {
    if (!Get.isRegistered<DatabaseService>()) return;
    await Get.find<DatabaseService>().saveUser(updated);
    user = updated;
    update();
  }
}
