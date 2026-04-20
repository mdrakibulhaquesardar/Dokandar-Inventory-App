import 'package:dokandar_app_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/core/services/database_service.dart';
import 'app/core/services/localization_service.dart';
import 'app/core/services/backup_service.dart';
import 'app/core/services/auto_backup_service.dart';
import 'app/controllers/persistent_navigation_controller.dart';
import 'app/modules/inventory/controllers/inventory_controller.dart';
import 'app/modules/sell/controllers/sell_controller.dart';
import 'app/modules/setting/controllers/setting_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/config/app_config.dart';
import 'app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable edge-to-edge mode to use native status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Initialize services
  final dbService = await Get.putAsync(() => DatabaseService().init());
  final appConfig = await Get.putAsync(() => AppConfig().init());
  Get.put(AppThemeConfig());

  // Initialize LocalizationService if multi-language is enabled
  Locale initialLocale = Locale(AppConfig.defaultLanguage);
  if (AppConfig.enableMultiLanguageSupport) {
    final localizationService = await Get.putAsync(
      () => LocalizationService().init(),
    );
    initialLocale = localizationService.currentLocale.value;
  }

  // Initialize controllers
  Get.put(PersistentNavigationController());
  Get.put(SettingController());
  Get.put(HomeController());
  Get.put(SellController());
  Get.put(InventoryController());

  // Defer heavier non-UI initializations to after first frame
  _initDeferredServices(dbService);

  // Check if user exists
  final hasUser = await dbService.hasUser();
  final shouldLock =
      hasUser && appConfig.isPinLockEnabled && !appConfig.isSessionUnlocked;
  final initialRoute =
      hasUser ? (shouldLock ? Routes.APP_LOCK : Routes.MAIN) : Routes.SETUP;

  runApp(MyApp(initialRoute: initialRoute, initialLocale: initialLocale));
}

void _initDeferredServices(DatabaseService dbService) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      await Get.putAsync(() => BackupService().init(dbService.isar));
      Get.put(AutoBackupService());
    } catch (e) {
      debugPrint('Deferred service init failed: $e');
    }
  });
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final Locale initialLocale;

  const MyApp({
    super.key,
    required this.initialRoute,
    required this.initialLocale,
  });

  // Helper function to convert theme string to ThemeMode
  ThemeMode _getThemeMode(String theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appConfig = Get.find<AppConfig>();

    // Set initial theme mode from saved preference
    final savedTheme = appConfig.currentTheme.value;
    Get.changeThemeMode(_getThemeMode(savedTheme));

    // Build widget that reacts to both locale and theme changes
    Widget buildApp(Locale currentLocale) {
      return Obx(() {
        // Listen to theme changes - this will rebuild the entire app
        final currentTheme = appConfig.currentTheme.value;
        final themeMode = _getThemeMode(currentTheme);

        // Update GetX theme mode immediately (synchronous)
        Get.changeThemeMode(themeMode);

        // Use a key that changes with theme to force complete rebuild
        return GetMaterialApp(
          key: ValueKey('app_$currentTheme'),
          debugShowCheckedModeBanner: false,
          title: appConfig.appCurrentName,
          theme: Get.find<AppThemeConfig>().getLightTheme(),
          darkTheme: Get.find<AppThemeConfig>().getDarkTheme(),
          themeMode: themeMode,
          initialRoute: initialRoute,
          getPages: AppPages.routes,
          defaultTransition: Transition.fade,
          // Localization configuration
          locale: currentLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('bn', ''), // Bengali
            Locale('en', ''), // English
          ],
          initialBinding: BindingsBuilder(() {
            Get.lazyPut<DatabaseService>(() => DatabaseService());
            Get.lazyPut<HomeController>(() => HomeController());
            Get.lazyPut<AppConfig>(() => AppConfig());
            Get.lazyPut<AppThemeConfig>(() => AppThemeConfig());
            if (AppConfig.enableMultiLanguageSupport) {
              Get.lazyPut<LocalizationService>(() => LocalizationService());
            }
          }),
          builder: (context, child) {
            // Set status bar style based on current theme
            final brightness = MediaQuery.of(context).platformBrightness;
            final isDark = themeMode == ThemeMode.dark ||
                (themeMode == ThemeMode.system &&
                    brightness == Brightness.dark);
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    isDark ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    isDark ? Brightness.dark : Brightness.light,
                systemNavigationBarColor: Colors.transparent,
                systemNavigationBarIconBrightness:
                    isDark ? Brightness.light : Brightness.dark,
              ),
            );
            return child ?? const SizedBox();
          },
        );
      });
    }

    if (AppConfig.enableMultiLanguageSupport &&
        Get.isRegistered<LocalizationService>()) {
      final localizationService = Get.find<LocalizationService>();
      return Obx(() => buildApp(localizationService.currentLocale.value));
    }
    return buildApp(initialLocale);
  }
}
