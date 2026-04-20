import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/loading_overlay.dart';

/// Setup controller is now UI-only.
/// It collects data for demo purposes and then navigates to the main shell
/// without saving anything.
class SetupController extends GetxController {
  final currentStep = 0.obs;
  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeFormKey = GlobalKey<FormState>();

  // User form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  // Store form controllers
  final storeNameController = TextEditingController();
  final storeAddressController = TextEditingController();
  final storePhoneController = TextEditingController();
  final storeEmailController = TextEditingController();
  final businessTypeController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    storeNameController.dispose();
    storeAddressController.dispose();
    storePhoneController.dispose();
    storeEmailController.dispose();
    businessTypeController.dispose();
    super.onClose();
  }

  void saveSetupData() async {
    if (_validateUserForm() && _validateStoreForm()) {
      LoadingOverlay.show(
        message: 'Demo setup completed. Navigating to dashboard...',
      );
      await Future.delayed(const Duration(seconds: 1));
      LoadingOverlay.hide();
      Get.offAllNamed(Routes.MAIN);
    }
  }

  bool _validateUserForm() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      Get.snackbar('Info', 'This is a UI demo only. Please fill the fields.');
      return false;
    }
    return true;
  }

  bool _validateStoreForm() {
    if (storeNameController.text.isEmpty ||
        storeAddressController.text.isEmpty ||
        storePhoneController.text.isEmpty ||
        storeEmailController.text.isEmpty ||
        businessTypeController.text.isEmpty) {
      Get.snackbar('Info', 'This is a UI demo only. Please fill the fields.');
      return false;
    }
    return true;
  }

  // Simple field validators used by the form widgets
  String? validateName(String value) {
    if (value.isEmpty) return 'Name cannot be empty';
    if (value.length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email cannot be empty';
    if (!GetUtils.isEmail(value)) return 'Please enter a valid email';
    return null;
  }

  String? validatePhone(String value) {
    if (value.isEmpty) return 'Phone cannot be empty';
    if (!GetUtils.isPhoneNumber(value)) return 'Please enter a valid phone';
    return null;
  }

  String? validateAddress(String value) {
    if (value.isEmpty) return 'Address cannot be empty';
    if (value.length < 5) return 'Address must be at least 5 characters';
    return null;
  }

  void onNextStep() {
    if (currentStep.value < 1) {
      currentStep.value++;
    }
    // Store setup route removed - navigate to main dashboard instead
    Get.offAllNamed(Routes.MAIN);
  }
}
