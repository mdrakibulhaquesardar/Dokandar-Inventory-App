class TeamMember {
  int? id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String department;
  final UserStatus status;
  final String? avatarUrl;
  final DateTime createdAt;
  DateTime? updatedAt;
  final List<String> assignedRoleIds;

  TeamMember({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.department,
    this.status = UserStatus.active,
    this.avatarUrl,
    required this.createdAt,
    this.updatedAt,
    this.assignedRoleIds = const [],
  });
}

enum UserStatus {
  active,
  inactive,
  suspended,
}
