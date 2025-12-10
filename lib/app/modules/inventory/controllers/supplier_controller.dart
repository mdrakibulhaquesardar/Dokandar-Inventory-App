import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/supplier.dart';
import '../../../utils/vibration_helper.dart';

class SupplierController extends GetxController {
  final RxList<Supplier> suppliers = <Supplier>[].obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final companyController = TextEditingController();
  final addressController = TextEditingController();

  final _db = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    final data = await _db.getAllSuppliers();
    suppliers.assignAll(data);
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
    VibrationHelper.onImportantAction();
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
    super.onClose();
  }
}

