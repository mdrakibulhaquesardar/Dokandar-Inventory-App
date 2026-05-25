import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'employee.g.dart';

@collection
class Employee {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? employeeCode;

  late String name;
  String? role;
  String? phone;
  String? email;
  String? address;

  double salary = 0;
  double paid = 0;
  double due = 0;

  String? profileImage;
  bool isActive = true;
  String? notes;

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
    this.profileImage,
    this.isActive = true,
    this.notes,
    DateTime? joinedAt,
  }) : employeeCode = employeeCode ?? const Uuid().v4(),
       joinedAt = joinedAt ?? DateTime.now();

  void recordPayment(double amount) {
    paid += amount;
    due = salary - paid;
    updatedAt = DateTime.now();
  }
}
