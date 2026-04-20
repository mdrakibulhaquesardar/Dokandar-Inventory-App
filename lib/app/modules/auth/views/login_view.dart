import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../controllers/auth_controller.dart';
import 'signup_view.dart';
import 'forgot_password_view.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Logo/Brand
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: themeConfig.getPrimaryColor(isDarkMode),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.dashboard,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'BizDash',
                      style: SafeGoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Business Admin UI Kit',
                      style: SafeGoogleFonts.poppins(
                        fontSize: 14,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Login',
                style: SafeGoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your credentials to continue',
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 32),
              // Email Field
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'demo@example.com',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: themeConfig.getSurfaceColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              Obx(() => TextField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: themeConfig.getTextSecondaryColor(isDarkMode),
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: themeConfig.getSurfaceColor(isDarkMode),
                    ),
                  )),
              const SizedBox(height: 8),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => const ForgotPasswordView()),
                  child: Text(
                    'Forgot Password?',
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      color: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Login Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themeConfig.getPrimaryColor(isDarkMode),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Login',
                              style: SafeGoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )),
              const SizedBox(height: 24),
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: SafeGoogleFonts.poppins(
                      fontSize: 14,
                      color: themeConfig.getTextSecondaryColor(isDarkMode),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => const SignupView()),
                    child: Text(
                      'Sign Up',
                      style: SafeGoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getPrimaryColor(isDarkMode),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Demo Notice
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeConfig
                      .getPrimaryColor(isDarkMode)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: themeConfig.getPrimaryColor(isDarkMode),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This is a UI demo only. No real authentication.',
                        style: SafeGoogleFonts.poppins(
                          fontSize: 12,
                          color: themeConfig.getPrimaryColor(isDarkMode),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
