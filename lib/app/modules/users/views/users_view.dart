import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';
import '../controllers/users_controller.dart';
import '../../../data/models/team_member.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'user_detail_view.dart';
import 'user_form_view.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});

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
        l10n.users,
        true,
        false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: themeConfig.getTextPrimaryColor(isDarkMode),
            ),
            onPressed: () =>
                _showFilterBottomSheet(context, themeConfig, isDarkMode),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: themeConfig.getSurfaceColor(isDarkMode),
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: themeConfig.getPrimaryColor(isDarkMode),
                  ),
                ),
              );
            }

            final filtered = controller.filteredUsers;

            if (filtered.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 80,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noUsersFound,
                        style: SafeGoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: themeConfig.getTextPrimaryColor(isDarkMode),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final user = filtered[index];
                  return _buildUserCard(user, themeConfig, isDarkMode, context);
                },
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () {
          controller.cancelEditing();
          Get.bottomSheet(
            UserFormView(),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  Widget _buildUserCard(
    TeamMember user,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    BuildContext context,
  ) {
    Color statusColor;
    String statusText;

    final l10n = AppLocalizations.of(context)!;
    switch (user.status) {
      case UserStatus.active:
        statusColor = Colors.green;
        statusText = l10n.active;
        break;
      case UserStatus.inactive:
        statusColor = Colors.grey;
        statusText = l10n.inactive;
        break;
      case UserStatus.suspended:
        statusColor = Colors.red;
        statusText = l10n.suspended;
        break;
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: themeConfig.getSurfaceColor(isDarkMode),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
          child: Text(
            user.name[0].toUpperCase(),
            style: SafeGoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: SafeGoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: themeConfig.getTextPrimaryColor(isDarkMode),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              user.email,
              style: SafeGoogleFonts.poppins(
                fontSize: 11,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText,
                    style: SafeGoogleFonts.poppins(
                      fontSize: 9,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  user.role,
                  style: SafeGoogleFonts.poppins(
                    fontSize: 9,
                    color: themeConfig.getTextSecondaryColor(isDarkMode),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            size: 18,
            color: themeConfig.getTextSecondaryColor(isDarkMode),
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          itemBuilder: (context) {
            final l10nLocal = AppLocalizations.of(context)!;
            return [
              PopupMenuItem(
                child: Text(l10nLocal.viewDetails),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    Get.to(() => UserDetailView(user: user));
                  });
                },
              ),
              PopupMenuItem(
                child: Text(l10nLocal.edit),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    controller.startEditing(user);
                    Get.bottomSheet(
                      UserFormView(),
                      isScrollControlled: true,
                    );
                  });
                },
              ),
              PopupMenuItem(
                child: Text(l10nLocal.delete),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    controller.deleteUser(user.id);
                  });
                },
              ),
            ];
          },
        ),
        onTap: () => Get.to(() => UserDetailView(user: user)),
      ),
    );
  }

  void _showFilterBottomSheet(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: themeConfig.getSurfaceColor(isDarkMode),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.filters,
              style: SafeGoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: themeConfig.getTextPrimaryColor(isDarkMode),
              ),
            ),
            const SizedBox(height: 12),
            Obx(() => DropdownButtonFormField<String?>(
                  value: controller.selectedRole.value,
                  decoration: InputDecoration(
                    labelText: 'Role',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                        value: null, child: Text('All Roles')),
                    ...controller.roles.map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        )),
                  ],
                  onChanged: controller.setSelectedRole,
                )),
            const SizedBox(height: 16),
            Obx(() => DropdownButtonFormField<UserStatus?>(
                  value: controller.selectedStatus.value,
                  decoration: InputDecoration(
                    labelText: 'Status',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                        value: null, child: Text('All Status')),
                    const DropdownMenuItem(
                        value: UserStatus.active, child: Text('Active')),
                    const DropdownMenuItem(
                        value: UserStatus.inactive, child: Text('Inactive')),
                    const DropdownMenuItem(
                        value: UserStatus.suspended, child: Text('Suspended')),
                  ],
                  onChanged: controller.setSelectedStatus,
                )),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.clearFilters();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.clearFilters,
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
    );
  }
}
