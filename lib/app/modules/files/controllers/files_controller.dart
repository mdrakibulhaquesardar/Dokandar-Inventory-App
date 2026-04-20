import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/file_item.dart';

class FilesController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();

  final RxList<FileItem> files = <FileItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString currentPath = '/'.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadFiles();
  }

  Future<void> loadFiles({String? path}) async {
    isLoading.value = true;
    try {
      final allFiles = await _databaseService.getAllFiles(path: path);
      files.value = allFiles;
      if (path != null) {
        currentPath.value = path;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load files');
    } finally {
      isLoading.value = false;
    }
  }

  List<FileItem> get filteredFiles {
    if (searchQuery.value.isEmpty) return files.toList();
    final query = searchQuery.value.toLowerCase();
    return files
        .where((file) => file.name.toLowerCase().contains(query))
        .toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void navigateToFolder(String path) {
    loadFiles(path: path);
  }

  void navigateUp() {
    if (currentPath.value == '/') return;
    final parts = currentPath.value.split('/');
    parts.removeLast();
    final newPath = parts.isEmpty ? '/' : parts.join('/');
    loadFiles(path: newPath);
  }

  Future<void> deleteFile(String id) async {
    try {
      await _databaseService.deleteFile(id);
      await loadFiles(
          path: currentPath.value == '/' ? null : currentPath.value);
      Get.snackbar('Success', 'File deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete file');
    }
  }

  Future<void> uploadFile(String name, FileType type, int size) async {
    try {
      final newFile = FileItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        path: '${currentPath.value}/$name',
        type: type,
        size: size,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      await _databaseService.uploadFile(newFile);
      await loadFiles(
          path: currentPath.value == '/' ? null : currentPath.value);
      Get.snackbar('Success', 'File uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload file');
    }
  }
}
