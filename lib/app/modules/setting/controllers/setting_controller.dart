import 'package:dokandar_app_inventory/app/data/models/store.dart';
import 'package:dokandar_app_inventory/app/data/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';

class SettingController extends GetxController {

  User? user;

  Store? store;

  void getUserInfo() async {
    user = await Get.find<DatabaseService>().getUser();
    if (user != null) {
      print("User found: ${user!.name}");
    } else {
      print("No user found");
    }
  }
  void getStoreInfo() async {
    store = await Get.find<DatabaseService>().getStore();
    if (store != null) {
      if (kDebugMode) {
        print("Store found: ${store!.name}");
      }
    } else {
      if (kDebugMode) {
        print("No store found");
      }
    }
  }




  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getStoreInfo();
  }



}
