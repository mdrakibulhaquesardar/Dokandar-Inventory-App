import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'supplier.g.dart';

@collection
class Supplier {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? supplierCode;

  late String name;
  String? company;
  String? phone;
  String? email;
  String? address;

  // financials
  double totalPurchase = 0;
  double totalPaid = 0;
  double totalDue = 0;

  DateTime? createdAt;
  DateTime? updatedAt;

  Supplier({
    required this.name,
    this.company,
    this.phone,
    this.email,
    this.address,
    String? supplierCode,
  }) : supplierCode = supplierCode ?? const Uuid().v4(),
       createdAt = DateTime.now();

  void addPurchase(double amount, {double paid = 0}) {
    totalPurchase += amount;
    totalPaid += paid;
    totalDue = totalPurchase - totalPaid;
    updatedAt = DateTime.now();
  }

  void recordPayment(double amount) {
    totalPaid += amount;
    totalDue = totalPurchase - totalPaid;
    updatedAt = DateTime.now();
  }
}

