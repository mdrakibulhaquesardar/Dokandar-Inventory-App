import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../routes/app_pages.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<AppThemeConfig>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = theme.getPrimaryColor(isDark);
    final bgColor = theme.getBackgroundColor(isDark);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              // ── Logo ──────────────────────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/logo_only.png',
                  height: 90,
                  width: 90,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Dokandar',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Your Smart Inventory Partner',
                style: TextStyle(
                  fontSize: 14,
                  color: theme.getTextSecondaryColor(isDark),
                ),
              ),
              const SizedBox(height: 40),

              // ── Email field ───────────────────────────────────────────────
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.getSurfaceColor(isDark),
                ),
                onChanged: (_) => controller.clearError(),
              ),
              const SizedBox(height: 16),

              // ── Password field ────────────────────────────────────────────
              Obx(
                () => TextField(
                  controller: passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline, color: primaryColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: theme.getTextSecondaryColor(isDark),
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: theme.getSurfaceColor(isDark),
                  ),
                  onSubmitted: (_) => _doLogin(
                    emailController.text,
                    passwordController.text,
                  ),
                  onChanged: (_) => controller.clearError(),
                ),
              ),
              const SizedBox(height: 24),

              // ── Error message ─────────────────────────────────────────────
              Obx(() {
                final msg = controller.errorMessage.value;
                if (msg.isEmpty) return const SizedBox.shrink();
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade700, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          msg,
                          style: TextStyle(color: Colors.red.shade700, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              // ── Login button ──────────────────────────────────────────────
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () => _doLogin(
                              emailController.text,
                              passwordController.text,
                            ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Sign up link ──────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: theme.getTextSecondaryColor(isDark),
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.SIGNUP),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin(String email, String password) {
    controller.login(email, password);
  }
}
