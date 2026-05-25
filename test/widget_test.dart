import 'package:flutter_test/flutter_test.dart';
import 'package:dokandar_app_inventory/app/data/models/employee.dart';

void main() {
  group('Employee Model Tests', () {
    test('Constructor sets default values correctly', () {
      final employee = Employee(
        name: 'Rakib Ahmed',
        role: 'Manager',
        salary: 15000,
      );

      expect(employee.name, 'Rakib Ahmed');
      expect(employee.role, 'Manager');
      expect(employee.salary, 15000);
      expect(employee.isActive, true);
      expect(employee.joinedAt, isNotNull);
      expect(employee.employeeCode, isNotNull);
      expect(employee.paid, 0.0);
      expect(employee.due, 0.0);
    });

    test('recordPayment updates paid and due balances correctly', () {
      final employee = Employee(
        name: 'John Doe',
        salary: 20000,
      );

      employee.recordPayment(5000);

      expect(employee.paid, 5000.0);
      expect(employee.due, 15000.0);
      expect(employee.updatedAt, isNotNull);
    });
  });
}
