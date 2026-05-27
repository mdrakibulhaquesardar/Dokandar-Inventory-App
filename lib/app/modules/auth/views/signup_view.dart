import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../controllers/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<AppThemeConfig>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = theme.getPrimaryColor(isDark);
    final bgColor = theme.getBackgroundColor(isDark);
    final surfaceColor = theme.getSurfaceColor(isDark);

    // Form controllers
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmPassCtrl = TextEditingController();
    final storeNameCtrl = TextEditingController();
    final storeAddrCtrl = TextEditingController();
    final storePhoneCtrl = TextEditingController();
    final businessTypeNotifier = ValueNotifier<String>('Retail');

    const businessTypes = [
      'Retail',
      'Wholesale',
      'Restaurant',
      'Service',
      'Other',
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Personal Info section ────────────────────────────────────
            _SectionHeader(
              title: 'Personal Info',
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 14),
            _buildTextField(
              controller: nameCtrl,
              label: 'Full Name',
              icon: Icons.person_outline,
              primaryColor: primaryColor,
              surfaceColor: surfaceColor,
              onChanged: (_) => controller.clearError(),
            ),
            const SizedBox(height: 14),
            _buildTextField(
              controller: emailCtrl,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              primaryColor: primaryColor,
              surfaceColor: surfaceColor,
              onChanged: (_) => controller.clearError(),
            ),
            const SizedBox(height: 14),
            _buildTextField(
              controller: phoneCtrl,
              label: 'Phone',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              primaryColor: primaryColor,
              surfaceColor: surfaceColor,
              onChanged: (_) => controller.clearError(),
            ),
            const SizedBox(height: 14),
            Obx(
              () => _buildTextField(
                controller: passwordCtrl,
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: !controller.isPasswordVisible.value,
                primaryColor: primaryColor,
                surfaceColor: surfaceColor,
                onChanged: (_) => controller.clearError(),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: theme.getTextSecondaryColor(isDark),
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Obx(
              () => _buildTextField(
                controller: confirmPassCtrl,
                label: 'Confirm Password',
                icon: Icons.lock_outline,
                obscureText: !controller.isConfirmPasswordVisible.value,
                primaryColor: primaryColor,
                surfaceColor: surfaceColor,
                onChanged: (_) => controller.clearError(),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isConfirmPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: theme.getTextSecondaryColor(isDark),
                  ),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // ── Store Info section ───────────────────────────────────────
            _SectionHeader(
              title: 'Store Info',
              primaryColor: primaryColor,
            ),
            const SizedBox(height: 14),
            _buildTextField(
              controller: storeNameCtrl,
              label: 'Store Name',
              icon: Icons.store_outlined,
              primaryColor: primaryColor,
              surfaceColor: surfaceColor,
              onChanged: (_) => controller.clearError(),
            ),
            const SizedBox(height: 14),
            _buildTextField(
              controller: storeAddrCtrl,
              label: 'Store Address',
              icon: Icons.location_on_outlined,
              primaryColor: primaryColor,
              surfaceColor: surfaceColor,
              onChanged: (_) => controller.clearError(),
            ),
            const SizedBox(height: 14),
            _buildTextField(
              controller: storePhoneCtrl,
              label: 'Store Phone',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              primaryColor: primaryColor,
              surfaceColor: surfaceColor,
              onChanged: (_) => controller.clearError(),
            ),
            const SizedBox(height: 14),

            // ── Business type dropdown ────────────────────────────────────
            ValueListenableBuilder<String>(
              valueListenable: businessTypeNotifier,
              builder: (_, selectedType, __) {
                return DropdownButtonFormField<String>(
                  initialValue: selectedType,
                  decoration: InputDecoration(
                    labelText: 'Business Type',
                    prefixIcon: Icon(
                      Icons.business_outlined,
                      color: primaryColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: surfaceColor,
                  ),
                  items: businessTypes
                      .map(
                        (t) => DropdownMenuItem(value: t, child: Text(t)),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) businessTypeNotifier.value = val;
                  },
                );
              },
            ),
            const SizedBox(height: 28),

            // ── Error message ────────────────────────────────────────────
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
                    Icon(Icons.error_outline,
                        color: Colors.red.shade700, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        msg,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // ── Register button ──────────────────────────────────────────
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
                      : () => controller.register(
                            name: nameCtrl.text,
                            email: emailCtrl.text,
                            phone: phoneCtrl.text,
                            password: passwordCtrl.text,
                            confirmPassword: confirmPassCtrl.text,
                            storeName: storeNameCtrl.text,
                            storeAddress: storeAddrCtrl.text,
                            storePhone: storePhoneCtrl.text,
                            businessType: businessTypeNotifier.value,
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
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ── Back to login ────────────────────────────────────────────
            Center(
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Already have an account? Sign In',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color primaryColor,
    required Color surfaceColor,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryColor),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: surfaceColor,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color primaryColor;

  const _SectionHeader({required this.title, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
