import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'customer.g.dart';

@collection
class Customer {
  Id id = Isar.autoIncrement;

  late String name;
  late String phone;
  String? address;
  late double totalPurchases;
  late DateTime createdAt;
  DateTime? updatedAt;
  late bool isActive;

  Customer({
    required this.name,
    required this.phone,
    this.address,
    this.totalPurchases = 0,
    this.isActive = true,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }

  // Update total purchases
  void updateTotalPurchases(double amount) {
    totalPurchases += amount;
    updatedAt = DateTime.now();
  }
}
