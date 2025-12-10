
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../../../config/app_theme_config.dart';
import '../controllers/setup_controller.dart';

class SetupView extends GetView<SetupController> {
  const SetupView({super.key});
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
                l10n.userSetup,
                style: SafeGoogleFonts.poppins(
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
                  color:
                      themeConfig.getPrimaryColor(isDarkMode).withOpacity(0.1),
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
                      l10n.step1of2,
                      style: SafeGoogleFonts.poppins(
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
      body: Form(
        key: controller.userFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                          child: const CircleAvatar(
                            radius: 58,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
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
                    const SizedBox(height: 16),
                    Text(
                      l10n.completeProfile,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    Text(
                      l10n.completeProfileDescription,
                      textAlign: TextAlign.center,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 14,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              Text(
                l10n.userInfo,
                style: SafeGoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              Text(
                l10n.userInfoDescription,
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 0,
                color: themeConfig.getSurfaceColor(isDarkMode),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        validator: (value) => controller.validateName(value!),
                        decoration: InputDecoration(
                          labelText: l10n.name,
                          labelStyle: SafeGoogleFonts.poppins(),
                          hintText: l10n.fullName,
                          hintStyle: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig
                                  .getTextSecondaryColor(isDarkMode)
                                  .withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller.emailController,
                        validator: (value) => controller.validateEmail(value!),
                        decoration: InputDecoration(
                          labelText: l10n.email,
                          labelStyle: SafeGoogleFonts.poppins(),
                          hintText: l10n.emailAddress,
                          hintStyle: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig
                                  .getTextSecondaryColor(isDarkMode)
                                  .withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller.phoneController,
                        validator: (value) => controller.validatePhone(value!),
                        decoration: InputDecoration(
                          labelText: l10n.phoneNumber,
                          labelStyle: SafeGoogleFonts.poppins(),
                          hintText: l10n.mobileNumber,
                          hintStyle: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig
                                  .getTextSecondaryColor(isDarkMode)
                                  .withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: controller.addressController,
                        validator: (value) => controller.validateAddress(value!),
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: l10n.address,
                          labelStyle: SafeGoogleFonts.poppins(),
                          hintText: l10n.yourAddress,
                          hintStyle: SafeGoogleFonts.poppins(
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color:
                                themeConfig.getTextSecondaryColor(isDarkMode),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig
                                  .getTextSecondaryColor(isDarkMode)
                                  .withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: themeConfig.getPrimaryColor(isDarkMode),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed : () {
                    if (controller.userFormKey.currentState!.validate()) {
                       controller.onNextStep();
                    }
                    debugPrint('Name: ${controller.nameController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.nextStep,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  l10n.pinCodeSetup,
                  textAlign: TextAlign.center,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 14,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
