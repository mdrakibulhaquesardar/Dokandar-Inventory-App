import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/safe_google_fonts.dart';
import '../controllers/app_lock_controller.dart';

class LockScreenView extends StatefulWidget {
  const LockScreenView({super.key});

  @override
  State<LockScreenView> createState() => _LockScreenViewState();
}

class _LockScreenViewState extends State<LockScreenView> {
  final AppLockController controller = Get.find<AppLockController>();
  String _pinInput = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDark = Get.isDarkMode;
    final appConfig = Get.find<AppConfig>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDark),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor:
                    themeConfig.getPrimaryColor(isDark).withOpacity(0.12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/icon.png',
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                appConfig.appCurrentName,
                style: SafeGoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: themeConfig.getTextPrimaryColor(isDark),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.enterPinToContinue,
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDark),
                ),
              ),
              const SizedBox(height: 28),
              _buildPinDisplay(themeConfig, isDark),
              const SizedBox(height: 14),
              _buildKeypad(themeConfig, isDark),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinDisplay(AppThemeConfig themeConfig, bool isDarkMode) {
    final maxLen = AppConfig.maxPinLength;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(maxLen, (index) {
        final filled = index < _pinInput.length;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled
                ? themeConfig.getPrimaryColor(isDarkMode)
                : themeConfig.getBorderColor(isDarkMode),
          ),
        );
      }),
    );
  }

  Widget _buildKeypad(AppThemeConfig themeConfig, bool isDarkMode) {
    final buttons = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '←',
      '0',
      'E',
    ];

    Widget buildButton(String label) {
      final isAction = label == '←' || label == 'C' || label == 'E';
      return SizedBox(
        width: 78,
        height: 58,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
            foregroundColor: themeConfig.getTextPrimaryColor(isDarkMode),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            side: BorderSide(color: themeConfig.getBorderColor(isDarkMode)),
          ),
          onPressed: () => _onKeyTap(label),
          child: isAction
              ? Icon(
                  label == '←'
                      ? Icons.backspace_outlined
                      : label == 'E'
                          ? Icons.lock_open
                          : Icons.close,
                  size: 22,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                )
              : Text(
                  label,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
        ),
      );
    }

    return Column(
      children: [
        for (var row = 0; row < 4; row++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var col = 0; col < 3; col++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: buildButton(buttons[row * 3 + col]),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _unlockWithPin() async {
    final pin = _pinInput.trim();
    final success = await controller.verifyPinForUnlock(pin);
    if (success) {
      Get.offAllNamed(Routes.MAIN);
    } else {
      final themeConfig = Get.find<AppThemeConfig>();
      final isDark = Get.isDarkMode;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: themeConfig.getSurfaceColor(isDark),
          content: Text(
            AppLocalizations.of(context)!.invalidPinMessage,
            style: SafeGoogleFonts.poppins(
              color: themeConfig.getTextPrimaryColor(isDark),
            ),
          ),
        ),
      );
    }
  }

  void _onKeyTap(String label) {
    setState(() {
      if (label == 'C') {
        _pinInput = '';
      } else if (label == '←') {
        if (_pinInput.isNotEmpty) {
          _pinInput = _pinInput.substring(0, _pinInput.length - 1);
        }
      } else if (label == 'E') {
        _unlockWithPin();
      } else {
        if (_pinInput.length < AppConfig.maxPinLength) {
          _pinInput += label;
        }
      }
    });
  }
}
