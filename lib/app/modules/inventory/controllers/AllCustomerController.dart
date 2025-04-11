
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/customer.dart';
import '../../../data/services/database_service.dart';
import '../../../widgets/showCustomSnackbar.dart';

class AllCustomerController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final RxList<Customer> customers = <Customer>[].obs;
  final RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> loadCustomers() async {
    isLoading.value = true;
    try {
      final allCustomers = await _databaseService.getAllCustomers();
      customers.value = allCustomers;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load customers');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCustomer(String name, String phone, String? address) async {
    try {
      final customer = Customer(
        name: name,
        phone: phone,
        address: address,
      );
      await _databaseService.saveCustomer(customer);
      await loadCustomers();
      showCustomSnackbar(
        title: 'Success',
        message: 'Customer added successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
      // Clear the text fields
      nameController.clear();
      phoneController.clear();
      addressController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add customer');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      await _databaseService.updateCustomer(customer);
      await loadCustomers();
      showCustomSnackbar(
        title: 'Success',
        message: 'Customer updated successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to update customer');
    }
  }

  Future<void> deleteCustomer(int customerId) async {
    try {
      await _databaseService.deleteCustomer(customerId);
      await loadCustomers();
      showCustomSnackbar(
        title: 'Success',
        message: 'Customer deleted successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete customer');
    }
  }
}
