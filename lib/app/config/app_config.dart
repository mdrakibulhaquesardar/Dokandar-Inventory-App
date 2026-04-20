import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AppConfig - Centralized Configuration Class
///
/// This class contains all app configuration settings that can be easily customized
/// by CodeCanyon buyers. Simply modify the values below to customize your app.
///
/// IMPORTANT FOR CODECANYON USERS:
/// - Change all "Your Company Name", "support@example.com", etc. to your own information
/// - Modify subscription plans, limits, and features according to your needs
/// - Update theme colors, currency settings, and other configurations
/// - All changes made here will be reflected throughout the entire app
class AppConfig extends GetxService {
  // ============================================================================
  // APP INFORMATION - Customize these values for your app
  // ============================================================================
  static const String appVersion = '১.০.১';
  static const String appName = 'দোকানদার (Dokandar)';
  static const String lastUpdate = 'এপ্রিল ২০, ২০২৫';
  static const String appSize = '৩০ MB';
  static const String appDescription = 'ইনভেন্টরি ম্যানেজমেন্ট সিস্টেম';

  // Developer/Company Information - CHANGE THESE FOR YOUR COMPANY
  static const String developerName = 'Your Company Name';
  static const String supportEmail = 'support@example.com';
  static const String website = 'https://example.com';

  // ============================================================================
  // APP FEATURES CONFIGURATION - Enable/Disable features
  // ============================================================================
  /// Set to true to enable subscription features in the app
  static const bool enableSubscription = false;

  /// Set to true to enable dark mode support
  static const bool enableDarkMode = true;

  /// Set to true to enable push notifications
  static const bool enableNotifications = false;

  /// Set to true to enable data backup functionality
  static const bool enableBackup = true;

  /// Set to true to enable analytics tracking
  static const bool enableAnalytics = true;

  /// Set to true to enable multi-language support
  static const bool enableMultiLanguage = true;

  /// Set to true to show language selection in settings
  static const bool enableMultiLanguageSupport = true;

  /// Set to true for personal use (hides support/feedback options)
  static const bool enablePersonalUse = true;

  // ============================================================================
  // SUBSCRIPTION CONFIGURATION - Configure subscription limits and plans
  // ============================================================================
  /// Maximum number of products allowed in free plan
  static const int freePlanProductLimit = 10;

  /// Maximum number of customers allowed in free plan
  static const int freePlanCustomerLimit = 5;

  /// Trial period duration in days
  static const int trialPeriodDays = 7;

  /// Low stock threshold - Products below this quantity will be marked as low stock
  static const int lowStockThreshold = 10;
  static const Map<String, Map<String, dynamic>> subscriptionPlans = {
    'monthly': {
      'name': '1 Month',
      'price': '৳99',
      'perMonth': '৳99/month',
      'savePercentage': null,
      'expiryDate': 'April 2025',
      'features': ['Access to basic features and support.'],
    },
    'quarterly': {
      'name': '3 Months',
      'price': '৳299',
      'perMonth': '৳99/month',
      'savePercentage': 15,
      'expiryDate': 'July 2025',
      'features': ['Access to basic features and support.'],
    },
    'halfYearly': {
      'name': '6 Months',
      'price': '৳599',
      'perMonth': '৳99/month',
      'savePercentage': 25,
      'expiryDate': 'October 2025',
      'features': ['Includes premium features and priority support.'],
    },
  };

  // ============================================================================
  // DATABASE CONFIGURATION - Database settings
  // ============================================================================
  /// Database name - Change this if you want a different database name
  static const String databaseName = 'dokandar_db';

  /// Database version - Increment this when you make schema changes
  static const int databaseVersion = 1;

  /// Enable database encryption (if supported)
  static const bool enableDatabaseEncryption = true;

  // ============================================================================
  // API CONFIGURATION - Backend API settings (if using remote API)
  // ============================================================================
  /// Base URL for API endpoints - CHANGE THIS TO YOUR API URL
  static const String baseUrl = 'https://api.example.com';

  /// Privacy policy URL (used in Settings -> Support & Help)
  static const String privacyPolicyUrl = 'https://example.com/privacy-policy';

  /// API request timeout in milliseconds
  static const int apiTimeout = 30000; // 30 seconds

  /// Maximum number of retry attempts for failed API calls
  static const int maxRetryAttempts = 3;

  /// Delay between retry attempts in milliseconds
  static const int retryDelay = 1000; // 1 second

  // Theme Configuration
  final RxString currentTheme = 'light'.obs;
  final RxInt currentFontSize = 14.obs;
  static const Map<String, dynamic> themeColors = {
    'primary': 0xFF2196F3,
    'secondary': 0xFF03DAC6,
    // Use a pure white background for the app shell
    'background': 0xFFFFFFFF,
    // Slightly off-white surface so cards and panels
    // are clearly visible in light mode (similar contrast to dark mode)
    'surface': 0xFFF5F5F5,
    'error': 0xFFB00020,
    'onPrimary': 0xFFFFFFFF,
    'onSecondary': 0xFF000000,
    'onBackground': 0xFF000000,
    'onSurface': 0xFF000000,
    'onError': 0xFFFFFFFF,
  };

  // ============================================================================
  // CURRENCY CONFIGURATION - Currency and number formatting
  // ============================================================================
  final RxString currentCurrency = 'BDT'.obs;

  /// Currency symbol to display (e.g., ৳, $, €, ₹)
  static const String currencySymbol = '৳';

  /// Available currencies
  static const Map<String, String> availableCurrencies = {
    'BDT': '৳ BDT (Taka)',
    'USD': '\$ USD (Dollar)',
    'EUR': '€ EUR (Euro)',
    'INR': '₹ INR (Rupee)',
    'GBP': '£ GBP (Pound)',
  };

  /// Currency symbols map
  static const Map<String, String> currencySymbols = {
    'BDT': '৳',
    'USD': '\$',
    'EUR': '€',
    'INR': '₹',
    'GBP': '£',
  };

  /// Get currency symbol for current currency
  String getCurrencySymbol() {
    return currencySymbols[currentCurrency.value] ?? currencySymbol;
  }

  /// Number of decimal places for currency display
  static const int decimalPlaces = 2;

  /// Thousand separator character
  static const String thousandSeparator = ',';

  /// Decimal separator character
  static const String decimalSeparator = '.';

  // Date Format Configuration
  final RxString currentDateFormat = 'dd/MM/yyyy'.obs;
  final RxString currentTimeFormat = 'hh:mm a'.obs;
  static const Map<String, String> dateFormats = {
    'dd/MM/yyyy': 'DD/MM/YYYY',
    'MM/dd/yyyy': 'MM/DD/YYYY',
    'yyyy-MM-dd': 'YYYY-MM-DD',
    'dd-MM-yyyy': 'DD-MM-YYYY',
  };
  static const Map<String, String> timeFormats = {
    'hh:mm a': '12 Hour',
    'HH:mm': '24 Hour',
  };

  // Pagination Configuration
  final RxInt currentPageSize = 20.obs;
  static const List<int> availablePageSizes = [10, 20, 50, 100];

  // App Lock Configuration
  final RxBool pinLockEnabled = false.obs;
  String? _pinSalt;
  String? _pinHash;
  bool _sessionUnlocked = false;
  static const int minPinLength = 4;
  static const int maxPinLength = 8;

  // Cache Configuration
  final RxInt currentCacheDuration = 3600.obs; // 1 hour in seconds
  static const List<int> availableCacheDurations = [
    300,
    900,
    1800,
    3600,
    7200
  ]; // 5min to 2hours

  // Language Configuration
  static const String defaultLanguage = 'bn';
  static const Map<String, String> availableLanguages = {
    'bn': 'বাংলা',
    'en': 'English',
  };

  // ============================================================================
  // FILE UPLOAD CONFIGURATION - File upload settings
  // ============================================================================
  /// Maximum file size in bytes (5MB default)
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB

  /// Allowed file extensions for uploads
  static const List<String> allowedFileTypes = ['jpg', 'jpeg', 'png', 'pdf'];

  /// Directory name for uploaded files
  static const String uploadDirectory = 'uploads';

  // ============================================================================
  // NOTIFICATION CONFIGURATION - Notification settings
  // ============================================================================
  /// Notification display timeout in milliseconds
  static const int notificationTimeout = 5000; // 5 seconds

  /// Enable sound for notifications
  static const bool enableSound = true;

  /// Enable vibration for notifications
  static const bool enableVibration = true;

  // ============================================================================
  // BACKUP CONFIGURATION - Data backup settings
  // ============================================================================
  /// Enable automatic backups
  static const bool enableAutoBackup = true;

  /// Backup frequency in hours
  static const int backupFrequency = 24; // hours

  /// Maximum number of backup files to keep
  static const int maxBackupFiles = 5;

  // ============================================================================
  // ANALYTICS CONFIGURATION - Analytics and tracking settings
  // ============================================================================
  /// Enable user behavior tracking
  static const bool enableUserTracking = true;

  /// Enable error reporting
  static const bool enableErrorReporting = true;

  /// Enable performance monitoring
  static const bool enablePerformanceMonitoring = true;

  late SharedPreferences _prefs;

  // ============================================================================
  // GETTERS - Access app information throughout the app
  // ============================================================================
  String get appCurrentVersion => appVersion;
  String get appCurrentName => appName;
  String get appLastUpdate => lastUpdate;
  String get appCurrentSize => appSize;
  String get appCurrentDescription => appDescription;
  String get appDeveloperName => developerName;
  String get appSupportEmail => supportEmail;
  String get appWebsite => website;

  // ============================================================================
  // CHANGE LOG - Update this with each version release
  // ============================================================================
  /// Change log entries - Update this list with each app version
  static const List<String> changeLog = [
    'first version release',
    'basic features added',
    'inventory management system',
    'sales tracking system',
    'customer management system',
    'employee management system',
    'expense management system',
    'report management system',
    'settings management system',
    'user management system',
    'role management system',
  ];
  List<String> get appChangeLog => changeLog;

  // ============================================================================
  // SUBSCRIPTION PLANS GETTERS - Access subscription plan data
  // ============================================================================
  /// Get all subscription plans
  Map<String, Map<String, dynamic>> get subscriptionPlansData =>
      subscriptionPlans;

  /// Get monthly plan details
  Map<String, dynamic>? get monthlyPlan => subscriptionPlans['monthly'];

  /// Get quarterly plan details
  Map<String, dynamic>? get quarterlyPlan => subscriptionPlans['quarterly'];

  /// Get half-yearly plan details
  Map<String, dynamic>? get halfYearlyPlan => subscriptionPlans['halfYearly'];

  /// Get free plan product limit
  int get freeProductLimit => freePlanProductLimit;

  /// Get free plan customer limit
  int get freeCustomerLimit => freePlanCustomerLimit;

  /// Get trial period days
  int get trialDays => trialPeriodDays;

  /// Get low stock threshold
  int get lowStockLimit => lowStockThreshold;

  // Initialize the configuration
  Future<AppConfig> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadAllPreferences();
    return this;
  }

  // Load all preferences from storage
  Future<void> _loadAllPreferences() async {
    await Future.wait([
      _loadThemePreferences(),
      _loadFontPreferences(),
      _loadCurrencyPreferences(),
      _loadDateFormatPreferences(),
      _loadPaginationPreferences(),
      _loadCachePreferences(),
      _loadNotificationPreferences(),
      _loadLockPreferences(),
    ]);
  }

  // Theme preferences
  Future<void> _loadThemePreferences() async {
    currentTheme.value = _prefs.getString('theme') ?? defaultTheme;
  }

  Future<void> saveTheme(String theme) async {
    currentTheme.value = theme;
    await _prefs.setString('theme', theme);
  }

  // Font preferences
  Future<void> _loadFontPreferences() async {
    currentFontSize.value = _prefs.getInt('fontSize') ?? defaultFontSize;
  }

  Future<void> saveFontSize(int size) async {
    currentFontSize.value = size;
    await _prefs.setInt('fontSize', size);
  }

  // Currency preferences
  Future<void> _loadCurrencyPreferences() async {
    currentCurrency.value = _prefs.getString('currency') ?? defaultCurrency;
  }

  // ============================================================================
  // HELPER METHODS - Utility methods for configuration
  // ============================================================================

  /// Format currency amount with symbol
  String formatCurrency(double amount) {
    final formatted = amount.toStringAsFixed(decimalPlaces);
    final symbol = getCurrencySymbol();
    return '$symbol$formatted';
  }

  /// Check if subscription is enabled
  bool get isSubscriptionEnabled => enableSubscription;

  /// Check if dark mode is enabled
  bool get isDarkModeEnabled => enableDarkMode;

  /// Check if backup is enabled
  bool get isBackupEnabled => enableBackup;

  /// Check if notifications are enabled
  bool get isNotificationsEnabled => enableNotifications;

  /// Get database name
  String get dbName => databaseName;

  /// Get database version
  int get dbVersion => databaseVersion;

  Future<void> saveCurrency(String currency) async {
    currentCurrency.value = currency;
    await _prefs.setString('currency', currency);
  }

  // Date format preferences
  Future<void> _loadDateFormatPreferences() async {
    currentDateFormat.value = _prefs.getString('dateFormat') ?? dateFormat;
    currentTimeFormat.value = _prefs.getString('timeFormat') ?? timeFormat;
  }

  Future<void> saveDateFormat(String format) async {
    currentDateFormat.value = format;
    await _prefs.setString('dateFormat', format);
  }

  Future<void> saveTimeFormat(String format) async {
    currentTimeFormat.value = format;
    await _prefs.setString('timeFormat', format);
  }

  // Pagination preferences
  Future<void> _loadPaginationPreferences() async {
    currentPageSize.value = _prefs.getInt('pageSize') ?? defaultPageSize;
  }

  Future<void> savePageSize(int size) async {
    currentPageSize.value = size;
    await _prefs.setInt('pageSize', size);
  }

  // Cache preferences
  Future<void> _loadCachePreferences() async {
    currentCacheDuration.value =
        _prefs.getInt('cacheDuration') ?? cacheDuration;
  }

  Future<void> saveCacheDuration(int duration) async {
    currentCacheDuration.value = duration;
    await _prefs.setInt('cacheDuration', duration);
  }

  // Lock preferences
  Future<void> _loadLockPreferences() async {
    pinLockEnabled.value = _prefs.getBool('pinLockEnabled') ?? false;
    _pinSalt = _prefs.getString('pinSalt');
    _pinHash = _prefs.getString('pinHash');
  }

  bool get isPinLockEnabled =>
      pinLockEnabled.value && _pinSalt != null && _pinHash != null;

  bool get isSessionUnlocked => _sessionUnlocked;

  Future<void> savePin(String pin) async {
    final salt = _generateSalt();
    final hash = _hashPin(pin, salt);
    _pinSalt = salt;
    _pinHash = hash;
    pinLockEnabled.value = true;
    await Future.wait([
      _prefs.setBool('pinLockEnabled', true),
      _prefs.setString('pinSalt', salt),
      _prefs.setString('pinHash', hash),
    ]);
  }

  Future<void> disablePinLock() async {
    pinLockEnabled.value = false;
    _pinSalt = null;
    _pinHash = null;
    _sessionUnlocked = false;
    await Future.wait([
      _prefs.remove('pinLockEnabled'),
      _prefs.remove('pinSalt'),
      _prefs.remove('pinHash'),
    ]);
  }

  Future<bool> verifyPin(String pin) async {
    if (_pinSalt == null || _pinHash == null) return false;
    final computed = _hashPin(pin, _pinSalt!);
    final match = computed == _pinHash;
    if (match) {
      _sessionUnlocked = true;
    }
    return match;
  }

  void markSessionUnlocked() {
    _sessionUnlocked = true;
  }

  String _hashPin(String pin, String salt) {
    final bytes = utf8.encode('$salt$pin');
    return sha256.convert(bytes).toString();
  }

  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  // Notification preferences
  final RxBool notificationsEnabled = true.obs;
  final RxBool autoBackupEnabled = true.obs;
  final RxBool soundEnabled = true.obs;
  final RxBool vibrationEnabled = true.obs;

  Future<void> _loadNotificationPreferences() async {
    notificationsEnabled.value =
        _prefs.getBool('notificationsEnabled') ?? enableNotifications;
    autoBackupEnabled.value =
        _prefs.getBool('autoBackupEnabled') ?? enableAutoBackup;
    soundEnabled.value = _prefs.getBool('soundEnabled') ?? enableSound;
    vibrationEnabled.value =
        _prefs.getBool('vibrationEnabled') ?? enableVibration;
  }

  Future<void> saveNotificationsEnabled(bool enabled) async {
    notificationsEnabled.value = enabled;
    await _prefs.setBool('notificationsEnabled', enabled);
  }

  Future<void> saveAutoBackupEnabled(bool enabled) async {
    autoBackupEnabled.value = enabled;
    await _prefs.setBool('autoBackupEnabled', enabled);
  }

  Future<void> saveSoundEnabled(bool enabled) async {
    soundEnabled.value = enabled;
    await _prefs.setBool('soundEnabled', enabled);
  }

  Future<void> saveVibrationEnabled(bool enabled) async {
    vibrationEnabled.value = enabled;
    await _prefs.setBool('vibrationEnabled', enabled);
  }

  Future<void> clearCache() async {
    // Clear cache-related preferences
    await _prefs.remove('cacheDuration');
    currentCacheDuration.value = cacheDuration;
  }

  Future<void> resetAllSettings() async {
    // Reset all preferences to default
    await saveTheme(defaultTheme);
    await saveFontSize(defaultFontSize);
    await saveCurrency(defaultCurrency);
    await saveDateFormat(dateFormat);
    await saveTimeFormat(timeFormat);
    await savePageSize(defaultPageSize);
    await saveCacheDuration(cacheDuration);
    await saveNotificationsEnabled(enableNotifications);
    await saveAutoBackupEnabled(enableAutoBackup);
    await saveSoundEnabled(enableSound);
    await saveVibrationEnabled(enableVibration);
  }

  // Date formatting methods
  String getFormattedDate(DateTime date) {
    final format = currentDateFormat.value;

    switch (format) {
      case 'dd/MM/yyyy':
        return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
      case 'MM/dd/yyyy':
        return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
      case 'yyyy-MM-dd':
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      case 'dd-MM-yyyy':
        return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
      default:
        return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

  String getFormattedTime(DateTime time) {
    final format = currentTimeFormat.value;

    if (format == 'HH:mm') {
      // 24-hour format
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      // 12-hour format (hh:mm a)
      final hour12 =
          time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
      final amPm = time.hour < 12 ? 'AM' : 'PM';
      return '${hour12.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $amPm';
    }
  }

  // Static constants
  static const String defaultTheme = 'light';
  static const int defaultFontSize = 14;
  static const String defaultCurrency = 'BDT';
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'hh:mm a';
  static const int defaultPageSize = 20;
  static const int cacheDuration = 3600;
}
