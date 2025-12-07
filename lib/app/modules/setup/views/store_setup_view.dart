import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../controllers/setup_controller.dart';

class StoreSetupView extends GetView<SetupController> {
  const StoreSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
        backgroundColor: themeConfig.getSurfaceColor(isDarkMode),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            decoration: BoxDecoration(
              color: themeConfig.getSurfaceColor(isDarkMode),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Text(
                  l10n.storeSetup,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: themeConfig
                        .getPrimaryColor(isDarkMode)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 16,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.step2of2,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.storeFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: themeConfig
                                .getPrimaryColor(isDarkMode)
                                .withOpacity(0.1),
                            child: Icon(
                              Icons.store_outlined,
                              size: 60,
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: themeConfig.getPrimaryColor(isDarkMode),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.addStoreLogo,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.storeInfo,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                Text(
                  l10n.storeInfoDescription,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storeNameController,
                  decoration: InputDecoration(
                    labelText: l10n.storeName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.storeNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storeAddressController,
                  decoration: InputDecoration(
                    labelText: l10n.address,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.addressRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storePhoneController,
                  decoration: InputDecoration(
                    labelText: l10n.phoneNumber,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.phoneRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storeEmailController,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.emailRequired;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return l10n.validEmailRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: controller.businessTypeController.text.isEmpty
                      ? null
                      : controller.businessTypeController.text,
                  decoration: InputDecoration(
                    labelText: l10n.businessType,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    l10n.retailer,
                    l10n.wholesaler,
                    l10n.restaurant,
                    l10n.pharmacy,
                    l10n.fashionStore,
                    l10n.electronics,
                    l10n.other,
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      controller.businessTypeController.text = value;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.businessTypeRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeConfig
                        .getPrimaryColor(isDarkMode)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.storeInfoNote,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: themeConfig
                              .getPrimaryColor(isDarkMode)
                              .withOpacity(0.1),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          l10n.previous,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeConfig.getPrimaryColor(isDarkMode),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.storeFormKey.currentState!
                              .validate()) {
                            // TODO: Save store data and navigate to next screen
                            // Store will be saved in SetupController.saveSetupData()
                            Get.toNamed(Routes.CONFROM_SETUP);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              themeConfig.getPrimaryColor(isDarkMode),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          l10n.next,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
