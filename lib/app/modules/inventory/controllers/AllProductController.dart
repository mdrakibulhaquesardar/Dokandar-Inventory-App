import 'package:dokandar_app_inventory/app/data/models/category.dart';
import 'package:dokandar_app_inventory/app/data/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/product.dart';
import '../../../widgets/showCustomSnackbar.dart';

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
      print('Error loading products: $e');
      Get.snackbar('Error', 'Failed to load products');
    }
  }

  void loadCategories() async {
    try {
      final loadedCategories = await _databaseService.getAllCategories();
      allCategories.assignAll(loadedCategories);
    } catch (e) {
      print('Error loading categories: $e');
      Get.snackbar('Error', 'Failed to load categories');
    }
  }

  void saveNewProduct() async {
    try {
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
      showCustomSnackbar(
        title: 'Success',
        message: 'Product added successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      print('Error adding product: $e');
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
      showCustomSnackbar(
        title: 'Success',
        message: 'Product updated successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      print('Error updating product: $e');
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
      showCustomSnackbar(
        title: 'Success',
        message: 'Product deleted successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      print('Error deleting product: $e');
      showCustomSnackbar(
        title: 'Error',
        message: 'Failed to delete product',
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    }
  }

  bool isLowStock(Product product) {
    if (product.stockQuantity < 10) {
      return true;
    }
    return false;
  }
}
