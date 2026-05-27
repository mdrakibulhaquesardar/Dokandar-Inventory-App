import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void clearError() => errorMessage.value = '';

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      errorMessage.value = 'Please enter your email and password.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await AuthService.instance.login(
        email.trim(),
        password,
      );

      if (success) {
        Get.offAllNamed(Routes.MAIN);
      } else {
        errorMessage.value = 'Invalid email or password. Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'Connection error. Please check your internet.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String storeName,
    required String storeAddress,
    required String storePhone,
    required String businessType,
  }) async {
    // Basic validation
    if (name.trim().isEmpty) {
      errorMessage.value = 'Name is required.';
      return;
    }
    if (email.trim().isEmpty) {
      errorMessage.value = 'Email is required.';
      return;
    }
    if (password.length < 6) {
      errorMessage.value = 'Password must be at least 6 characters.';
      return;
    }
    if (password != confirmPassword) {
      errorMessage.value = 'Passwords do not match.';
      return;
    }
    if (storeName.trim().isEmpty) {
      errorMessage.value = 'Store name is required.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final success = await AuthService.instance.register(
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        password: password,
        storeName: storeName.trim(),
        storeAddress: storeAddress.trim(),
        storePhone: storePhone.trim(),
        businessType: businessType,
      );

      if (success) {
        Get.offAllNamed(Routes.MAIN);
      } else {
        errorMessage.value =
            'Registration failed. Email may already be in use.';
      }
    } catch (e) {
      errorMessage.value = 'Connection error. Please check your internet.';
    } finally {
      isLoading.value = false;
    }
  }
}
