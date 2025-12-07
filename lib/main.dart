import 'package:dokandar_app_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'app/core/services/database_service.dart';
import 'app/core/services/localization_service.dart';
import 'app/controllers/persistent_navigation_controller.dart';
import 'app/modules/inventory/controllers/inventory_controller.dart';
import 'app/modules/sell/controllers/sell_controller.dart';
import 'app/modules/setting/controllers/setting_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/config/app_config.dart';
import 'app/config/app_theme_config.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services
  final dbService = await Get.putAsync(() => DatabaseService().init());
  await Get.putAsync(() => AppConfig().init());
  Get.put(AppThemeConfig());

  // Initialize LocalizationService if multi-language is enabled
  Locale initialLocale = Locale(AppConfig.defaultLanguage);
  if (AppConfig.enableMultiLanguageSupport) {
    final localizationService =
        await Get.putAsync(() => LocalizationService().init());
    initialLocale = localizationService.currentLocale.value;
  }

  // Initialize controllers
  Get.put(PersistentNavigationController());
  Get.put(SettingController());
  Get.put(HomeController());
  Get.put(SellController());
  Get.put(InventoryController());

  // Check if user exists
  final hasUser = await dbService.hasUser();
  final initialRoute = hasUser ? Routes.MAIN : Routes.SETUP;

  runApp(MyApp(
    initialRoute: initialRoute,
    initialLocale: initialLocale,
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final Locale initialLocale;

  const MyApp({
    super.key,
    required this.initialRoute,
    required this.initialLocale,
  });

  @override
  Widget build(BuildContext context) {
    if (AppConfig.enableMultiLanguageSupport &&
        Get.isRegistered<LocalizationService>()) {
      final localizationService = Get.find<LocalizationService>();
      return Obx(() => _buildApp(localizationService.currentLocale.value));
    }
    return _buildApp(initialLocale);
  }

  Widget _buildApp(Locale currentLocale) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Get.find<AppConfig>().appCurrentName,
      theme: Get.find<AppThemeConfig>().getLightTheme(),
      darkTheme: Get.find<AppThemeConfig>().getDarkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
      // Localization configuration
      locale: currentLocale,
      localizationsDelegates: const [
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
    );
  }
}
