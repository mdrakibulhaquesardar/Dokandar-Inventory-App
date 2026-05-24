import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/supplier.dart';
import '../../../utils/vibration_helper.dart';

class SupplierController extends GetxController {
  final RxList<Supplier> suppliers = <Supplier>[].obs;
  final RxList<Supplier> filteredSuppliers = <Supplier>[].obs;
  final RxString searchQuery = ''.obs;

  // Stats (reactive)
  final RxInt totalSuppliersCount = 0.obs;
  final RxDouble totalDueAmount = 0.0.obs;
  final RxDouble totalPaidAmount = 0.0.obs;
  final RxDouble totalPurchaseAmount = 0.0.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();
  final paymentController = TextEditingController();
  final searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _db = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();
    // Keep filteredSuppliers in sync with search query
    ever(searchQuery, (_) => _applyFilter());
    ever(suppliers, (_) => _applyFilter());
  }

  Future<void> fetchSuppliers() async {
    final data = await _db.getAllSuppliers();
    suppliers.assignAll(data);
    _computeStats();
  }

  void _applyFilter() {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) {
      filteredSuppliers.assignAll(suppliers);
    } else {
      filteredSuppliers.assignAll(
        suppliers.where((s) =>
            s.name.toLowerCase().contains(q) ||
            (s.company?.toLowerCase().contains(q) ?? false) ||
            (s.phone?.contains(q) ?? false) ||
            (s.email?.toLowerCase().contains(q) ?? false)),
      );
    }
  }

  void _computeStats() {
    totalSuppliersCount.value = suppliers.length;
    totalDueAmount.value =
        suppliers.fold(0.0, (sum, s) => sum + s.totalDue);
    totalPaidAmount.value =
        suppliers.fold(0.0, (sum, s) => sum + s.totalPaid);
    totalPurchaseAmount.value =
        suppliers.fold(0.0, (sum, s) => sum + s.totalPurchase);
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  Future<void> addSupplier() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Supplier name is required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final supplier = Supplier(
      name: nameController.text.trim(),
      phone: phoneController.text.trim().isEmpty
          ? null
          : phoneController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? null
          : emailController.text.trim(),
      company: companyController.text.trim().isEmpty
          ? null
          : companyController.text.trim(),
      address: addressController.text.trim().isEmpty
          ? null
          : addressController.text.trim(),
    );
    await _db.saveSupplier(supplier);
    await fetchSuppliers();
    VibrationHelper.onSuccess();
    clearForm();
  }

  Future<void> updateSupplier(Supplier supplier, Supplier updated) async {
    updated.id = supplier.id;
    await _db.updateSupplier(updated);
    await fetchSuppliers();
    VibrationHelper.onSuccess();
  }

  Future<void> deleteSupplier(int id) async {
    await _db.deleteSupplier(id);
    suppliers.removeWhere((s) => s.id == id);
    _computeStats();
    VibrationHelper.onImportantAction();
  }

  /// Record a payment for a supplier (reduces totalDue)
  Future<void> recordPayment(Supplier supplier) async {
    final amountText = paymentController.text.trim();
    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      Get.snackbar('Error', 'Please enter a valid payment amount',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (amount > supplier.totalDue) {
      Get.snackbar('Error', 'Payment amount cannot exceed total due',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    supplier.recordPayment(amount);
    await _db.updateSupplier(supplier);
    await fetchSuppliers();
    VibrationHelper.onSuccess();
    paymentController.clear();
  }

  void setFormFromSupplier(Supplier supplier) {
    nameController.text = supplier.name;
    phoneController.text = supplier.phone ?? '';
    emailController.text = supplier.email ?? '';
    companyController.text = supplier.company ?? '';
    addressController.text = supplier.address ?? '';
  }

  Supplier buildSupplierFromForm({String? existingCode}) {
    return Supplier(
      name: nameController.text.trim(),
      supplierCode: existingCode,
      phone: phoneController.text.trim().isEmpty
          ? null
          : phoneController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? null
          : emailController.text.trim(),
      company: companyController.text.trim().isEmpty
          ? null
          : companyController.text.trim(),
      address: addressController.text.trim().isEmpty
          ? null
          : addressController.text.trim(),
    );
  }

  void clearForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    companyController.clear();
    addressController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    addressController.dispose();
    paymentController.dispose();
    searchController.dispose();
    super.onClose();
  }
}

