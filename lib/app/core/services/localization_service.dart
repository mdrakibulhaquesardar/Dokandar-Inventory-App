import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/app_config.dart';

/// LocalizationService - Manages app localization and language changes
/// 
/// This service handles:
/// - Loading and saving language preferences
/// - Changing app locale dynamically
/// - Integration with AppConfig for default language settings
class LocalizationService extends GetxService {
  late SharedPreferences _prefs;
  final Rx<Locale> currentLocale = const Locale('bn', '').obs;

  /// Initialize the localization service
  Future<LocalizationService> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadLanguagePreference();
    return this;
  }

  /// Load saved language preference from storage
  Future<void> _loadLanguagePreference() async {
    final savedLanguage = _prefs.getString('app_language');
    if (savedLanguage != null && AppConfig.availableLanguages.containsKey(savedLanguage)) {
      currentLocale.value = Locale(savedLanguage, '');
    } else {
      // Use default language from AppConfig
      currentLocale.value = Locale(AppConfig.defaultLanguage, '');
    }
  }

  /// Change app language
  /// 
  /// [languageCode] - Language code (e.g., 'bn', 'en')
  /// Returns true if language was changed successfully
  Future<bool> changeLanguage(String languageCode) async {
    if (!AppConfig.availableLanguages.containsKey(languageCode)) {
      return false;
    }

    try {
      await _prefs.setString('app_language', languageCode);
      final newLocale = Locale(languageCode, '');
      currentLocale.value = newLocale;
      
      // Update GetX locale - this will trigger app rebuild
      Get.updateLocale(newLocale);
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get current language code
  String get currentLanguageCode => currentLocale.value.languageCode;

  /// Get current language display name
  String get currentLanguageName {
    return AppConfig.availableLanguages[currentLanguageCode] ?? 
           AppConfig.availableLanguages[AppConfig.defaultLanguage]!;
  }

  /// Get all available languages
  Map<String, String> get availableLanguages => AppConfig.availableLanguages;

  /// Check if multi-language is enabled
  bool get isMultiLanguageEnabled => AppConfig.enableMultiLanguage;

  /// Reset to default language
  Future<void> resetToDefault() async {
    await changeLanguage(AppConfig.defaultLanguage);
  }
}

