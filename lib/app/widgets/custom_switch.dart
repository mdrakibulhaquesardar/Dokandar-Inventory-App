import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/app_theme_config.dart';
import '../utils/vibration_helper.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;
  final Color? inactiveColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    final primaryColor = activeColor ?? themeConfig.getPrimaryColor(isDarkMode);
    final inactiveTrackColor = inactiveColor ??
        (isDarkMode ? const Color(0xFF424242) : const Color(0xFFE0E0E0));

    return GestureDetector(
      onTap: () {
        VibrationHelper.onSelection();
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 44,
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: value ? primaryColor : inactiveTrackColor,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 22 : 2,
              top: 2,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


