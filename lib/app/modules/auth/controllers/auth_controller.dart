import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

/// UI-only authentication controller for the BizDash UI Kit.
///
/// All authentication is mock-only - no real validation or backend calls.
/// After "login" or "signup", navigates to the main dashboard.
class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Mock login - just validates fields and navigates to dashboard
  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        'Demo Only',
        'Please fill in email and password fields (UI demo only)',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    // Navigate to main dashboard
    Get.offAllNamed(Routes.MAIN);
  }

  /// Mock signup - validates fields and navigates to dashboard
  Future<void> signup() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Demo Only',
        'Please fill in all fields (UI demo only)',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Demo Only',
        'Passwords do not match (UI demo only)',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    // Navigate to main dashboard
    Get.offAllNamed(Routes.MAIN);
  }

  /// Mock forgot password - just shows a message
  Future<void> sendResetLink() async {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Demo Only',
        'Please enter your email (UI demo only)',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    Get.snackbar(
      'Demo Only',
      'Password reset link would be sent to ${emailController.text} (UI demo only)',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );

    // Go back to login
    Get.back();
  }
}
