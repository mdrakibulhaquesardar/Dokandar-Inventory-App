class Permission {
  final String id;
  final String name;
  final String description;
  final PermissionCategory category;

  Permission({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });
}

enum PermissionCategory {
  dashboard,
  records,
  reports,
  users,
  settings,
  files,
  analytics,
  notifications,
}
