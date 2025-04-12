

import 'package:dokandar_app_inventory/app/data/services/database_service.dart';
import 'package:get/get.dart';


class DataManagementController extends GetxController {
  //TODO: Implement DataManagementController

  DatabaseService databaseService = Get.find<DatabaseService>();


  final backupProgress = 0.0.obs;
  //backupStatus
  final backupStatus = ''.obs;

  void startBackup() {
    // Simulate a backup process
    backupProgress.value = 0.0;
    backupStatus.value = 'Backing up...';

    // Simulate progress
    for (int i = 1; i <= 100; i++) {
      Future.delayed(Duration(milliseconds: i * 50), () {
        backupProgress.value = i / 100;
        if (i == 100) {
          backupStatus.value = 'Backup completed!';
        }
      });
    }
  }












  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


}
