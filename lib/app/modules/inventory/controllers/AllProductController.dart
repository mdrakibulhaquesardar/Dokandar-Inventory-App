import 'package:dokandar_app_inventory/app/data/models/category.dart';
import 'package:dokandar_app_inventory/app/core/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product.dart';
import '../../../widgets/showCustomSnackbar.dart';
import '../../../config/app_config.dart';
import '../../../utils/vibration_helper.dart';
import '../../home/controllers/home_controller.dart';

class AllProductController extends GetxController {

  final products = <Product>[].obs;
  final newProduct = <String, dynamic>{}.obs;
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  RxList<Category> allCategories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
    loadCategories();
  }

  void loadProducts() async {
    try {
      final loadedProducts = await _databaseService.getAllProducts();
      products.assignAll(loadedProducts);
    } catch (e) {
      debugPrint('Error loading products: $e');
      Get.snackbar('Error', 'Failed to load products');
    }
  }

  void loadCategories() async {
    try {
      final loadedCategories = await _databaseService.getAllCategories();
      allCategories.assignAll(loadedCategories);
    } catch (e) {
      debugPrint('Error loading categories: $e');
      Get.snackbar('Error', 'Failed to load categories');
    }
  }

  void saveNewProduct() async {
    try {
      // Check product limit if subscription is enabled
      if (AppConfig.enableSubscription) {
        final totalProducts = await _databaseService.getTotalProducts();
        if (totalProducts >= AppConfig.freePlanProductLimit) {
          showCustomSnackbar(
            title: 'Limit Reached',
            message: 'You have reached the free plan limit of ${AppConfig.freePlanProductLimit} products. Please upgrade to add more products.',
            backgroundColor: Colors.orange,
            icon: Icons.warning,
          );
          return;
        }
      }

      final product = Product.withGeneratedSku(
        name: newProduct['name'] ?? '',
        category: newProduct['category'] ?? '',
        stockQuantity: newProduct['stockQuantity'] ?? 0.0,
        unitPrice: newProduct['unitPrice'] ?? 0.0,
        buyingPrice: newProduct['buyingPrice'] ?? 0.0,
      );

      await _databaseService.saveProduct(product);
      products.add(product);
      newProduct.clear();
      VibrationHelper.onSuccess();
      showCustomSnackbar(
        title: 'Success',
        message: 'Product added successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      Get.find<HomeController>().refresh();
    } catch (e) {
      debugPrint('Error adding product: $e');
      showCustomSnackbar(
        title: 'Error',
        message: 'Failed to add product',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  void updateProduct(Product product) async {
    try {
      await _databaseService.saveProduct(product);
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
      }
      VibrationHelper.onSuccess();
      showCustomSnackbar(
        title: 'Success',
        message: 'Product updated successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      debugPrint('Error updating product: $e');
      showCustomSnackbar(
        title: 'Error',
        message: 'Failed to update product',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  void deleteProduct(int id) async {
    try {
      await _databaseService.deleteProduct(id);
      products.removeWhere((product) => product.id == id);
      VibrationHelper.onImportantAction();
      showCustomSnackbar(
        title: 'Success',
        message: 'Product deleted successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      Get.find<HomeController>().refresh();
    } catch (e) {
      debugPrint('Error deleting product: $e');
      showCustomSnackbar(
        title: 'Error',
        message: 'Failed to delete product',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  bool isLowStock(Product product) {
    return product.stockQuantity < AppConfig.lowStockThreshold;
  }
}
