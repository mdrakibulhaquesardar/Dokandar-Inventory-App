
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/customer.dart';
import '../../../core/services/database_service.dart';
import '../../../config/app_config.dart';
import '../../../widgets/showCustomSnackbar.dart';
import '../../../utils/vibration_helper.dart';
import '../../home/controllers/home_controller.dart';

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
      // Check customer limit if subscription is enabled
      if (AppConfig.enableSubscription) {
        final totalCustomers = await _databaseService.getTotalCustomers();
        if (totalCustomers >= AppConfig.freePlanCustomerLimit) {
          showCustomSnackbar(
            title: 'Limit Reached',
            message: 'You have reached the free plan limit of ${AppConfig.freePlanCustomerLimit} customers. Please upgrade to add more customers.',
            backgroundColor: Colors.orange,
            icon: Icons.warning,
          );
          return;
        }
      }

      final customer = Customer(
        name: name,
        phone: phone,
        address: address,
      );
      await _databaseService.saveCustomer(customer);
      await loadCustomers();
      VibrationHelper.onSuccess();
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
      Get.find<HomeController>().refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to add customer');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      await _databaseService.updateCustomer(customer);
      await loadCustomers();
      VibrationHelper.onSuccess();
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
      VibrationHelper.onImportantAction();
      showCustomSnackbar(
        title: 'Success',
        message: 'Customer deleted successfully',
        backgroundColor: Colors.green,
        icon: Icons.check_circle,

      );
      Get.find<HomeController>().refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete customer');
    }
  }
}
