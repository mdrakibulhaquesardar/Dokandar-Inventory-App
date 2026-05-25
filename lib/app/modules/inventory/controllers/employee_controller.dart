import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/database_service.dart';
import '../../../data/models/employee.dart';
import '../../../utils/vibration_helper.dart';

class EmployeeController extends GetxController {
  final RxList<Employee> employees = <Employee>[].obs;
  final RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final salaryController = TextEditingController();
  final notesController = TextEditingController();

  final isActive = true.obs;
  final profileImage = ''.obs;
  final joinedAt = Rxn<DateTime>();

  final searchQuery = ''.obs;
  final statusFilter = 'All'.obs;

  final _db = Get.find<DatabaseService>();

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;
      final data = await _db.getAllEmployees();
      employees.assignAll(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch employees: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Reactive Stats
  int get totalEmployeesCount => employees.length;

  int get activeEmployeesCount =>
      employees.where((e) => e.isActive).length;

  int get inactiveEmployeesCount =>
      employees.where((e) => !e.isActive).length;

  double get totalMonthlyPayroll =>
      employees.where((e) => e.isActive).fold(0.0, (sum, e) => sum + e.salary);

  // Filtered List for View
  List<Employee> get filteredEmployees {
    final query = searchQuery.value.toLowerCase().trim();
    final filter = statusFilter.value;

    return employees.where((e) {
      final matchesSearch = query.isEmpty ||
          e.name.toLowerCase().contains(query) ||
          (e.role?.toLowerCase().contains(query) ?? false) ||
          (e.phone?.toLowerCase().contains(query) ?? false) ||
          (e.email?.toLowerCase().contains(query) ?? false) ||
          (e.employeeCode?.toLowerCase().contains(query) ?? false);

      final matchesStatus = filter == 'All' ||
          (filter == 'Active' && e.isActive) ||
          (filter == 'Inactive' && !e.isActive);

      return matchesSearch && matchesStatus;
    }).toList();
  }

  Future<bool> addEmployee() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      isLoading.value = true;
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
        profileImage: profileImage.value.isEmpty ? null : profileImage.value,
        isActive: isActive.value,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        joinedAt: joinedAt.value,
      );
      await _db.saveEmployee(employee);
      await fetchEmployees();
      VibrationHelper.onSuccess();
      clearForm();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to add employee: $e',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateEmployeeDetails(Employee original) async {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    try {
      isLoading.value = true;
      final salary = double.tryParse(salaryController.text.trim()) ?? 0;
      final updated = Employee(
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
        employeeCode: original.employeeCode,
        profileImage: profileImage.value.isEmpty ? null : profileImage.value,
        isActive: isActive.value,
        notes: notesController.text.trim().isEmpty
            ? null
            : notesController.text.trim(),
        joinedAt: joinedAt.value ?? original.joinedAt,
      );
      updated.id = original.id;
      updated.paid = original.paid;
      updated.due = original.due;

      await _db.updateEmployee(updated);
      await fetchEmployees();
      VibrationHelper.onSuccess();
      clearForm();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update employee: $e',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      isLoading.value = true;
      await _db.deleteEmployee(id);
      employees.removeWhere((e) => e.id == id);
      VibrationHelper.onImportantAction();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete employee: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void setFormFromEmployee(Employee employee) {
    nameController.text = employee.name;
    roleController.text = employee.role ?? '';
    phoneController.text = employee.phone ?? '';
    emailController.text = employee.email ?? '';
    addressController.text = employee.address ?? '';
    salaryController.text = employee.salary > 0
        ? employee.salary.toStringAsFixed(0)
        : '';
    notesController.text = employee.notes ?? '';
    isActive.value = employee.isActive;
    profileImage.value = employee.profileImage ?? '';
    joinedAt.value = employee.joinedAt;
  }

  void clearForm() {
    nameController.clear();
    roleController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    salaryController.clear();
    notesController.clear();
    isActive.value = true;
    profileImage.value = '';
    joinedAt.value = null;
  }

  @override
  void onClose() {
    nameController.dispose();
    roleController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    salaryController.dispose();
    notesController.dispose();
    super.onClose();
  }
}

