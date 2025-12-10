import 'package:dokandar_app_inventory/app/core/services/backup_service.dart';
import 'package:dokandar_app_inventory/app/core/services/database_service.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../utils/vibration_helper.dart';

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
      debugPrint('Error initializing services: $e');
      final l10n = AppLocalizations.of(Get.context!)!;
      backupStatus.value = l10n.serviceInitFailed(e.toString());
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
      debugPrint('Error loading last backup date: $e');
      lastBackupDate.value = '';
    }
  }

  Future<void> startBackup() async {
    if (isBackingUp.value || !isInitialized.value) return;

    try {
      isBackingUp.value = true;
      backupProgress.value = 0.0;
      final l10n = AppLocalizations.of(Get.context!)!;
      backupStatus.value = l10n.backingUp;

      // Start actual backup
      await backupService.exportIsarToFile();

      // Update progress
      backupProgress.value = 1.0;
      backupStatus.value = l10n.backupSuccess;
      VibrationHelper.onSuccess();

      // Update last backup date
      await _loadLastBackupDate();
    } catch (e) {
      final l10n = AppLocalizations.of(Get.context!)!;
      backupStatus.value = l10n.backupFailed(e.toString());
    } finally {
      isBackingUp.value = false;
    }
  }

  Future<void> startRestore() async {
    if (isRestoring.value || !isInitialized.value) return;

    try {
      isRestoring.value = true;
      restoreProgress.value = 0.0;
      final l10n = AppLocalizations.of(Get.context!)!;
      restoreStatus.value = l10n.restoring;

      await backupService.getLastBackupDate();

      // Start actual restore
      await backupService.importIsarFromFile();

      // Update progress
      restoreProgress.value = 1.0;
      restoreStatus.value = l10n.restoreSuccess;
      VibrationHelper.onSuccess();
    } catch (e) {
      final l10n = AppLocalizations.of(Get.context!)!;
      restoreStatus.value = l10n.restoreFailed(e.toString());
    } finally {
      isRestoring.value = false;
    }
  }

}
