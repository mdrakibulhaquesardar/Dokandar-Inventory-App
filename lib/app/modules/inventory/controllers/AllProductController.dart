import 'package:dokandar_app_inventory/app/data/models/category.dart';
import 'package:dokandar_app_inventory/app/data/services/database_service.dart';
import 'package:get/get.dart';

import '../../../data/models/product.dart';

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
      Get.snackbar('Success', 'Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
      Get.snackbar('Error', 'Failed to add product');
    }
  }

  void updateProduct(Product product) async {
    try {
      await _databaseService.saveProduct(product);
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
      }
      Get.snackbar('Success', 'Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
      Get.snackbar('Error', 'Failed to update product');
    }
  }

  void deleteProduct(int id) async {
    try {
      await _databaseService.deleteProduct(id);
      products.removeWhere((product) => product.id == id);
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (e) {
      print('Error deleting product: $e');
      Get.snackbar('Error', 'Failed to delete product');
    }
  }
}
