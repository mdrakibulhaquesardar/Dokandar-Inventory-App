import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackItem {
  final String message;
  final String category;
  final int rating;

  FeedbackItem({
    required this.message,
    required this.category,
    required this.rating,
  });
}

class FeedbackController extends GetxController {
  final feedbackTextController = TextEditingController();
  final RxString selectedCategory = 'general'.obs;
  final RxInt rating = 4.obs;
  final RxList<FeedbackItem> feedbacks = <FeedbackItem>[].obs;

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  void setRating(int value) {
    rating.value = value;
  }

  void submitFeedback() {
    if (feedbackTextController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter feedback',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    feedbacks.add(FeedbackItem(
      message: feedbackTextController.text.trim(),
      category: selectedCategory.value,
      rating: rating.value,
    ));
    feedbackTextController.clear();
    Get.snackbar('Success', 'Feedback submitted',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    feedbackTextController.dispose();
    super.onClose();
  }
}

