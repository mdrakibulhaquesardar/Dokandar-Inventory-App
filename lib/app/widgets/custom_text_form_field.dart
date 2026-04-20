import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_theme_config.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;

    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: themeConfig.getTextSecondaryColor(isDarkMode),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: themeConfig.getTextSecondaryColor(isDarkMode).withOpacity(0.3),
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
    );
  }
}