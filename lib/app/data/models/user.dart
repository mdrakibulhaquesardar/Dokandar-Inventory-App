class User {
  static final User _instance = User._internal();

  factory User() {
    return _instance;
  }

  User._internal();

  int? id;

  late String name;
  late String email;
  late String phone;
  late String password;
  late String role;
  late bool isActive;
  late bool isPremium;
  late DateTime createdAt;
  DateTime? updatedAt;
  String? address;
  String? settings;

  User.init({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    this.address,
    this.settings,
    this.isActive = true,
    this.isPremium = false,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }

  // Update user settings
  void updateSettings(String newSettings) {
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
