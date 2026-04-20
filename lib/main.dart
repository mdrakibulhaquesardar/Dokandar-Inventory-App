import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/core/services/localization_service.dart';
import 'app/core/services/database_service.dart';
import 'app/routes/app_pages.dart';
import 'app/config/app_config.dart';
import 'app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable edge-to-edge mode to use native status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // Initialize basic configuration (no database, UI only)
  await Get.putAsync(() => AppConfig().init());
  Get.put(AppThemeConfig(), permanent: true);
  // Register DatabaseService (mock-only implementation for UI kit)
  // Initialize synchronously since init() is fast for mock data
  final dbService = DatabaseService();
  await dbService.init();
  Get.put(dbService, permanent: true);

  Locale initialLocale = Locale(AppConfig.defaultLanguage);
  if (AppConfig.enableMultiLanguageSupport) {
    final localizationService = await Get.putAsync(
      () => LocalizationService().init(),
    );
    initialLocale = localizationService.currentLocale.value;
  }

  // For UI kit, start from login screen
  const initialRoute = Routes.LOGIN;

  runApp(MyApp(initialRoute: initialRoute, initialLocale: initialLocale));
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
            Get.lazyPut<AppConfig>(() => AppConfig());
            Get.lazyPut<AppThemeConfig>(() => AppThemeConfig());
            // Ensure DatabaseService is always available for all controllers
            // Since DatabaseService.init() is fast (just returns this), we can register it synchronously
            if (!Get.isRegistered<DatabaseService>()) {
              Get.put(DatabaseService(), permanent: true);
            }
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
