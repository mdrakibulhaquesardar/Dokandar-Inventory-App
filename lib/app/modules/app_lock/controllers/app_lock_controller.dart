import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';

class AppLockController extends GetxController {
  final AppConfig appConfig = Get.find<AppConfig>();

  final TextEditingController oldPinController = TextEditingController();
  final TextEditingController newPinController = TextEditingController();
  final TextEditingController confirmPinController = TextEditingController();

  final RxBool isSaving = false.obs;
  final RxBool isVerifying = false.obs;
  final RxString errorMessage = ''.obs;

  bool get isPinEnabled => appConfig.isPinLockEnabled;

  @override
  void onClose() {
    oldPinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();
    super.onClose();
  }

  Future<bool> createPin(String pin) async {
    isSaving.value = true;
    try {
      await appConfig.savePin(pin);
      return true;
    } catch (e) {
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> changePin(String oldPin, String newPin) async {
    isSaving.value = true;
    try {
      final match = await appConfig.verifyPin(oldPin);
      if (!match) return false;
      await appConfig.savePin(newPin);
      return true;
    } catch (e) {
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> disablePinLock() async {
    isSaving.value = true;
    try {
      await appConfig.disablePinLock();
      oldPinController.clear();
      newPinController.clear();
      confirmPinController.clear();
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> verifyPinForUnlock(String pin) async {
    if (pin.isEmpty) return false;
    isVerifying.value = true;
    try {
      return await appConfig.verifyPin(pin);
    } finally {
      isVerifying.value = false;
    }
  }

}

