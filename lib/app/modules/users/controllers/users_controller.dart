import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/team_member.dart';
import '../../../data/models/role.dart';

class UsersController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();

  final RxList<TeamMember> users = <TeamMember>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final Rxn<String> selectedRole = Rxn<String>();
  final Rx<UserStatus?> selectedStatus = Rx<UserStatus?>(null);
  final Rxn<String> selectedDepartment = Rxn<String>();

  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final departmentController = TextEditingController();
  final roleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TeamMember? editingUser;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
    loadRoles();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    departmentController.dispose();
    roleController.dispose();
    super.onClose();
  }

  Future<void> loadUsers() async {
    isLoading.value = true;
    try {
      final allUsers = await _databaseService.getAllTeamMembers();
      users.value = allUsers;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users');
    } finally {
      isLoading.value = false;
    }
  }

  List<TeamMember> get filteredUsers {
    var filtered = users.toList();

    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filtered = filtered.where((user) {
        return user.name.toLowerCase().contains(query) ||
            user.email.toLowerCase().contains(query) ||
            user.phone.contains(query);
      }).toList();
    }

    if (selectedRole.value != null) {
      filtered =
          filtered.where((user) => user.role == selectedRole.value!).toList();
    }

    if (selectedStatus.value != null) {
      filtered = filtered
          .where((user) => user.status == selectedStatus.value)
          .toList();
    }

    if (selectedDepartment.value != null) {
      filtered = filtered
          .where((user) => user.department == selectedDepartment.value!)
          .toList();
    }

    return filtered;
  }

  List<String> get departments {
    return users.map((u) => u.department).toSet().toList()..sort();
  }

  List<String> get roles {
    return users.map((u) => u.role).toSet().toList()..sort();
  }

  Future<void> loadRoles() async {
    // Roles will be loaded by RolesController
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setSelectedRole(String? role) {
    selectedRole.value = role;
  }

  void setSelectedStatus(UserStatus? status) {
    selectedStatus.value = status;
  }

  void setSelectedDepartment(String? department) {
    selectedDepartment.value = department;
  }

  void clearFilters() {
    searchQuery.value = '';
    selectedRole.value = null;
    selectedStatus.value = null;
    selectedDepartment.value = null;
  }

  void startEditing(TeamMember user) {
    editingUser = user;
    nameController.text = user.name;
    emailController.text = user.email;
    phoneController.text = user.phone;
    departmentController.text = user.department;
    roleController.text = user.role;
  }

  void cancelEditing() {
    editingUser = null;
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    departmentController.clear();
    roleController.clear();
  }

  Future<void> saveUser() async {
    if (!formKey.currentState!.validate()) return;

    try {
      if (editingUser != null) {
        // Update existing user
        final updatedUser = TeamMember(
          id: editingUser!.id,
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          role: roleController.text,
          department: departmentController.text,
          status: editingUser!.status,
          avatarUrl: editingUser!.avatarUrl,
          createdAt: editingUser!.createdAt,
          updatedAt: DateTime.now(),
          assignedRoleIds: editingUser!.assignedRoleIds,
        );
        await _databaseService.updateTeamMember(updatedUser);
        Get.snackbar('Success', 'User updated successfully');
      } else {
        // Add new user
        final newUser = TeamMember(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          role: roleController.text,
          department: departmentController.text,
          status: UserStatus.active,
          createdAt: DateTime.now(),
        );
        await _databaseService.saveTeamMember(newUser);
        Get.snackbar('Success', 'User added successfully');
      }

      await loadUsers();
      cancelEditing();
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save user');
    }
  }

  Future<void> deleteUser(int? id) async {
    if (id == null) return;
    try {
      await _databaseService.deleteTeamMember(id);
      await loadUsers();
      Get.snackbar('Success', 'User deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete user');
    }
  }

  Future<void> updateUserStatus(int? id, UserStatus status) async {
    if (id == null) return;
    try {
      final user = users.firstWhere((u) => u.id == id);
      final updatedUser = TeamMember(
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        role: user.role,
        department: user.department,
        status: status,
        avatarUrl: user.avatarUrl,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
        assignedRoleIds: user.assignedRoleIds,
      );
      await _databaseService.updateTeamMember(updatedUser);
      await loadUsers();
      Get.snackbar('Success', 'User status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user status');
    }
  }
}
