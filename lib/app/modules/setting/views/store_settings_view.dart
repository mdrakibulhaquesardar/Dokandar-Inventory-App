import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../data/models/store.dart';
import '../../../widgets/Custom_AppBar.dart';

class StoreSettingsView extends GetView<SettingController> {
  const StoreSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    final nameController =
        TextEditingController(text: controller.store?.name ?? '');
    final addressController =
        TextEditingController(text: controller.store?.address ?? '');
    final phoneController =
        TextEditingController(text: controller.store?.phone ?? '');
    final emailController =
        TextEditingController(text: controller.store?.email ?? '');

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.storeSettings,
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _field(l10n.storeName, nameController),
              _field(l10n.address, addressController, maxLines: 2),
              _field(l10n.mobile, phoneController,
                  keyboardType: TextInputType.phone),
              _field(l10n.email, emailController,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final updated = Store(
                      name: nameController.text.isEmpty ? 'Store' : nameController.text,
                      address: addressController.text.isEmpty ? 'Address' : addressController.text,
                      phone: phoneController.text.isEmpty ? '0000000000' : phoneController.text,
                      email: emailController.text.isEmpty ? 'store@example.com' : emailController.text,
                      businessType: controller.store?.businessType ?? 'Retail',
                    )
                      ..id = controller.store?.id ?? 0;
                    await controller.updateStore(updated);
                    Get.snackbar(l10n.success, 'Settings saved',
                        snackPosition: SnackPosition.BOTTOM);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  ),
                  child: Text(
                    l10n.save,
                    style: SafeGoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

