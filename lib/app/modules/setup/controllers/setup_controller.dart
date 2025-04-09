import 'package:dokandar_app_inventory/app/data/models/store.dart';
import 'package:dokandar_app_inventory/app/data/models/user.dart';
import 'package:dokandar_app_inventory/app/data/services/database_service.dart';
import 'package:dokandar_app_inventory/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/loading_overlay.dart';

class SetupController extends GetxController {
  final currentStep = 0.obs;
  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> storeFormKey = GlobalKey<FormState>();
  
  // User form controllers
  final nameController = TextEditingController(
    text: 'John Doe',
  );
  final emailController = TextEditingController(
      text: "test@gmail.com"
  );
  final phoneController = TextEditingController(
    text: '+1234567890',
  );
  final passwordController = TextEditingController(
    text: 'password123',
  );
  final addressController = TextEditingController(
    text: '123 Main St, City, Country',
  );

  // Store form controllers
  final storeNameController = TextEditingController(
    text: 'My Store',
  );
  final storeAddressController = TextEditingController(
    text: '123 Main St, City, Country',
  );
  final storePhoneController = TextEditingController(
    text: '+1234567890',
  );
  final storeEmailController = TextEditingController(
    text: "test@gmail.com"
  );
  final businessTypeController = TextEditingController(
    text: 'রেস্তোরাঁ',
  );

  final DatabaseService _databaseService = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
  }

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
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
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

  String validateName(String value) {
    if (value.isEmpty) {
      Get.snackbar('Error', 'Name cannot be empty');
    }
    return value;
  }
  String validateEmail(String value) {
    if (value.isEmpty) {
      Get.snackbar('Error', 'Email cannot be empty');
    }
    return value;
  }
  String validatePhone(String value) {
    if (value.isEmpty) {
      Get.snackbar('Error', 'Phone cannot be empty');
    }
    return value;
  }

  String validateAddress(String value) {
    if (value.isEmpty) {
      Get.snackbar('Error', 'Address cannot be empty');
    }
    return value;
  }

  void onNextStep() {
    if (currentStep.value < 1) {
      currentStep.value++;
    }
    Get.toNamed(Routes.STORE_SETUP);
  }

}
