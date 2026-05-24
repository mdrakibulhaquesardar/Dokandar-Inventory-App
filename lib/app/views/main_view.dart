import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/persistent_navigation_controller.dart';
import '../config/app_theme_config.dart';
import '../config/app_config.dart';
import '../../l10n/app_localizations.dart';
import '../utils/safe_google_fonts.dart';

class MainView extends GetView<PersistentNavigationController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final appConfig = Get.find<AppConfig>();
    
    return Obx(() {
      final currentTheme = appConfig.currentTheme.value; // Listen to theme reactively
      final isDarkMode = currentTheme == 'dark' || 
          (currentTheme == 'system' && Theme.of(context).brightness == Brightness.dark);
          
      final selectedColor = themeConfig.getPrimaryColor(isDarkMode);
      final unselectedColor = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
      final backgroundColor = themeConfig.getSurfaceColor(isDarkMode).withValues(alpha: 0.85);
      final l10n = AppLocalizations.of(context)!;
      final currentIndex = controller.currentIndex.value;

      return Scaffold(
        backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
        body: IndexedStack(
          key: ValueKey('main_stack_$currentTheme'), // Force recreation of screens on theme change
          index: currentIndex,
          children: controller.buildScreens(),
        ),
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border(
                  top: BorderSide(
                    color: isDarkMode ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, l10n.home, currentIndex, selectedColor, unselectedColor, isDarkMode),
                    _buildNavItem(1, Icons.inventory_2_rounded, l10n.inventory, currentIndex, selectedColor, unselectedColor, isDarkMode),
                    _buildNavItem(2, Icons.sell_rounded, l10n.sellCounter, currentIndex, selectedColor, unselectedColor, isDarkMode),
                    _buildNavItem(3, Icons.settings_rounded, l10n.settings, currentIndex, selectedColor, unselectedColor, isDarkMode),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    String label,
    int currentIndex,
    Color selectedColor,
    Color unselectedColor,
    bool isDarkMode,
  ) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => controller.currentIndex.value = index,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? selectedColor.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isSelected ? selectedColor : unselectedColor,
                size: 22,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: SafeGoogleFonts.poppins(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? selectedColor : unselectedColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
