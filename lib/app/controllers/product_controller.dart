import 'package:get/get.dart';
import '../data/models/product.dart';
import '../data/services/database_service.dart';

class ProductController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();

  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      error.value = '';
      final loadedProducts = await _databaseService.getAllProducts();
      products.assignAll(loadedProducts);
    } catch (e) {
      error.value = 'Failed to load products: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _databaseService.saveProduct(product);
      products.add(product);
    } catch (e) {
      error.value = 'Failed to add product: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _databaseService.saveProduct(product);
      final index = products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        products[index] = product;
      }
    } catch (e) {
      error.value = 'Failed to update product: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _databaseService.deleteProduct(id);
      products.removeWhere((product) => product.id == id);
    } catch (e) {
      error.value = 'Failed to delete product: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  List<Product> getLowStockProducts() {
    return products.where((product) => product.isLowStock).toList();
  }

  // List<Product> searchProducts(String query) {
  //   if (query.isEmpty) return products;
  //   return products
  //       .where((product) =>
  //           product.name.toLowerCase().contains(query.toLowerCase()) ||
  //           product.sku.toLowerCase().contains(query.toLowerCase()) ||
  //           product.category.name!.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  // }
}
