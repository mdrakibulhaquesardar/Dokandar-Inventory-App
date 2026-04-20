import 'package:uuid/uuid.dart';

class Employee {
  int? id;

  String? employeeCode;

  late String name;
  String? role;
  String? phone;
  String? email;
  String? address;

  double salary = 0;
  double paid = 0;
  double due = 0;

  DateTime? joinedAt;
  DateTime? updatedAt;

  Employee({
    required this.name,
    this.role,
    this.phone,
    this.email,
    this.address,
    this.salary = 0,
    String? employeeCode,
  }) : employeeCode = employeeCode ?? const Uuid().v4(),
       joinedAt = DateTime.now();

  void recordPayment(double amount) {
    paid += amount;
    due = salary - paid;
    updatedAt = DateTime.now();
  }
}
