class Role {
  int? id;
  final String name;
  final String description;
  final List<String> permissionIds;
  final DateTime createdAt;
  DateTime? updatedAt;

  Role({
    this.id,
    required this.name,
    required this.description,
    this.permissionIds = const [],
    required this.createdAt,
    this.updatedAt,
  });
}
