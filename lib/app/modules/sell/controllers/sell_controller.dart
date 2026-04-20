import 'package:dokandar_app_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/product.dart';
import '../../../data/models/sale.dart';
import '../../../../mock/mock_data_service.dart';
import '../../../utils/vibration_helper.dart';

class SellController extends GetxController {
  final _mock = const MockDataService();

  final RxList<SaleItem> cartItems = <SaleItem>[].obs;
  final RxDouble total = 0.0.obs;

  final RxList<Customer> customers = <Customer>[].obs;

  final RxList<Product> searchResults = <Product>[].obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(cartItems, (_) => calculateTotal());
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    final allCustomers = await _mock.getAllCustomers();
    customers.assignAll(allCustomers);
  }

  void addToCart(Product product) {
    final existingItem = cartItems.firstWhere(
      (item) => item.productId == (product.id ?? 0),
      orElse: () => SaleItem.create(
        productName: product.name,
        productId: product.id ?? 0,
        quantity: 1,
        unitPrice: product.unitPrice,
      ),
    );

    if (!cartItems.contains(existingItem)) {
      existingItem.totalPrice = existingItem.quantity * existingItem.unitPrice;
      cartItems.add(existingItem);
      VibrationHelper.onButtonTap();
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

  final RxDouble discount = 0.0.obs;
  final RxDouble dueAmount = 0.0.obs;
  final RxString orderNote = ''.obs;
  final RxString selectedCustomerId = ''.obs;

  void setDiscount(String value) {
    try {
      double newDiscount = double.parse(value);
      double cartTotal = cartItems.fold(
        0.0,
        (sum, item) => sum + item.totalPrice,
      );
      if (newDiscount > cartTotal) {
        newDiscount = cartTotal;
      }
      discount.value = newDiscount;
      calculateTotal();
    } catch (_) {
      discount.value = 0;
      calculateTotal();
    }
  }

  void setDueAmount(String value) {
    try {
      dueAmount.value = double.parse(value);
    } catch (_) {
      dueAmount.value = 0;
    }
  }

  void setOrderNote(String value) {
    orderNote.value = value;
  }

  void setSelectedCustomer(String value) {
    selectedCustomerId.value = value;
  }

  void calculateTotal() {
    total.value = cartItems.fold(
          0.0,
          (sum, item) => sum + item.totalPrice,
        ) -
        discount.value;

    if (total.value < 0) {
      total.value = 0;
    }
  }

  Future<void> processSale() async {
    if (cartItems.isEmpty) {
      Get.snackbar('Info', 'Cart is empty (UI demo only)');
      return;
    }

    clearCart();
    VibrationHelper.onSuccess();
    Get.find<HomeController>().refresh();
    Fluttertoast.showToast(
      msg: 'Action completed (demo only, no data saved)',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.green,
    );
  }

  void clearCart() {
    cartItems.clear();
    discount.value = 0;
    dueAmount.value = 0;
    orderNote.value = '';
    selectedCustomerId.value = '';
    calculateTotal();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    _mock.searchProducts(query).then((products) {
      searchResults.value = products;
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to search items: ${error.toString()}');
    });
  }
}
