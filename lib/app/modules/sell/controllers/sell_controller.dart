import 'package:dokandar_app_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/product.dart';
import '../../../data/models/sale.dart';
import '../../../data/services/database_service.dart';

class SellController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final RxList<SaleItem> cartItems = <SaleItem>[].obs;
  final RxDouble total = 0.0.obs;


  // all Customers
   final RxList<Customer> customers = <Customer>[].obs;

  //searchResults

  final RxList<Product> searchResults = <Product>[].obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(cartItems, (_) => calculateTotal());
    fetchCustomers();
  }


  void fetchCustomers() async {
    try {
      final allCustomers = await _databaseService.getAllCustomers();
      customers.assignAll(allCustomers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch customers: ${e.toString()}');
    }
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

  final RxDouble discount = 0.0.obs;
  final RxDouble dueAmount = 0.0.obs;
  final RxString orderNote = ''.obs;
  final RxString selectedCustomerId = ''.obs;

  void setDiscount(String value) {
    try {
      double newDiscount = double.parse(value);
      // Calculate the total price of all cart items
      double cartTotal = cartItems.fold(
        0.0,
        (sum, item) => sum + item.totalPrice,
      );
      // Ensure discount doesn't exceed cart total
      if (newDiscount > cartTotal) {
        newDiscount = cartTotal;
      }
      discount.value = newDiscount;
      calculateTotal();
    } catch (e) {
      discount.value = 0;
      calculateTotal();
    }
  }

  void setDueAmount(String value) {
    try {
      dueAmount.value = double.parse(value);
    } catch (e) {
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
      0,
      (sum, item) => sum + item.totalPrice.toInt(),
    ) - discount.value;

    if (total.value < 0) {
      total.value = 0;
      discount.value = cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );
    }
  }

  Future<void> processSale() async {
    if (cartItems.isEmpty) {
      Get.snackbar('Error', 'Cart is empty');
      return;
    }

    if (dueAmount.value > total.value) {
      Get.snackbar('Error', 'Due amount cannot be greater than total amount');
      return;
    }

    final sale = Sale(
      customerId: int.tryParse(selectedCustomerId.value) ?? 0,
      items: cartItems.toList(growable: false),
      totalAmount: total.value,
      paidAmount: total.value - dueAmount.value,
      dueAmount: dueAmount.value,
      discount: discount.value,
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
      clearCart();
      Get.back();
      Get.find<HomeController>().refresh();
      // show toast message
      Fluttertoast.showToast(
        msg: 'Sale processed successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
      );

    } catch (e) {
      Get.snackbar('Error', 'Failed to process sale: ${e.toString()}');
    }
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
  _databaseService.searchProducts(query).then((products) {
    // Filter out products with zero stock
    searchResults.value = products.where((product) => product.stockQuantity > 0).toList();
  }).catchError((error) {
    Get.snackbar('Error', 'Failed to search products: ${error.toString()}');
  });
}
}
