import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_theme_config.dart';
import '../../../utils/safe_google_fonts.dart';
import '../controllers/files_controller.dart';
import '../../../data/models/file_item.dart';
import '../../../widgets/Custom_AppBar.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class FilesView extends GetView<FilesController> {
  const FilesView({super.key});

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
        l10n.fileManagement,
        true,
        false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: controller.setSearchQuery,
              decoration: InputDecoration(
                hintText: l10n.searchFiles,
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

            final filtered = controller.filteredFiles;

            if (filtered.isEmpty) {
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_outlined,
                        size: 80,
                        color: themeConfig.getTextSecondaryColor(isDarkMode),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noFilesFound,
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
                  final file = filtered[index];
                  return _buildFileCard(file, themeConfig, isDarkMode, context);
                },
              ),
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
        onPressed: () => _showUploadDialog(context, themeConfig, isDarkMode),
        child: const Icon(Icons.upload, color: Colors.white),
      ),
    );
  }

  Widget _buildFileCard(
    FileItem file,
    AppThemeConfig themeConfig,
    bool isDarkMode,
    BuildContext context,
  ) {
    IconData icon;
    Color iconColor;

    switch (file.type) {
      case FileType.folder:
        icon = Icons.folder;
        iconColor = Colors.amber;
        break;
      case FileType.image:
        icon = Icons.image;
        iconColor = Colors.green;
        break;
      case FileType.document:
        icon = Icons.description;
        iconColor = Colors.blue;
        break;
      case FileType.video:
        icon = Icons.video_file;
        iconColor = Colors.purple;
        break;
      case FileType.audio:
        icon = Icons.audiotrack;
        iconColor = Colors.orange;
        break;
      default:
        icon = Icons.insert_drive_file;
        iconColor = themeConfig.getTextSecondaryColor(isDarkMode);
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      color: themeConfig.getSurfaceColor(isDarkMode),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: iconColor.withValues(alpha: 0.2),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        title: Text(
          file.name,
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
            if (file.type != FileType.folder)
              Text(
                file.formattedSize,
                style: SafeGoogleFonts.poppins(
                  fontSize: 11,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
              ),
            const SizedBox(height: 2),
            Text(
              _formatDate(file.createdAt),
              style: SafeGoogleFonts.poppins(
                fontSize: 9,
                color: themeConfig.getTextSecondaryColor(isDarkMode),
              ),
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
            final l10nPopup = AppLocalizations.of(context)!;
            return [
              if (file.type == FileType.folder)
                PopupMenuItem(
                  child: Text(l10nPopup.open),
                  onTap: () {
                    Future.delayed(Duration.zero, () {
                      controller.navigateToFolder(file.path);
                    });
                  },
                ),
              PopupMenuItem(
                child: Text(l10nPopup.delete),
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    controller.deleteFile(file.id);
                  });
                },
              ),
            ];
          },
        ),
        onTap: () {
          if (file.type == FileType.folder) {
            controller.navigateToFolder(file.path);
          } else {
            final l10nLocal = AppLocalizations.of(context)!;
            Get.snackbar('Demo Only', l10nLocal.filePreviewDemo);
          }
        },
      ),
    );
  }

  void _showUploadDialog(
    BuildContext context,
    AppThemeConfig themeConfig,
    bool isDarkMode,
  ) {
    final l10nLocal = AppLocalizations.of(context)!;
    Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeConfig.getSurfaceColor(isDarkMode),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10nLocal.uploadFile,
                style: SafeGoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: themeConfig.getTextPrimaryColor(isDarkMode),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                l10nLocal.fileUploadDemo,
                style: SafeGoogleFonts.poppins(
                  fontSize: 14,
                  color: themeConfig.getTextSecondaryColor(isDarkMode),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.snackbar('Demo Only', l10nLocal.fileUploadUIOnly);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeConfig.getPrimaryColor(isDarkMode),
                ),
                child: Text(l10nLocal.ok),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
