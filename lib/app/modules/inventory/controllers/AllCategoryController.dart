import 'package:dokandar_app_inventory/app/core/services/database_service.dart';
import 'package:get/get.dart';

import '../../../data/models/category.dart';

class AllCategoryController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();
  final RxList<Category> categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final all = await _databaseService.getAllCategories();
    categories.assignAll(all);
  }

  Future<void> addCategory(Category category) async {
    await _databaseService.saveCategory(category);
    categories.add(category);
  }

  Future<void> updateCategory(Category category) async {
    await _databaseService.saveCategory(category);
    final index = categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      categories[index] = category;
    }
  }

  Future<void> deleteCategory(int? id) async {
    if (id == null) return;
    await _databaseService.deleteCategory(id);
    categories.removeWhere((c) => c.id == id);
  }
}
