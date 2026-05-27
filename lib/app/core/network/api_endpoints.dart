class ApiEndpoints {
  // For Android emulator: 10.0.2.2 maps to host machine's localhost
  // For physical device: replace with your machine's local IP (e.g., 192.168.1.x:3000)
  static const String baseUrl = 'http://10.0.2.2:3000';

  // Auth
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String refresh = '/api/auth/refresh';
  static const String logout = '/api/auth/logout';
  static const String me = '/api/auth/me';

  // Products
  static const String products = '/api/products';
  static String productById(String id) => '/api/products/$id';
  static const String searchProducts = '/api/products/search';

  // Categories
  static const String categories = '/api/categories';
  static String categoryById(String id) => '/api/categories/$id';

  // Sales
  static const String sales = '/api/sales';
  static String saleById(String id) => '/api/sales/$id';
  static const String salesToday = '/api/sales/today';

  // Customers
  static const String customers = '/api/customers';
  static String customerById(String id) => '/api/customers/$id';

  // Suppliers
  static const String suppliers = '/api/suppliers';
  static String supplierById(String id) => '/api/suppliers/$id';

  // Employees
  static const String employees = '/api/employees';
  static String employeeById(String id) => '/api/employees/$id';

  // Expenses
  static const String expenses = '/api/expenses';
  static String expenseById(String id) => '/api/expenses/$id';

  // Store
  static const String store = '/api/store';
  static const String storeStats = '/api/store/stats';

  // Analytics
  static const String analyticsDashboard = '/api/analytics/dashboard';
  static const String analyticsSales = '/api/analytics/sales';
  static const String analyticsTopProducts = '/api/analytics/products/top';

  // Notifications
  static const String notifications = '/api/notifications';
  static String notificationMarkRead(String id) =>
      '/api/notifications/$id/read';
}
