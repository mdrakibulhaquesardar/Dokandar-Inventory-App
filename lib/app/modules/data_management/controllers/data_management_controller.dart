import 'package:dokandar_app_inventory/app/core/services/backup_service.dart';
import 'package:dokandar_app_inventory/app/core/services/database_service.dart';
import 'package:get/get.dart';

class DataManagementController extends GetxController {
  final DatabaseService databaseService = Get.find<DatabaseService>();
  late final BackupService backupService;

  final backupProgress = 0.0.obs;
  final backupStatus = ''.obs;
  final isBackingUp = false.obs;
  final lastBackupDate = ''.obs;
  final isInitialized = false.obs;

  // Restore related observables
  final restoreProgress = 0.0.obs;
  final restoreStatus = ''.obs;
  final isRestoring = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      backupService = await BackupService().init(databaseService.isar);
      isInitialized.value = true;
      await _loadLastBackupDate();
      await backupService.requestStoragePermission();
    } catch (e) {
      print('Error initializing services: $e');
      backupStatus.value = 'সেবা শুরু করতে ব্যর্থ: $e';
    }
  }

  Future<void> _loadLastBackupDate() async {
    try {
      final lastBackup = await backupService.getLastBackupDate();
      if (lastBackup != null) {
        lastBackupDate.value =
            '${lastBackup.year}-${lastBackup.month.toString().padLeft(2, '0')}-${lastBackup.day.toString().padLeft(2, '0')}';
      } else {
        lastBackupDate.value = '';
      }
    } catch (e) {
      print('Error loading last backup date: $e');
      lastBackupDate.value = '';
    }
  }

  Future<void> startBackup() async {
    if (isBackingUp.value || !isInitialized.value) return;

    try {
      isBackingUp.value = true;
      backupProgress.value = 0.0;
      backupStatus.value = 'ব্যাকআপ করা হচ্ছে...';

      // Start actual backup
      await backupService.exportIsarToFile();

      // Update progress
      backupProgress.value = 1.0;
      backupStatus.value = 'ব্যাকআপ সফল হয়েছে!';

      // Update last backup date
      await _loadLastBackupDate();
    } catch (e) {
      backupStatus.value = 'ব্যাকআপ ব্যর্থ হয়েছে: $e';
    } finally {
      isBackingUp.value = false;
    }
  }

  Future<void> startRestore() async {
    if (isRestoring.value || !isInitialized.value) return;

    try {
      isRestoring.value = true;
      restoreProgress.value = 0.0;
      restoreStatus.value = 'পুনরুদ্ধার করা হচ্ছে...';

      await backupService.getLastBackupDate();

      // Start actual restore
      await backupService.importIsarFromFile();

      // Update progress
      restoreProgress.value = 1.0;
      restoreStatus.value = 'পুনরুদ্ধার সফল হয়েছে!';
    } catch (e) {
      restoreStatus.value = 'পুনরুদ্ধার ব্যর্থ হয়েছে: $e';
    } finally {
      isRestoring.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
