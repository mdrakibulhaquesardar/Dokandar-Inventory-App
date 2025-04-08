import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends GetxService {
  // App Version
  static const String appVersion = '1.0.0';

  // Database Configuration
  static const String databaseName = 'dokandar_db';

  // API Configuration
  static const String baseUrl = 'https://api.example.com';
  static const int apiTimeout = 30000; // 30 seconds

  // Theme Configuration
  final RxString currentTheme = 'light'.obs;
  final RxInt currentFontSize = 14.obs;

  // Currency Configuration
  final RxString currentCurrency = 'BDT'.obs;
  static const String currencySymbol = '৳';

  // Date Format Configuration
  final RxString currentDateFormat = 'dd/MM/yyyy'.obs;
  final RxString currentTimeFormat = 'hh:mm a'.obs;

  // Pagination Configuration
  final RxInt currentPageSize = 20.obs;

  // Cache Configuration
  final RxInt currentCacheDuration = 3600.obs; // 1 hour in seconds

  late SharedPreferences _prefs;

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
