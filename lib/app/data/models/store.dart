class Store {
  int? id;

  late String name;
  late String address;
  late String phone;
  late String email;
  late String businessType;
  late bool isActive;
  String? website;
  String? description;
  String? logo;
  String? settings;
  late DateTime createdAt;
  DateTime? updatedAt;

  Store({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.businessType,
    this.website,
    this.description,
    this.logo,
    this.settings,
    this.isActive = true,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }

  // Update store settings
  void updateSettings(String newSettings) {
    settings = newSettings;
    updatedAt = DateTime.now();
  }

  // Update store information
  void updateStoreInfo({
    String? name,
    String? address,
    String? phone,
    String? email,
    String? businessType,
    String? website,
    String? description,
    String? logo,
  }) {
    if (name != null) this.name = name;
    if (address != null) this.address = address;
    if (phone != null) this.phone = phone;
    if (email != null) this.email = email;
    if (businessType != null) this.businessType = businessType;
    if (website != null) this.website = website;
    if (description != null) this.description = description;
    if (logo != null) this.logo = logo;
    updatedAt = DateTime.now();
  }
}
