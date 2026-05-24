import 'package:dokandar_app_inventory/app/config/app_theme_config.dart';
import 'package:dokandar_app_inventory/app/modules/setting/controllers/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';

import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../data/models/user.dart';
import '../../../widgets/Custom_AppBar.dart';

class EditProfileView extends GetView<SettingController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    final nameController =
        TextEditingController(text: controller.user?.name ?? '');
    final emailController =
        TextEditingController(text: controller.user?.email ?? '');
    final phoneController =
        TextEditingController(text: controller.user?.phone ?? '');
    final roleController =
        TextEditingController(text: controller.user?.role ?? '');

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        'Edit Profile',
        true,
        false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field(l10n.name, nameController),
            _field(l10n.email, emailController,
                keyboardType: TextInputType.emailAddress),
            _field(l10n.mobile, phoneController,
                keyboardType: TextInputType.phone),
            _field('Role', roleController),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final user = User()
                    ..id = controller.user?.id ?? 0
                    ..name = nameController.text
                    ..email = emailController.text
                    ..phone = phoneController.text
                    ..role = roleController.text;
                  await controller.updateUser(user);
                  Get.snackbar(l10n.success, 'Profile saved',
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

