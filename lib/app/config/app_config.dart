import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends GetxService {
  // App Information
  static const String appVersion = '১.০.১';
  static const String appName = 'দোকানদার (Dokandar)';
  static const String lastUpdate = 'এপ্রিল ২০, ২০২৫';
  static const String appSize = '৩০ MB';
  static const String appDescription = 'ইনভেন্টরি ম্যানেজমেন্ট সিস্টেম';
  static const String developerName = 'Your Company Name';
  static const String supportEmail = 'support@example.com';
  static const String website = 'https://example.com';

  // App Features Configuration
  static const bool enableSubscription = true;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableBackup = true;
  static const bool enableAnalytics = true;
  static const bool enableMultiLanguage = true;
  static const bool enableMultiLanguageSupport = false;
  static const bool enablePersonalUse = true;


  

  // Subscription Configuration
  static const int freePlanProductLimit = 10;
  static const int freePlanCustomerLimit = 5;
  static const int trialPeriodDays = 7;
  static const Map<String, Map<String, dynamic>> subscriptionPlans = {
    'monthly': {
      'name': '১ মাস',
      'price': '৳৯৯',
      'perMonth': '৳৯৯/মাস',
      'savePercentage': null,
      'expiryDate': 'এপ্রিল ২০২৫',
      'features': ['Access to basic features and support.'],
    },
    'quarterly': {
      'name': '৩ মাস',
      'price': '৳২৯৯',
      'perMonth': '৳৯৯/মাস',
      'savePercentage': 15,
      'expiryDate': 'জুলাই ২০২৫',
      'features': ['Access to basic features and support.'],
    },
    'halfYearly': {
      'name': '৬ মাস',
      'price': '৳৫৯৯',
      'perMonth': '৳৯৯/মাস',
      'savePercentage': 25,
      'expiryDate': 'অক্টোবর ২০২৫',
      'features': ['Includes premium features and priority support.'],
    },
  };

  // Database Configuration
  static const String databaseName = 'dokandar_db';
  static const int databaseVersion = 1;
  static const bool enableDatabaseEncryption = true;

  // API Configuration
  static const String baseUrl = 'https://api.example.com';
  static const int apiTimeout = 30000; // 30 seconds
  static const int maxRetryAttempts = 3;
  static const int retryDelay = 1000; // 1 second

  // Theme Configuration
  final RxString currentTheme = 'light'.obs;
  final RxInt currentFontSize = 14.obs;
  static const Map<String, dynamic> themeColors = {
    'primary': 0xFF2196F3,
    'secondary': 0xFF03DAC6,
    'background': 0xFFFFFFFF,
    'surface': 0xFFFFFFFF,
    'error': 0xFFB00020,
    'onPrimary': 0xFFFFFFFF,
    'onSecondary': 0xFF000000,
    'onBackground': 0xFF000000,
    'onSurface': 0xFF000000,
    'onError': 0xFFFFFFFF,
  };

  // Currency Configuration
  final RxString currentCurrency = 'BDT'.obs;
  static const String currencySymbol = '৳';
  static const int decimalPlaces = 2;
  static const String thousandSeparator = ',';
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

  // File Upload Configuration
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedFileTypes = ['jpg', 'jpeg', 'png', 'pdf'];
  static const String uploadDirectory = 'uploads';

  // Notification Configuration
  static const int notificationTimeout = 5000; // 5 seconds
  static const bool enableSound = true;
  static const bool enableVibration = true;

  // Backup Configuration
  static const bool enableAutoBackup = true;
  static const int backupFrequency = 24; // hours
  static const int maxBackupFiles = 5;

  // Analytics Configuration
  static const bool enableUserTracking = true;
  static const bool enableErrorReporting = true;
  static const bool enablePerformanceMonitoring = true;

  late SharedPreferences _prefs;

  // Getters for app information
  get appCurrentVersion => appVersion;
  get appCurrentName => appName;
  get appLastUpdate => lastUpdate;
  get appCurrentSize => appSize;
  get appCurrentDescription => appDescription;

  // Change Log
  static const List<String> changeLog = [
    'প্রথম সংস্করণ প্রকাশ',
    'বেসিক ফিচার যোগ করা হয়েছে',
    'ইনভেন্টরি ম্যানেজমেন্ট সিস্টেম',
    'বিক্রয় ট্র্যাকিং সিস্টেম',
  ];
  get appChangeLog => changeLog;

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

  Future<void> saveCurrency(String currency) async {
    currentCurrency.value = currency;
    await _prefs.setString('currency', currency);
  }

  // Date format preferences
  Future<void> _loadDateFormatPreferences() async {
    currentDateFormat.value = _prefs.getString('dateFormat') ?? dateFormat;
    currentTimeFormat.value = _prefs.getString('timeFormat') ?? timeFormat;
  }

  // Pagination preferences
  Future<void> _loadPaginationPreferences() async {
    currentPageSize.value = _prefs.getInt('pageSize') ?? defaultPageSize;
  }

  // Cache preferences
  Future<void> _loadCachePreferences() async {
    currentCacheDuration.value =
        _prefs.getInt('cacheDuration') ?? cacheDuration;
  }

  // Date formatting methods
  String getFormattedDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String getFormattedTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} ${time.hour < 12 ? 'AM' : 'PM'}';
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
