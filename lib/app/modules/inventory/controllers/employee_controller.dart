import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/employee.dart';
import '../../../utils/vibration_helper.dart';

class EmployeeController extends GetxController {
  DatabaseService get _db => Get.find<DatabaseService>();
  final employees = <Employee>[].obs;

  // Form controllers
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    final data = await _db.getAllEmployees();
    employees.assignAll(data);
  }

  void setFormFromEmployee(Employee employee) {
    nameController.text = employee.name;
    roleController.text = employee.role ?? '';
    phoneController.text = employee.phone ?? '';
    emailController.text = employee.email ?? '';
    addressController.text = employee.address ?? '';
    salaryController.text = employee.salary.toStringAsFixed(2);
  }

  Employee buildEmployeeFromForm({String? existingCode}) {
    final salary = double.tryParse(salaryController.text.trim()) ?? 0;
    return Employee(
      name: nameController.text.trim(),
      employeeCode: existingCode,
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
  }

  Future<void> addEmployee() async {
    final employee = buildEmployeeFromForm();
    await _db.saveEmployee(employee);
    employees.add(employee);
    VibrationHelper.onSuccess();
  }

  Future<void> updateEmployee(Employee original, Employee updated) async {
    updated.id = original.id;
    await _db.updateEmployee(updated);
    final index = employees.indexWhere((e) => e.id == original.id);
    if (index != -1) {
      employees[index] = updated;
    }
    VibrationHelper.onSuccess();
  }

  Future<void> deleteEmployee(int? id) async {
    if (id == null) return;
    await _db.deleteEmployee(id);
    employees.removeWhere((e) => e.id == id);
    VibrationHelper.onImportantAction();
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
