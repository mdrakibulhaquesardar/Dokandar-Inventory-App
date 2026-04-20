import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../utils/vibration_helper.dart';

/// UI-only controller for backup/restore screens in the UI kit.
///
/// No real backup or restore logic is performed – all actions
/// simply update observable state for demonstration purposes.
class DataManagementController extends GetxController {
  final backupProgress = 0.0.obs;
  final backupStatus = ''.obs;
  final isBackingUp = false.obs;
  final lastBackupDate = ''.obs;
  final isInitialized = true.obs;

  final restoreProgress = 0.0.obs;
  final restoreStatus = ''.obs;
  final isRestoring = false.obs;

  Future<void> startBackup() async {
    if (isBackingUp.value) return;
    try {
      isBackingUp.value = true;
      backupProgress.value = 0.0;
      final l10n = AppLocalizations.of(Get.context!)!;
      backupStatus.value = l10n.backingUp;

      await Future.delayed(const Duration(seconds: 1));
      backupProgress.value = 1.0;
      backupStatus.value = l10n.backupSuccess;
      lastBackupDate.value = DateTime.now().toIso8601String();
      VibrationHelper.onSuccess();
    } catch (e) {
      debugPrint('Error in demo backup: $e');
      final l10n = AppLocalizations.of(Get.context!)!;
      backupStatus.value = l10n.backupFailed(e.toString());
    } finally {
      isBackingUp.value = false;
    }
  }

  Future<void> startRestore() async {
    if (isRestoring.value) return;
    try {
      isRestoring.value = true;
      restoreProgress.value = 0.0;
      final l10n = AppLocalizations.of(Get.context!)!;
      restoreStatus.value = l10n.restoring;

      await Future.delayed(const Duration(seconds: 1));
      restoreProgress.value = 1.0;
      restoreStatus.value = l10n.restoreSuccess;
      VibrationHelper.onSuccess();
    } catch (e) {
      debugPrint('Error in demo restore: $e');
      final l10n = AppLocalizations.of(Get.context!)!;
      restoreStatus.value = l10n.restoreFailed(e.toString());
    } finally {
      isRestoring.value = false;
    }
  }
}
