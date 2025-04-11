import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  Color backgroundColor = Colors.green,
  SnackPosition snackPosition = SnackPosition.TOP,
  IconData icon = Icons.check_circle,
  Duration duration = const Duration(seconds: 3),
}) {
  Get.snackbar(
    title,
    message,
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    snackPosition: snackPosition,
    backgroundColor: backgroundColor,
    borderRadius: 12,
    margin: const EdgeInsets.all(16),
    icon: Icon(icon, color: Colors.white),
    duration: duration,
    titleText: Text(
      title,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}