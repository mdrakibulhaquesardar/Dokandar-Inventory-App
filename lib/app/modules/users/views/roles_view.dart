import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../controllers/roles_controller.dart';
import '../../../data/models/role.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'permissions_view.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class RolesView extends GetView<RolesController> {
  const RolesView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeConfig = Get.find<AppThemeConfig>();
    final isDarkMode = Get.isDarkMode;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: themeConfig.getBackgroundColor(isDarkMode),
      appBar: customAppBar(
        themeConfig,
        isDarkMode,
        l10n.rolesPermissions,
        true,
        false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: themeConfig.getPrimaryColor(isDarkMode),
            ),
          );
        }

        if (controller.roles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 80,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.noRolesFound,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.roles.length,
          itemBuilder: (context, index) {
            final role = controller.roles[index];
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 8),
              color: themeConfig.getSurfaceColor(isDarkMode),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  child: Icon(Icons.shield, size: 18, color: Colors.white),
                ),
                title: Text(
                  role.name,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: themeConfig.getTextPrimaryColor(isDarkMode),
                  ),
                ),
                subtitle: Text(
                  role.description,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 11,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${role.permissionIds.length} ${l10n.permissionsLabel}',
                      style: SafeGoogleFonts.poppins(
                        fontSize: 10,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline, size: 16),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: () => controller.deleteRole(role.id),
                      color: Colors.red,
                    ),
                  ],
                ),
                onTap: () => Get.to(() => PermissionsView(role: role)),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () {
          controller.cancelEditing();
          _showRoleForm(context, themeConfig, isDarkMode);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showRoleForm(
      BuildContext context, AppThemeConfig themeConfig, bool isDarkMode) {
    final l10nLocal = AppLocalizations.of(context)!;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.editingRole != null
                          ? l10nLocal.editRole
                          : l10nLocal.addRole,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: themeConfig.getTextPrimaryColor(isDarkMode),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 32, minHeight: 32),
                      onPressed: () {
                        controller.cancelEditing();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: l10nLocal.roleName,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? l10nLocal.roleRequired : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: l10nLocal.description,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? l10nLocal.description : null,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.saveRole,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      controller.editingRole != null
                          ? l10nLocal.updateRole
                          : l10nLocal.addRole,
                      style: SafeGoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
