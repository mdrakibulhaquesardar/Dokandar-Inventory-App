import '../app/data/models/category.dart';
import '../app/data/models/customer.dart';
import '../app/data/models/employee.dart';
import '../app/data/models/expense.dart';
import '../app/data/models/product.dart';
import '../app/data/models/sale.dart';
import '../app/data/models/store.dart';
import '../app/data/models/supplier.dart';

import 'mock_data.dart';

/// Simple in-memory data provider that mimics the shape of
/// the original `DatabaseService` where it is useful for UI.
///
/// All methods are async so developers can later swap this
/// with a real repository or API layer without touching the UI.
class MockDataService {
  const MockDataService();

  Future<Store?> getStore() async {
    return MockData.store;
  }

  Future<List<Category>> getAllCategories() async {
    return MockData.categories;
  }

  Future<List<Product>> getAllProducts() async {
    return MockData.products;
  }

  Future<List<Customer>> getAllCustomers() async {
    return MockData.customers;
  }

  Future<List<Supplier>> getAllSuppliers() async {
    return MockData.suppliers;
  }

  Future<List<Employee>> getAllEmployees() async {
    return MockData.employees;
  }

  Future<List<Expense>> getAllExpenses() async {
    return MockData.expenses;
  }

  Future<List<Sale>> getAllSales() async {
    return MockData.sales;
  }

  /// Example helpers for dashboard-style statistics
  Future<double> getTotalRevenue() async {
    return MockData.sales
        .fold<double>(0.0, (sum, sale) => sum + sale.totalAmount);
  }

  Future<int> getTotalProducts() async {
    return MockData.products.length;
  }

  Future<int> getTotalCustomers() async {
    return MockData.customers.length;
  }

  Future<List<Product>> getLowStockProducts({double threshold = 5}) async {
    return MockData.products.where((p) => p.stockQuantity < threshold).toList();
  }

  Future<List<Product>> searchProducts(String query) async {
    if (query.isEmpty) return [];
    final lower = query.toLowerCase();
    return MockData.products
        .where(
          (p) =>
              p.name.toLowerCase().contains(lower) ||
              p.category.toLowerCase().contains(lower) ||
              p.sku.toLowerCase().contains(lower),
        )
        .toList();
  }
}
