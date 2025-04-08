import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  late String name;
  late String email;
  late String phone;
  late String password;
  late String role;
  late bool isActive;
  late DateTime createdAt;
  DateTime? updatedAt;
  String? address;
  Map<String, dynamic>? settings;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    this.address,
    this.settings,
    this.isActive = true,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }

  // Update user settings
  void updateSettings(Map<String, dynamic> newSettings) {
    settings = newSettings;
    updatedAt = DateTime.now();
  }

  // Update user profile
  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    if (name != null) this.name = name;
    if (email != null) this.email = email;
    if (phone != null) this.phone = phone;
    if (address != null) this.address = address;
    updatedAt = DateTime.now();
  }

  // Change password
  void changePassword(String newPassword) {
    password = newPassword;
    updatedAt = DateTime.now();
  }
}
