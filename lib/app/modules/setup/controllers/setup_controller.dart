import 'package:dokandar_app_inventory/app/data/models/store.dart';
import 'package:dokandar_app_inventory/app/data/models/user.dart';
import 'package:dokandar_app_inventory/app/core/services/database_service.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/loading_overlay.dart';

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

  final DatabaseService _databaseService = Get.find<DatabaseService>();


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
        message: ' আপনার তথ্য সংরক্ষণ করা হচ্ছে...',
      );
      Future.delayed(const Duration(seconds: 3));
      final user = User.init(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        role: 'owner',
      );
      await _databaseService.saveUser(user);
      final store = Store(
        name: storeNameController.text,
        address: storeAddressController.text,
        phone: storePhoneController.text,
        email: storeEmailController.text,
        businessType: businessTypeController.text,
      );
      await _databaseService.saveStore(store);
      LoadingOverlay.hide();
      Get.offAllNamed(Routes.MAIN);
    }
  }

  bool _validateUserForm() {
    if (
        nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text) ||
        !GetUtils.isPhoneNumber(phoneController.text)
    ) {
      Get.snackbar('Error', 'Please fill all fields on User Form');
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
      Get.snackbar('Error', 'Please fill all fields');
      return false;
    }
    return true;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone cannot be empty';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }
    if (value.length < 5) {
      return 'Address must be at least 5 characters long';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void onNextStep() {
    if (currentStep.value < 1) {
      currentStep.value++;
    }
    Get.toNamed(Routes.STORE_SETUP);
  }
}
