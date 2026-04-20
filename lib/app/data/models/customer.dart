class Customer {
  int? id;

  late String name;
  late String phone;
  String? address;
  late double totalPurchases;
  late double totalDue;
  late DateTime createdAt;
  DateTime? updatedAt;
  late bool isActive;
  late bool hasDue;

  Customer({
    required this.name,
    required this.phone,
    this.address,
    this.totalPurchases = 0,
    this.totalDue = 0,
    this.isActive = true,
    this.hasDue = false,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }

  // Update total purchases
  void updateTotalPurchases(double amount) {
    totalPurchases += amount;
    updatedAt = DateTime.now();
  }

  // Update total due

  void updateTotalDue(double amount) {
    totalDue += amount;
    updatedAt = DateTime.now();
  }

  // Check if the customer has due
  bool checkHasDue() {
    hasDue = totalDue > 0;
    return hasDue;
  }

  // update has due
  void updateHasDue(bool value) {
    hasDue = value;
    updatedAt = DateTime.now();
  }
  //copyWith method

  Customer copyWith({
    String? name,
    String? phone,
    String? address,
    double? totalPurchases,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return Customer(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      isActive: isActive ?? this.isActive,
    );
  }
}
