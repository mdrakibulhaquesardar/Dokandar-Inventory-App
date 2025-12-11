import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../controllers/app_lock_controller.dart';

class ManagePinView extends GetView<AppLockController> {
  const ManagePinView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDark = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDark),
      appBar: AppBar(
        title: Text(l10n.appLockTitle),
        backgroundColor: themeConfig.getSurfaceColor(isDark),
        foregroundColor: themeConfig.getTextPrimaryColor(isDark),
        elevation: 0,
      ),
      body: Obx(() {
        final isEnabled = controller.appConfig.isPinLockEnabled;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusCard(themeConfig, isDark, isEnabled, l10n),
              const SizedBox(height: 16),
              if (!isEnabled)
                _buildCreateSection(themeConfig, isDark, l10n)
              else
                _buildChangeSection(themeConfig, isDark, l10n),
              if (isEnabled) const SizedBox(height: 12),
              if (isEnabled) _buildDisableButton(themeConfig, isDark, l10n),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatusCard(AppThemeConfig themeConfig, bool isDarkMode,
      bool isEnabled, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeConfig.getSurfaceColor(isDarkMode),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            isEnabled ? Icons.lock_outline : Icons.lock_open_outlined,
            color: isEnabled
                ? themeConfig.getPrimaryColor(isDarkMode)
                : themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              isEnabled ? l10n.appLockEnabled : l10n.appLockDisabled,
              style: SafeGoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateSection(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.setPin,
          style: SafeGoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 8),
        _pinField(
          label: l10n.newPin,
          controller: controller.newPinController,
          themeConfig: themeConfig,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 10),
        _pinField(
          label: l10n.confirmPin,
          controller: controller.confirmPinController,
          themeConfig: themeConfig,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 16),
        Obx(() {
          final saving = controller.isSaving.value;
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saving ? null : () => _handleCreatePin(l10n),
              child: Text(saving ? l10n.saving : l10n.enableAppLockButton),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildChangeSection(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.changePin,
          style: SafeGoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        const SizedBox(height: 8),
        _pinField(
          label: l10n.currentPin,
          controller: controller.oldPinController,
          themeConfig: themeConfig,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 10),
        _pinField(
          label: l10n.newPin,
          controller: controller.newPinController,
          themeConfig: themeConfig,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 10),
        _pinField(
          label: l10n.confirmPin,
          controller: controller.confirmPinController,
          themeConfig: themeConfig,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 16),
        Obx(() {
          final saving = controller.isSaving.value;
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: saving ? null : () => _handleChangePin(l10n),
              child: Text(saving ? l10n.saving : l10n.updatePinButton),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDisableButton(
      AppThemeConfig themeConfig, bool isDarkMode, AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: controller.isSaving.value ? null : _handleDisable,
        child: Text(
          controller.isSaving.value ? l10n.saving : l10n.disableAppLockButton,
          style: SafeGoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _pinField({
    required String label,
    required TextEditingController controller,
    required AppThemeConfig themeConfig,
    required bool isDarkMode,
  }) {
    return TextField(
      controller: controller,
      obscureText: true,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(AppConfig.maxPinLength),
      ],
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: themeConfig.getSurfaceColor(isDarkMode),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: themeConfig.getBorderColor(isDarkMode),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: themeConfig.getBorderColor(isDarkMode),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: themeConfig.getPrimaryColor(isDarkMode),
            width: 1.5,
          ),
        ),
      ),
      style: SafeGoogleFonts.poppins(
        color: themeConfig.getTextPrimaryColor(isDarkMode),
      ),
    );
  }

  Future<void> _handleCreatePin(AppLocalizations l10n) async {
    final pin = controller.newPinController.text.trim();
    final confirm = controller.confirmPinController.text.trim();
    if (!_validate(pin, confirm, l10n)) return;
    final ok = await controller.createPin(pin);
    if (!ok) {
      _showSnack(l10n.genericError);
      return;
    }
    _showSnack(l10n.pinEnabledSuccess);
  }

  Future<void> _handleChangePin(AppLocalizations l10n) async {
    final oldPin = controller.oldPinController.text.trim();
    final pin = controller.newPinController.text.trim();
    final confirm = controller.confirmPinController.text.trim();
    if (!_validate(pin, confirm, l10n)) return;
    final ok = await controller.changePin(oldPin, pin);
    if (!ok) {
      _showSnack(l10n.oldPinIncorrect);
      return;
    }
    _showSnack(l10n.pinUpdatedSuccess);
  }

  Future<void> _handleDisable() async {
    await controller.disablePinLock();
    final l10n = AppLocalizations.of(Get.context!)!;
    _showSnack(l10n.pinDisabledSuccess);
  }

  bool _validate(String pin, String confirm, AppLocalizations l10n) {
    if (pin.length < AppConfig.minPinLength ||
        pin.length > AppConfig.maxPinLength) {
      _showSnack(
          l10n.pinLengthError(AppConfig.minPinLength, AppConfig.maxPinLength));
      return false;
    }
    if (pin != confirm) {
      _showSnack(l10n.pinMismatch);
      return false;
    }
    return true;
  }

  void _showSnack(String message) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDark = Get.isDarkMode;
    final context = Get.context;
    if (context == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeConfig.getSurfaceColor(isDark),
        content: Text(
          message,
          style: SafeGoogleFonts.poppins(
            color: themeConfig.getTextPrimaryColor(isDark),
          ),
        ),
      ),
    );
  }
}
