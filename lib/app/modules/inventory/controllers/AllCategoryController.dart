import 'package:dokandar_app_inventory/app/data/models/category.dart';
import 'package:dokandar_app_inventory/app/data/services/database_service.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';


class AllCategoryController extends GetxController {
  final categories = <Category>[].obs;

  final DatabaseService _databaseService = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    // Load initial categories
    loadCategories();
  }

  void loadCategories() async {
    try {
      final loadedCategories = await _databaseService.getAllCategories();
      categories.assignAll(loadedCategories);
    } catch (e) {
      // Handle error
      print('Error loading categories: $e');
    }
  }

  void addCategory(Category category) async {
    try {
      await _databaseService.saveCategory(category);
      categories.add(category);
      Get.find<HomeController>().refresh();
    } catch (e) {
      // Handle error
      print('Error adding category: $e');
    }
  }

  void updateCategory(Category category) async {
    try {
      await _databaseService.saveCategory(category);
      final index = categories.indexWhere((c) => c.id == category.id);
      if (index != -1) {
        categories[index] = category;
      }
    } catch (e) {
      // Handle error
      print('Error updating category: $e');
    }
  }

  void deleteCategory(int id) async {
    try {
      await _databaseService.deleteCategory(id);
      categories.removeWhere((category) => category.id == id);
      Get.find<HomeController>().refresh();
    } catch (e) {
      // Handle error
      print('Error deleting category: $e');
    }
  }


}
