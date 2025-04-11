import 'package:get/get.dart';
import '../../../data/models/product.dart';
import '../../../data/models/sale.dart';
import '../../../data/services/database_service.dart';

class SellController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final RxList<SaleItem> cartItems = <SaleItem>[].obs;
  final RxDouble total = 0.0.obs;

  //searchResults

  final RxList<Product> searchResults = <Product>[].obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(cartItems, (_) => calculateTotal());
  }

  void addToCart(Product product) {
    final existingItem = cartItems.firstWhere(
      (item) => item.productId == product.id,
      orElse: () => SaleItem.create(
        productName: product.name,
        productId: product.id,
        quantity: 1,
        unitPrice: product.unitPrice,
      ),
    );

    if (!cartItems.contains(existingItem)) {
      existingItem.totalPrice = existingItem.quantity * existingItem.unitPrice;
      cartItems.add(existingItem);
    } else {
      increaseQuantity(cartItems.indexOf(existingItem));
    }
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  void increaseQuantity(int index) {
    final item = cartItems[index];
    item.quantity++;
    item.totalPrice = item.quantity * item.unitPrice;
    cartItems[index] = item;
  }

  void decreaseQuantity(int index) {
    final item = cartItems[index];
    if (item.quantity > 1) {
      item.quantity--;
      item.totalPrice = item.quantity * item.unitPrice;
      cartItems[index] = item;
    } else {
      removeFromCart(index);
    }
  }

  double getQuantity(int index) {
    return cartItems[index].quantity;
  }

  void calculateTotal() {
    total.value = cartItems.fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );
    printInfo(
      info: 'Total amount: ${total.value}',
    );
  }

  Future<void> processSale() async {
    if (cartItems.isEmpty) return;

    final sale = Sale(
      customerId: 424, // Assuming customer ID is not needed for now
      items: cartItems.map((item) => SaleItem()).toList(
            growable: false,
          ),
      totalAmount: total.value,
      paidAmount: total.value,
      invoiceNumber: 'INV-${DateTime.now().millisecondsSinceEpoch}',
    );

    try {
      await _databaseService.saveSale(sale);
      // Update product quantities
      for (var item in cartItems) {
        final product = await _databaseService.getProductById(item.productId);
        if (product != null) {
          product.stockQuantity -= item.quantity;
          await _databaseService.saveProduct(product);
        }
      }
      cartItems.clear();
      calculateTotal();
      Get.snackbar('Success', 'Sale completed successfully');
      printInfo(
        info: 'Sale completed successfully',

      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to process sale: ${e.toString()}');
    }
  }

  void clearCart() {
    cartItems.clear();
    calculateTotal();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    _databaseService.searchProducts(query).then((products) {
      searchResults.value = products;
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to search products: ${error.toString()}');
    });
  }
}
