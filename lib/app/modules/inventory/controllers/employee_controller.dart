import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/employee.dart';
import '../../../utils/vibration_helper.dart';

class EmployeeController extends GetxController {
  final RxList<Employee> employees = <Employee>[].obs;

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();

  final _db = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    final data = await _db.getAllEmployees();
    employees.assignAll(data);
  }

  Future<void> addEmployee() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Name is required',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final salary = double.tryParse(salaryController.text.trim()) ?? 0;
    final employee = Employee(
      name: nameController.text.trim(),
      role: roleController.text.trim().isEmpty
          ? null
          : roleController.text.trim(),
      phone: phoneController.text.trim().isEmpty
          ? null
          : phoneController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? null
          : emailController.text.trim(),
      address: addressController.text.trim().isEmpty
          ? null
          : addressController.text.trim(),
      salary: salary,
    );
    await _db.saveEmployee(employee);
    await fetchEmployees();
    VibrationHelper.onSuccess();
    clearForm();
  }

  Future<void> updateEmployee(Employee employee, Employee updated) async {
    updated.id = employee.id;
    await _db.updateEmployee(updated);
    await fetchEmployees();
    VibrationHelper.onSuccess();
  }

  Future<void> deleteEmployee(int id) async {
    await _db.deleteEmployee(id);
    employees.removeWhere((e) => e.id == id);
    VibrationHelper.onImportantAction();
  }

  void setFormFromEmployee(Employee employee) {
    nameController.text = employee.name;
    roleController.text = employee.role ?? '';
    phoneController.text = employee.phone ?? '';
    emailController.text = employee.email ?? '';
    addressController.text = employee.address ?? '';
    salaryController.text = employee.salary.toStringAsFixed(0);
  }

  Employee buildEmployeeFromForm({String? existingCode}) {
    final salary = double.tryParse(salaryController.text.trim()) ?? 0;
    return Employee(
      name: nameController.text.trim(),
      role: roleController.text.trim().isEmpty
          ? null
          : roleController.text.trim(),
      phone: phoneController.text.trim().isEmpty
          ? null
          : phoneController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? null
          : emailController.text.trim(),
      address: addressController.text.trim().isEmpty
          ? null
          : addressController.text.trim(),
      salary: salary,
      employeeCode: existingCode,
    );
  }

  void clearForm() {
    nameController.clear();
    roleController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    salaryController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    roleController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    salaryController.dispose();
    super.onClose();
  }
}

