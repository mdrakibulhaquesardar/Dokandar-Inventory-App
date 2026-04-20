import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../config/app_config.dart';

class VibrationHelper {
  /// Trigger vibration if enabled in settings
  static void vibrate({HapticFeedbackType type = HapticFeedbackType.light}) {
    try {
      final appConfig = Get.find<AppConfig>();
      if (!appConfig.vibrationEnabled.value) {
        if (kDebugMode) {
          debugPrint('VibrationHelper: Vibration is disabled in settings');
        }
        return; // Vibration disabled
      }

      if (kDebugMode) {
        debugPrint('VibrationHelper: Triggering ${type.name} vibration');
      }

      switch (type) {
        case HapticFeedbackType.light:
          HapticFeedback.lightImpact();
          break;
        case HapticFeedbackType.medium:
          HapticFeedback.mediumImpact();
          break;
        case HapticFeedbackType.heavy:
          HapticFeedback.heavyImpact();
          break;
        case HapticFeedbackType.selection:
          HapticFeedback.selectionClick();
          break;
      }
    } catch (e) {
      // If AppConfig not available, try to vibrate anyway
      if (kDebugMode) {
        debugPrint('VibrationHelper: Error accessing AppConfig: $e');
        debugPrint('VibrationHelper: Attempting vibration without settings check');
      }
      
      // Try to vibrate even if AppConfig is not available
      try {
        switch (type) {
          case HapticFeedbackType.light:
            HapticFeedback.lightImpact();
            break;
          case HapticFeedbackType.medium:
            HapticFeedback.mediumImpact();
            break;
          case HapticFeedbackType.heavy:
            HapticFeedback.heavyImpact();
            break;
          case HapticFeedbackType.selection:
            HapticFeedback.selectionClick();
            break;
        }
      } catch (vibrationError) {
        if (kDebugMode) {
          debugPrint('VibrationHelper: Failed to trigger vibration: $vibrationError');
        }
      }
    }
  }

  /// Vibrate on button tap (light impact)
  static void onButtonTap() {
    vibrate(type: HapticFeedbackType.light);
  }

  /// Vibrate on important action (medium impact)
  static void onImportantAction() {
    vibrate(type: HapticFeedbackType.medium);
  }

  /// Vibrate on success action (light impact)
  static void onSuccess() {
    vibrate(type: HapticFeedbackType.light);
  }

  /// Vibrate on error action (heavy impact)
  static void onError() {
    vibrate(type: HapticFeedbackType.heavy);
  }

  /// Vibrate on selection (selection click)
  static void onSelection() {
    vibrate(type: HapticFeedbackType.selection);
  }

  /// Force vibration (bypass settings check) - for testing
  static void forceVibrate({HapticFeedbackType type = HapticFeedbackType.light}) {
    if (kDebugMode) {
      debugPrint('VibrationHelper: Force vibrating with ${type.name}');
    }
    
    try {
      switch (type) {
        case HapticFeedbackType.light:
          HapticFeedback.lightImpact();
          break;
        case HapticFeedbackType.medium:
          HapticFeedback.mediumImpact();
          break;
        case HapticFeedbackType.heavy:
          HapticFeedback.heavyImpact();
          break;
        case HapticFeedbackType.selection:
          HapticFeedback.selectionClick();
          break;
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('VibrationHelper: Force vibration failed: $e');
      }
    }
  }
}

enum HapticFeedbackType {
  light,
  medium,
  heavy,
  selection,
}

