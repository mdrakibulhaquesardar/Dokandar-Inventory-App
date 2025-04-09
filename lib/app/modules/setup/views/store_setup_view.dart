import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/app_theme_config.dart';
import '../../../data/models/store.dart';
import '../controllers/setup_controller.dart';

class StoreSetupView extends GetView<SetupController> {
  const StoreSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

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
                  'দোকান সেটআপ',
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
                        'ধাপ 2/2',
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
                        'দোকানের লোগো যোগ করুন',
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
                  'দোকানের তথ্য',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                Text(
                  'আপনার দোকানের তথ্য দিন',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storeNameController,
                  decoration: InputDecoration(
                    labelText: 'দোকানের নাম',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'দোকানের নাম দিন';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storeAddressController,
                  decoration: InputDecoration(
                    labelText: 'ঠিকানা',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ঠিকানা দিন';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storePhoneController,
                  decoration: InputDecoration(
                    labelText: 'ফোন নম্বর',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ফোন নম্বর দিন';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.storeEmailController,
                  decoration: InputDecoration(
                    labelText: 'ইমেইল',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ইমেইল দিন';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'সঠিক ইমেইল দিন';
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
                    labelText: 'ব্যবসার ধরন',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: [
                    'খুচরা বিক্রেতা',
                    'পাইকারি বিক্রেতা',
                    'রেস্তোরাঁ',
                    'ফার্মেসি',
                    'ফ্যাশন স্টোর',
                    'ইলেকট্রনিক্স',
                    'অন্যান্য',
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
                      return 'ব্যবসার ধরন দিন';
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
                          'আপনার দোকানের তথ্য সঠিকভাবে দিন। এই তথ্য আপনার ব্যবসার জন্য গুরুত্বপূর্ণ।',
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
                          'পূর্ববর্তী',
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
                            final store = Store(
                              name: controller.storeNameController.text,
                              address: controller.storeAddressController.text,
                              phone: controller.storePhoneController.text,
                              email: controller.storeEmailController.text,
                              businessType:
                                  controller.businessTypeController.text,
                            );
                            // TODO: Save store data and navigate to next screen
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
                          'পরবর্তী',
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
