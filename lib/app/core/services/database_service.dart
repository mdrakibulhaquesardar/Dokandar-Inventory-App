import 'package:get/get.dart';

import '../../data/models/category.dart';
import '../../data/models/customer.dart';
import '../../data/models/employee.dart';
import '../../data/models/expense.dart';
import '../../data/models/product.dart';
import '../../data/models/sale.dart';
import '../../data/models/stock_history.dart';
import '../../data/models/store.dart';
import '../../data/models/supplier.dart';
import '../../data/models/user.dart';
import '../../data/models/notification.dart';
import '../../data/models/team_member.dart';
import '../../data/models/role.dart';
import '../../data/models/permission.dart';
import '../../data/models/file_item.dart';
import '../../data/models/analytics_data.dart';
import '../repository/database_service_repository.dart';
import '../../../../mock/mock_data.dart';

/// Lightweight in-memory implementation of [DatabaseServiceRepository]
/// used only to support the UI kit with mock data.
///
/// All methods either read from [MockData] or are no-ops.
class DatabaseService extends GetxService implements DatabaseServiceRepository {
  @override
  Future<DatabaseService> init() async {
    // Nothing to initialize for mock-only implementation
    return this;
  }

  @override
  Future<void> close() async {}

  @override
  Future<void> clear() async {}

  // ---------------------------------------------------------------------------
  // User operations (mock-only)
  // ---------------------------------------------------------------------------

  @override
  Future<bool> hasUser() async => false;

  @override
  Future<User?> getUser() async => null;

  @override
  Future<void> saveUser(User user) async {}

  @override
  Future<List<User>> getAllUsers() async => [];

  @override
  Future<User?> getUserById(int id) async => null;

  @override
  Future<void> deleteUser(int id) async {}

  // ---------------------------------------------------------------------------
  // Store operations (use MockData.store)
  // ---------------------------------------------------------------------------

  @override
  Future<Store?> getStore() async => MockData.store;

  @override
  Future<void> saveStore(Store store) async {}

  @override
  Future<void> updateStore(Store store) async {}

  // ---------------------------------------------------------------------------
  // Product operations (use MockData.products)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Product>> getAllProducts() async => MockData.products;

  @override
  Future<int> getTotalProducts() async => MockData.products.length;

  @override
  Future<double> getTotalProductsPrice() async => MockData.products
      .fold<double>(0.0, (sum, p) => sum + p.unitPrice * p.stockQuantity);

  @override
  Future<List<Product>> getLowStockProducts() async =>
      MockData.products.where((p) => p.stockQuantity < 5).toList();

  @override
  Future<Product?> getProductById(int id) async =>
      MockData.products.firstWhereOrNull((p) => p.id == id);

  @override
  Future<void> saveProduct(Product product) async {}

  @override
  Future<void> deleteProduct(int id) async {}

  @override
  Future<List<Product>> searchProducts(String query) async {
    if (query.isEmpty) return [];
    final lower = query.toLowerCase();
    return MockData.products
        .where((p) =>
            p.name.toLowerCase().contains(lower) ||
            p.category.toLowerCase().contains(lower) ||
            p.sku.toLowerCase().contains(lower))
        .toList();
  }

  // ---------------------------------------------------------------------------
  // Customer operations (use MockData.customers)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Customer>> getAllCustomers() async => MockData.customers;

  @override
  Future<int> getTotalCustomers() async => MockData.customers.length;

  @override
  Future<Customer?> getCustomerById(int id) async =>
      MockData.customers.firstWhereOrNull((c) => c.id == id);

  @override
  Future<String?> getCustomerNameById(int id) async =>
      (await getCustomerById(id))?.name;

  @override
  Future<void> saveCustomer(Customer customer) async {}

  @override
  Future<void> updateCustomer(Customer customer) async {}

  @override
  Future<void> deleteCustomer(int id) async {}

  // ---------------------------------------------------------------------------
  // Sale operations (use MockData.sales)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Sale>> getAllSales() async => MockData.sales;

  @override
  Future<double> getTotalSales() async =>
      MockData.sales.fold<double>(0.0, (sum, s) => sum + s.totalAmount);

  @override
  Future<List<Sale>> getSalesToday() async => MockData.sales;

  @override
  Future<double> getTotalSalesToday() async =>
      MockData.sales.fold<double>(0.0, (sum, s) => sum + s.totalAmount);

  @override
  Future<void> saveSale(Sale sale) async {}

  @override
  Future<void> totalRevenue() async {}

  @override
  Future<void> deleteSale(int id) async {}

  @override
  Future<void> updateSalePayment(
      int id, double paidAmount, double dueAmount) async {}

  // ---------------------------------------------------------------------------
  // Stock History operations (not modeled in mock data)
  // ---------------------------------------------------------------------------

  @override
  Future<List<StockHistory>> getStockHistory(int productId) async => [];

  @override
  Future<void> saveStockHistory(StockHistory history) async {}

  // ---------------------------------------------------------------------------
  // Category operations (use MockData.categories)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Category>> getAllCategories() async => MockData.categories;

  @override
  Future<Category?> getCategoryById(int id) async =>
      MockData.categories.firstWhereOrNull((c) => c.id == id);

  @override
  Future<void> saveCategory(Category category) async {}

  @override
  Future<void> deleteCategory(int id) async {}

  // ---------------------------------------------------------------------------
  // Supplier operations (use MockData.suppliers)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Supplier>> getAllSuppliers() async => MockData.suppliers;

  @override
  Future<Supplier?> getSupplierById(int id) async =>
      MockData.suppliers.firstWhereOrNull((s) => s.id == id);

  @override
  Future<void> saveSupplier(Supplier supplier) async {}

  @override
  Future<void> updateSupplier(Supplier supplier) async {}

  @override
  Future<void> deleteSupplier(int id) async {}

  // ---------------------------------------------------------------------------
  // Employee operations (use MockData.employees)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Employee>> getAllEmployees() async => MockData.employees;

  @override
  Future<Employee?> getEmployeeById(int id) async =>
      MockData.employees.firstWhereOrNull((e) => e.id == id);

  @override
  Future<void> saveEmployee(Employee employee) async {}

  @override
  Future<void> updateEmployee(Employee employee) async {}

  @override
  Future<void> deleteEmployee(int id) async {}

  // ---------------------------------------------------------------------------
  // Expense operations (use MockData.expenses)
  // ---------------------------------------------------------------------------

  @override
  Future<List<Expense>> getAllExpenses() async => MockData.expenses;

  @override
  Future<Expense?> getExpenseById(int id) async =>
      MockData.expenses.firstWhereOrNull((e) => e.id == id);

  @override
  Future<void> saveExpense(Expense expense) async {}

  @override
  Future<void> updateExpense(Expense expense) async {}

  @override
  Future<void> deleteExpense(int id) async {}

  // ---------------------------------------------------------------------------
  // Notification operations (use MockData.notifications)
  // ---------------------------------------------------------------------------

  Future<List<Notification>> getAllNotifications() async =>
      MockData.notifications;

  Future<Notification?> getNotificationById(int id) async =>
      MockData.notifications.firstWhereOrNull((n) => n.id == id);

  Future<void> markNotificationAsRead(int id) async {
    final notification =
        MockData.notifications.firstWhereOrNull((n) => n.id == id);
    if (notification != null) {
      notification.isRead = true;
    }
  }

  Future<void> markAllNotificationsAsRead() async {
    for (var notification in MockData.notifications) {
      notification.isRead = true;
    }
  }

  Future<void> deleteNotification(int id) async {
    MockData.notifications.removeWhere((n) => n.id == id);
  }

  // ---------------------------------------------------------------------------
  // Team Member operations (use MockData.teamMembers)
  // ---------------------------------------------------------------------------

  Future<List<TeamMember>> getAllTeamMembers() async => MockData.teamMembers;

  Future<TeamMember?> getTeamMemberById(int id) async =>
      MockData.teamMembers.firstWhereOrNull((m) => m.id == id);

  Future<void> saveTeamMember(TeamMember member) async {
    // In real app, this would save to database
    // For UI kit, just add to mock data
    final newId = (MockData.teamMembers
            .map((m) => m.id ?? 0)
            .reduce((a, b) => a > b ? a : b)) +
        1;
    final newMember = TeamMember(
      id: newId,
      name: member.name,
      email: member.email,
      phone: member.phone,
      role: member.role,
      department: member.department,
      status: member.status,
      avatarUrl: member.avatarUrl,
      createdAt: member.createdAt,
      updatedAt: DateTime.now(),
      assignedRoleIds: member.assignedRoleIds,
    );
    MockData.teamMembers.add(newMember);
  }

  Future<void> updateTeamMember(TeamMember member) async {
    final index = MockData.teamMembers.indexWhere((m) => m.id == member.id);
    if (index != -1) {
      MockData.teamMembers[index] = member;
    }
  }

  Future<void> deleteTeamMember(int id) async {
    MockData.teamMembers.removeWhere((m) => m.id == id);
  }

  // ---------------------------------------------------------------------------
  // Role operations (use MockData.roles)
  // ---------------------------------------------------------------------------

  Future<List<Role>> getAllRoles() async => MockData.roles;

  Future<Role?> getRoleById(int id) async =>
      MockData.roles.firstWhereOrNull((r) => r.id == id);

  Future<void> saveRole(Role role) async {
    final newId =
        (MockData.roles.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b)) +
            1;
    final newRole = Role(
      id: newId,
      name: role.name,
      description: role.description,
      permissionIds: role.permissionIds,
      createdAt: role.createdAt,
      updatedAt: DateTime.now(),
    );
    MockData.roles.add(newRole);
  }

  Future<void> updateRole(Role role) async {
    final index = MockData.roles.indexWhere((r) => r.id == role.id);
    if (index != -1) {
      MockData.roles[index] = role;
    }
  }

  Future<void> deleteRole(int id) async {
    MockData.roles.removeWhere((r) => r.id == id);
  }

  // ---------------------------------------------------------------------------
  // Permission operations (use MockData.permissions)
  // ---------------------------------------------------------------------------

  Future<List<Permission>> getAllPermissions() async => MockData.permissions;

  Future<Permission?> getPermissionById(String id) async =>
      MockData.permissions.firstWhereOrNull((p) => p.id == id);

  // ---------------------------------------------------------------------------
  // File Management operations (use MockData.files)
  // ---------------------------------------------------------------------------

  Future<List<FileItem>> getAllFiles({String? path}) async {
    if (path == null || path == '/') {
      return MockData.files
          .where((f) => f.path.split('/').length == 2)
          .toList();
    }
    return MockData.files.where((f) => f.path.startsWith(path)).toList();
  }

  Future<FileItem?> getFileById(String id) async =>
      MockData.files.firstWhereOrNull((f) => f.id == id);

  Future<void> uploadFile(FileItem file) async {
    MockData.files.add(file);
  }

  Future<void> deleteFile(String id) async {
    MockData.files.removeWhere((f) => f.id == id);
  }

  // ---------------------------------------------------------------------------
  // Analytics operations (use MockData.analyticsData)
  // ---------------------------------------------------------------------------

  Future<List<AnalyticsData>> getAllAnalytics() async => MockData.analyticsData;

  Future<AnalyticsData?> getAnalyticsById(String id) async =>
      MockData.analyticsData.firstWhereOrNull((a) => a.id == id);

  Future<List<AnalyticsSummary>> getAnalyticsSummary() async =>
      MockData.analyticsSummary;
}
