import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../services/backup_service.dart';
import '../../config/app_config.dart';

class AutoBackupService extends GetxService {
  Timer? _backupTimer;
  final BackupService _backupService = Get.find<BackupService>();
  final AppConfig _appConfig = Get.find<AppConfig>();

  bool _isBackingUp = false;

  @override
  void onInit() {
    super.onInit();
    _startAutoBackupTimer();
    // Listen to auto backup setting changes
    ever(_appConfig.autoBackupEnabled, (enabled) {
      if (enabled) {
        _startAutoBackupTimer();
      } else {
        _stopAutoBackupTimer();
      }
    });
  }

  @override
  void onClose() {
    _stopAutoBackupTimer();
    super.onClose();
  }

  void _startAutoBackupTimer() {
    _stopAutoBackupTimer(); // Stop existing timer if any

    if (!_appConfig.autoBackupEnabled.value) {
      return;
    }

    // Check every hour if backup is needed
    _backupTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => _checkAndPerformBackup(),
    );

    // Also check immediately when timer starts
    _checkAndPerformBackup();
  }

  void _stopAutoBackupTimer() {
    _backupTimer?.cancel();
    _backupTimer = null;
  }

  Future<void> _checkAndPerformBackup() async {
    // Don't backup if already backing up or auto backup is disabled
    if (_isBackingUp || !_appConfig.autoBackupEnabled.value) {
      return;
    }

    try {
      // Get last backup date
      final lastBackupDate = await _backupService.getLastBackupDate();
      final now = DateTime.now();

      // Check if backup is needed
      bool shouldBackup = false;

      if (lastBackupDate == null) {
        // No backup exists, create one
        shouldBackup = true;
      } else {
        // Check if backup frequency has passed
        final hoursSinceLastBackup =
            now.difference(lastBackupDate).inHours;
        if (hoursSinceLastBackup >= AppConfig.backupFrequency) {
          shouldBackup = true;
        }
      }

      if (shouldBackup) {
        await _performAutoBackup();
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error checking backup: $e');
      }
    }
  }

  Future<void> _performAutoBackup() async {
    if (_isBackingUp) return;

    _isBackingUp = true;
    try {
      if (kDebugMode) {
        debugPrint('Starting automatic backup...');
      }

      // Perform backup
      await _backupService.exportIsarToFile();

      // Clean up old backup files
      await _cleanupOldBackups();

      if (kDebugMode) {
        debugPrint('Automatic backup completed successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error during automatic backup: $e');
      }
    } finally {
      _isBackingUp = false;
    }
  }

  Future<void> _cleanupOldBackups() async {
    try {
      final backupDir = await _backupService.getExportDirectory();
      if (backupDir == null) return;

      final files = await backupDir
          .list()
          .where((entity) => entity is File && entity.path.endsWith('.json'))
          .cast<File>()
          .toList();

      if (files.length <= AppConfig.maxBackupFiles) {
        return; // No cleanup needed
      }

      // Sort by modification date (newest first)
      files.sort((a, b) {
        final aModified = a.statSync().modified;
        final bModified = b.statSync().modified;
        return bModified.compareTo(aModified);
      });

      // Delete oldest files
      final filesToDelete = files.skip(AppConfig.maxBackupFiles).toList();
      for (final file in filesToDelete) {
        try {
          await file.delete();
          if (kDebugMode) {
            debugPrint('Deleted old backup file: ${file.path}');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Error deleting backup file ${file.path}: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error cleaning up old backups: $e');
      }
    }
  }

  // Manual trigger for immediate backup (can be called from UI)
  Future<bool> performBackupNow() async {
    if (_isBackingUp) {
      return false;
    }

    await _performAutoBackup();
    return true;
  }
}

