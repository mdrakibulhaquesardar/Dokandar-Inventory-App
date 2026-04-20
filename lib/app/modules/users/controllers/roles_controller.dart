import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/role.dart';
import '../../../data/models/permission.dart';

class RolesController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();

  final RxList<Role> roles = <Role>[].obs;
  final RxList<Permission> permissions = <Permission>[].obs;
  final RxBool isLoading = false.obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final RxList<String> selectedPermissionIds = <String>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Role? editingRole;

  @override
  void onInit() {
    super.onInit();
    loadRoles();
    loadPermissions();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> loadRoles() async {
    isLoading.value = true;
    try {
      final allRoles = await _databaseService.getAllRoles();
      roles.value = allRoles;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load roles');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPermissions() async {
    try {
      final allPermissions = await _databaseService.getAllPermissions();
      permissions.value = allPermissions;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load permissions');
    }
  }

  List<Permission> getPermissionsByCategory(PermissionCategory category) {
    return permissions.where((p) => p.category == category).toList();
  }

  void togglePermission(String permissionId) {
    if (selectedPermissionIds.contains(permissionId)) {
      selectedPermissionIds.remove(permissionId);
    } else {
      selectedPermissionIds.add(permissionId);
    }
  }

  bool isPermissionSelected(String permissionId) {
    return selectedPermissionIds.contains(permissionId);
  }

  void startEditing(Role role) {
    editingRole = role;
    nameController.text = role.name;
    descriptionController.text = role.description;
    selectedPermissionIds.value = List.from(role.permissionIds);
  }

  void cancelEditing() {
    editingRole = null;
    nameController.clear();
    descriptionController.clear();
    selectedPermissionIds.clear();
  }

  Future<void> saveRole() async {
    if (!formKey.currentState!.validate()) return;

    try {
      if (editingRole != null) {
        // Update existing role
        final updatedRole = Role(
          id: editingRole!.id,
          name: nameController.text,
          description: descriptionController.text,
          permissionIds: List.from(selectedPermissionIds),
          createdAt: editingRole!.createdAt,
          updatedAt: DateTime.now(),
        );
        await _databaseService.updateRole(updatedRole);
        Get.snackbar('Success', 'Role updated successfully');
      } else {
        // Add new role
        final newRole = Role(
          name: nameController.text,
          description: descriptionController.text,
          permissionIds: List.from(selectedPermissionIds),
          createdAt: DateTime.now(),
        );
        await _databaseService.saveRole(newRole);
        Get.snackbar('Success', 'Role added successfully');
      }

      await loadRoles();
      cancelEditing();
      if (Get.isBottomSheetOpen ?? false) {
        Get.back();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save role');
    }
  }

  Future<void> deleteRole(int? id) async {
    if (id == null) return;
    try {
      await _databaseService.deleteRole(id);
      await loadRoles();
      Get.snackbar('Success', 'Role deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete role');
    }
  }
}
