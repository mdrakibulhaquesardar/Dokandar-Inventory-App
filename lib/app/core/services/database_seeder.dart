import 'package:isar/isar.dart';
import 'package:flutter/foundation.dart' hide Category;
import '../../data/models/product.dart';
import '../../data/models/category.dart';
import '../../data/models/customer.dart';
import '../../data/models/supplier.dart';
import '../../data/models/employee.dart';
import '../../data/models/expense.dart';

class DatabaseSeeder {
  final Isar isar;

  DatabaseSeeder(this.isar);

  /// Seed initial data into the database
  /// This will only seed if the database is empty
  Future<void> seedData() async {
    try {
      // Check if data already exists
      final hasProducts = await isar.products.count() > 0;
      final hasCategories = await isar.categorys.count() > 0;
      final hasCustomers = await isar.customers.count() > 0;

      // Only seed if database is empty
      if (hasProducts || hasCategories || hasCustomers) {
        debugPrint('Database already has data. Skipping seed.');
        return;
      }

      debugPrint('Starting database seeding...');

      await isar.writeTxn(() async {
        // Seed Categories
        await _seedCategories();

        // Seed Products
        await _seedProducts();

        // Seed Customers
        await _seedCustomers();

        // Seed Suppliers
        await _seedSuppliers();

        // Seed Employees
        await _seedEmployees();

        // Seed Expenses
        await _seedExpenses();
      });

      debugPrint('Database seeding completed successfully!');
    } catch (e) {
      debugPrint('Error seeding database: $e');
      rethrow;
    }
  }

  /// Seed sample categories
  Future<void> _seedCategories() async {
    final categories = [
      Category(name: 'ইলেকট্রনিক্স', description: 'ইলেকট্রনিক্স পণ্য'),
      Category(name: 'কাপড়', description: 'পোশাক ও কাপড়'),
      Category(name: 'খাদ্য', description: 'খাদ্য সামগ্রী'),
      Category(name: 'ওষুধ', description: 'ঔষধ ও স্বাস্থ্য'),
      Category(name: 'বই', description: 'বই ও শিক্ষা সামগ্রী'),
      Category(name: 'খেলনা', description: 'খেলনা ও গেম'),
    ];

    for (var category in categories) {
      await isar.categorys.put(category);
    }
    debugPrint('Seeded ${categories.length} categories');
  }

  /// Seed sample products
  Future<void> _seedProducts() async {
    final products = [
      Product(
        name: 'সamsung Galaxy S21',
        category: 'ইলেকট্রনিক্স',
        stockQuantity: 15,
        unitPrice: 45000,
        buyingPrice: 40000,
        sku: 'ELC-001',
      ),
      Product(
        name: 'iPhone 13',
        category: 'ইলেকট্রনিক্স',
        stockQuantity: 8,
        unitPrice: 85000,
        buyingPrice: 75000,
        sku: 'ELC-002',
      ),
      Product(
        name: 'শার্ট',
        category: 'কাপড়',
        stockQuantity: 50,
        unitPrice: 800,
        buyingPrice: 500,
        sku: 'CLO-001',
      ),
      Product(
        name: 'প্যান্ট',
        category: 'কাপড়',
        stockQuantity: 35,
        unitPrice: 1200,
        buyingPrice: 800,
        sku: 'CLO-002',
      ),
      Product(
        name: 'চাল',
        category: 'খাদ্য',
        stockQuantity: 200,
        unitPrice: 60,
        buyingPrice: 50,
        sku: 'FOD-001',
      ),
      Product(
        name: 'ডাল',
        category: 'খাদ্য',
        stockQuantity: 150,
        unitPrice: 120,
        buyingPrice: 100,
        sku: 'FOD-002',
      ),
      Product(
        name: 'প্যারাসিটামল',
        category: 'ওষুধ',
        stockQuantity: 100,
        unitPrice: 5,
        buyingPrice: 3,
        sku: 'MED-001',
      ),
      Product(
        name: 'নভেল',
        category: 'বই',
        stockQuantity: 25,
        unitPrice: 300,
        buyingPrice: 200,
        sku: 'BOK-001',
      ),
      Product(
        name: 'ফুটবল',
        category: 'খেলনা',
        stockQuantity: 20,
        unitPrice: 500,
        buyingPrice: 350,
        sku: 'TOY-001',
      ),
      Product(
        name: 'ল্যাপটপ',
        category: 'ইলেকট্রনিক্স',
        stockQuantity: 5,
        unitPrice: 55000,
        buyingPrice: 48000,
        sku: 'ELC-003',
      ),
    ];

    for (var product in products) {
      await isar.products.put(product);
    }
    debugPrint('Seeded ${products.length} products');
  }

  /// Seed sample customers
  Future<void> _seedCustomers() async {
    final customers = [
      Customer(
        name: 'রহিম উদ্দিন',
        phone: '01712345678',
        address: 'ঢাকা, বাংলাদেশ',
      ),
      Customer(
        name: 'করিম আহমেদ',
        phone: '01812345679',
        address: 'চট্টগ্রাম, বাংলাদেশ',
      ),
      Customer(
        name: 'ফাতেমা খাতুন',
        phone: '01912345680',
        address: 'সিলেট, বাংলাদেশ',
      ),
      Customer(
        name: 'মোহাম্মদ আলী',
        phone: '01512345681',
        address: 'রাজশাহী, বাংলাদেশ',
      ),
      Customer(
        name: 'আয়েশা বেগম',
        phone: '01612345682',
        address: 'খুলনা, বাংলাদেশ',
      ),
    ];

    for (var customer in customers) {
      await isar.customers.put(customer);
    }
    debugPrint('Seeded ${customers.length} customers');
  }

  /// Seed sample suppliers
  Future<void> _seedSuppliers() async {
    final suppliers = [
      Supplier(
        name: 'ABC Electronics Ltd.',
        company: 'ABC Electronics',
        phone: '01711111111',
        email: 'abc@electronics.com',
        address: 'ঢাকা, বাংলাদেশ',
      ),
      Supplier(
        name: 'XYZ Textiles',
        company: 'XYZ Textiles Ltd.',
        phone: '01822222222',
        email: 'xyz@textiles.com',
        address: 'চট্টগ্রাম, বাংলাদেশ',
      ),
      Supplier(
        name: 'Fresh Foods Co.',
        company: 'Fresh Foods',
        phone: '01933333333',
        email: 'info@freshfoods.com',
        address: 'সিলেট, বাংলাদেশ',
      ),
    ];

    for (var supplier in suppliers) {
      await isar.suppliers.put(supplier);
    }
    debugPrint('Seeded ${suppliers.length} suppliers');
  }

  /// Seed sample employees
  Future<void> _seedEmployees() async {
    final employees = [
      Employee(
        name: 'সালাম মিয়া',
        role: 'সেলস ম্যানেজার',
        phone: '01744444444',
        email: 'salam@store.com',
        address: 'ঢাকা, বাংলাদেশ',
        salary: 25000,
      ),
      Employee(
        name: 'রোকেয়া বেগম',
        role: 'ক্যাশিয়ার',
        phone: '01855555555',
        email: 'rokeya@store.com',
        address: 'ঢাকা, বাংলাদেশ',
        salary: 20000,
      ),
      Employee(
        name: 'করিম হোসেন',
        role: 'স্টক ম্যানেজার',
        phone: '01966666666',
        email: 'karim@store.com',
        address: 'ঢাকা, বাংলাদেশ',
        salary: 22000,
      ),
    ];

    for (var employee in employees) {
      await isar.employees.put(employee);
    }
    debugPrint('Seeded ${employees.length} employees');
  }

  /// Seed sample expenses
  Future<void> _seedExpenses() async {
    final now = DateTime.now();
    final expenses = [
      Expense(
        title: 'বিদ্যুৎ বিল',
        category: 'ইউটিলিটি',
        amount: 5000,
        note: 'মাসিক বিদ্যুৎ বিল',
        date: now.subtract(const Duration(days: 5)),
      ),
      Expense(
        title: 'ভাড়া',
        category: 'ভাড়া',
        amount: 15000,
        note: 'মাসিক দোকান ভাড়া',
        date: now.subtract(const Duration(days: 10)),
      ),
      Expense(
        title: 'কাগজপত্র',
        category: 'অফিস সরঞ্জাম',
        amount: 2000,
        note: 'অফিস সরঞ্জাম ক্রয়',
        date: now.subtract(const Duration(days: 3)),
      ),
      Expense(
        title: 'পরিবহন',
        category: 'পরিবহন',
        amount: 3000,
        note: 'পণ্য পরিবহন খরচ',
        date: now.subtract(const Duration(days: 7)),
      ),
    ];

    for (var expense in expenses) {
      await isar.expenses.put(expense);
    }
    debugPrint('Seeded ${expenses.length} expenses');
  }

  /// Clear all seeded data (for testing/resetting)
  Future<void> clearSeededData() async {
    await isar.writeTxn(() async {
      await isar.products.clear();
      await isar.categorys.clear();
      await isar.customers.clear();
      await isar.suppliers.clear();
      await isar.employees.clear();
      await isar.expenses.clear();
    });
    debugPrint('Cleared all seeded data');
  }
}
