/// File item model for File Management module
class FileItem {
  final String id;
  final String name;
  final String path;
  final FileType type;
  final int? size; // in bytes
  final DateTime createdAt;
  final DateTime? modifiedAt;
  final String? thumbnailUrl;
  final String? mimeType;

  FileItem({
    required this.id,
    required this.name,
    required this.path,
    required this.type,
    this.size,
    required this.createdAt,
    this.modifiedAt,
    this.thumbnailUrl,
    this.mimeType,
  });

  String get formattedSize {
    if (size == null) return 'Unknown';
    if (size! < 1024) return '${size}B';
    if (size! < 1024 * 1024) return '${(size! / 1024).toStringAsFixed(1)}KB';
    if (size! < 1024 * 1024 * 1024) {
      return '${(size! / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(size! / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
}

enum FileType {
  file,
  folder,
  image,
  document,
  video,
  audio,
  other,
}
