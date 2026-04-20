import '../app/data/models/product.dart';
import '../app/data/models/category.dart';
import '../app/data/models/customer.dart';
import '../app/data/models/sale.dart';
import '../app/data/models/store.dart';
import '../app/data/models/supplier.dart';
import '../app/data/models/employee.dart';
import '../app/data/models/expense.dart';
import '../app/data/models/notification.dart';
import '../app/data/models/team_member.dart';
import '../app/data/models/role.dart';
import '../app/data/models/permission.dart';
import '../app/data/models/file_item.dart';
import '../app/data/models/analytics_data.dart';

/// Central place for all mock data used in the UI kit.
///
/// In a real app, developers can replace these with API responses
/// or database-backed repositories.
class MockData {
  MockData._();

  static final store = Store(
    name: 'BizDash Demo Workspace',
    address: '123 Demo Street, Dhaka',
    phone: '+880 1234-567890',
    email: 'contact@bizdash.demo',
    businessType: 'Demo Business',
  );

  static final List<Category> categories = [
    Category(name: 'Electronics', description: 'Phones, laptops, accessories'),
    Category(name: 'Groceries', description: 'Daily essentials and food items'),
    Category(name: 'Fashion', description: 'Clothing and apparel'),
    Category(name: 'Home & Living', description: 'Furniture and decor'),
    Category(name: 'Sports', description: 'Sports and fitness items'),
  ];

  static final List<Product> products = [
    Product(
      name: 'Smartphone X12',
      category: 'Electronics',
      stockQuantity: 25,
      unitPrice: 25000,
      buyingPrice: 20000,
      sku: 'PROD-001',
    ),
    Product(
      name: 'Laptop Pro 15"',
      category: 'Electronics',
      stockQuantity: 10,
      unitPrice: 95000,
      buyingPrice: 80000,
      sku: 'PROD-002',
    ),
    Product(
      name: 'Running Shoes',
      category: 'Sports',
      stockQuantity: 40,
      unitPrice: 3500,
      buyingPrice: 2500,
      sku: 'PROD-003',
    ),
    Product(
      name: 'Office Chair',
      category: 'Home & Living',
      stockQuantity: 15,
      unitPrice: 7500,
      buyingPrice: 5500,
      sku: 'PROD-004',
    ),
  ];

  static final List<Customer> customers = [
    Customer(name: 'Abdul Karim', phone: '+880 1711-000111', address: 'Dhaka'),
    Customer(
      name: 'Rina Akter',
      phone: '+880 1711-000222',
      address: 'Chattogram',
    ),
    Customer(name: 'John Doe', phone: '+880 1711-000333', address: 'Sylhet'),
  ];

  static final List<Supplier> suppliers = [
    Supplier(
      name: 'Tech Import BD',
      phone: '+880 1888-111222',
      address: 'Dhaka',
    ),
    Supplier(
      name: 'Global Fashion Ltd',
      phone: '+880 1888-333444',
      address: 'Narayanganj',
    ),
  ];

  static final List<Employee> employees = [
    Employee(
      name: 'Store Manager',
      phone: '+880 1999-111222',
      role: 'Manager',
      salary: 35000,
    ),
    Employee(
      name: 'Cashier',
      phone: '+880 1999-333444',
      role: 'Cashier',
      salary: 22000,
    ),
  ];

  static final List<Expense> expenses = [
    Expense(title: 'Workspace Rent', amount: 25000, category: 'Rent'),
    Expense(title: 'Electricity Bill', amount: 4500, category: 'Utilities'),
    Expense(title: 'Internet Bill', amount: 2000, category: 'Utilities'),
  ];

  static final List<Sale> sales = [
    Sale(
      customerId: 1,
      items: [
        SaleItem()
          ..productId = 1
          ..productName = 'Smartphone X12'
          ..quantity = 1
          ..unitPrice = 25000
          ..totalPrice = 25000,
      ],
      totalAmount: 25000,
      paidAmount: 25000,
      discount: 0,
      dueAmount: 0,
      invoiceNumber: 'INV-1001',
    ),
    Sale(
      customerId: 2,
      items: [
        SaleItem()
          ..productId = 3
          ..productName = 'Running Shoes'
          ..quantity = 2
          ..unitPrice = 3500
          ..totalPrice = 7000,
      ],
      totalAmount: 7000,
      paidAmount: 5000,
      discount: 0,
      dueAmount: 2000,
      invoiceNumber: 'INV-1002',
    ),
  ];

  static final List<TeamMember> teamMembers = [
    TeamMember(
      id: 1,
      name: 'John Smith',
      email: 'john.smith@example.com',
      phone: '+880 1711-111111',
      role: 'Admin',
      department: 'Management',
      status: UserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      assignedRoleIds: ['admin'],
    ),
    TeamMember(
      id: 2,
      name: 'Sarah Johnson',
      email: 'sarah.j@example.com',
      phone: '+880 1711-222222',
      role: 'Manager',
      department: 'Sales',
      status: UserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      assignedRoleIds: ['manager'],
    ),
    TeamMember(
      id: 3,
      name: 'Mike Wilson',
      email: 'mike.w@example.com',
      phone: '+880 1711-333333',
      role: 'Employee',
      department: 'Operations',
      status: UserStatus.active,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      assignedRoleIds: ['employee'],
    ),
    TeamMember(
      id: 4,
      name: 'Emily Davis',
      email: 'emily.d@example.com',
      phone: '+880 1711-444444',
      role: 'Viewer',
      department: 'Finance',
      status: UserStatus.inactive,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      assignedRoleIds: ['viewer'],
    ),
  ];

  static final List<Role> roles = [
    Role(
      id: 1,
      name: 'Admin',
      description: 'Full access to all features and settings',
      permissionIds: [
        'dashboard.view',
        'records.view',
        'records.create',
        'records.edit',
        'records.delete',
        'reports.view',
        'users.view',
        'users.create',
        'users.edit',
        'users.delete',
        'settings.view',
        'settings.edit',
        'files.view',
        'files.upload',
        'files.delete',
        'analytics.view',
        'notifications.view',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
    ),
    Role(
      id: 2,
      name: 'Manager',
      description: 'Can manage records and view reports',
      permissionIds: [
        'dashboard.view',
        'records.view',
        'records.create',
        'records.edit',
        'reports.view',
        'users.view',
        'files.view',
        'files.upload',
        'analytics.view',
        'notifications.view',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
    ),
    Role(
      id: 3,
      name: 'Employee',
      description: 'Can view and create records',
      permissionIds: [
        'dashboard.view',
        'records.view',
        'records.create',
        'files.view',
        'notifications.view',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
    ),
    Role(
      id: 4,
      name: 'Viewer',
      description: 'Read-only access to dashboard and records',
      permissionIds: [
        'dashboard.view',
        'records.view',
        'reports.view',
        'analytics.view',
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 100)),
    ),
  ];

  static final List<Permission> permissions = [
    // Dashboard
    Permission(
      id: 'dashboard.view',
      name: 'View Dashboard',
      description: 'Access to dashboard overview',
      category: PermissionCategory.dashboard,
    ),
    // Records
    Permission(
      id: 'records.view',
      name: 'View Records',
      description: 'View all records and items',
      category: PermissionCategory.records,
    ),
    Permission(
      id: 'records.create',
      name: 'Create Records',
      description: 'Create new records and items',
      category: PermissionCategory.records,
    ),
    Permission(
      id: 'records.edit',
      name: 'Edit Records',
      description: 'Edit existing records',
      category: PermissionCategory.records,
    ),
    Permission(
      id: 'records.delete',
      name: 'Delete Records',
      description: 'Delete records and items',
      category: PermissionCategory.records,
    ),
    // Reports
    Permission(
      id: 'reports.view',
      name: 'View Reports',
      description: 'Access to reports and analytics',
      category: PermissionCategory.reports,
    ),
    // Users
    Permission(
      id: 'users.view',
      name: 'View Users',
      description: 'View user list and details',
      category: PermissionCategory.users,
    ),
    Permission(
      id: 'users.create',
      name: 'Create Users',
      description: 'Add new users to the system',
      category: PermissionCategory.users,
    ),
    Permission(
      id: 'users.edit',
      name: 'Edit Users',
      description: 'Edit user information',
      category: PermissionCategory.users,
    ),
    Permission(
      id: 'users.delete',
      name: 'Delete Users',
      description: 'Remove users from the system',
      category: PermissionCategory.users,
    ),
    // Settings
    Permission(
      id: 'settings.view',
      name: 'View Settings',
      description: 'Access to settings page',
      category: PermissionCategory.settings,
    ),
    Permission(
      id: 'settings.edit',
      name: 'Edit Settings',
      description: 'Modify application settings',
      category: PermissionCategory.settings,
    ),
    // Files
    Permission(
      id: 'files.view',
      name: 'View Files',
      description: 'Browse and view files',
      category: PermissionCategory.files,
    ),
    Permission(
      id: 'files.upload',
      name: 'Upload Files',
      description: 'Upload new files',
      category: PermissionCategory.files,
    ),
    Permission(
      id: 'files.delete',
      name: 'Delete Files',
      description: 'Delete files from storage',
      category: PermissionCategory.files,
    ),
    // Analytics
    Permission(
      id: 'analytics.view',
      name: 'View Analytics',
      description: 'Access to analytics dashboard',
      category: PermissionCategory.analytics,
    ),
    // Notifications
    Permission(
      id: 'notifications.view',
      name: 'View Notifications',
      description: 'Access to notifications center',
      category: PermissionCategory.notifications,
    ),
  ];

  static final List<Notification> notifications = [
    Notification(
      id: 1,
      title: 'New Order Received',
      message:
          'You have received a new order from Abdul Karim. Total amount: ৳25,000',
      type: NotificationType.success,
      category: NotificationCategory.important,
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      actionUrl: '/orders/1',
    ),
    Notification(
      id: 2,
      title: 'Low Stock Alert',
      message: 'Laptop Pro 15" is running low on stock. Current quantity: 10',
      type: NotificationType.warning,
      category: NotificationCategory.important,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      actionUrl: '/products/2',
    ),
    Notification(
      id: 3,
      title: 'System Update',
      message:
          'Your app has been updated to version 1.0.1 with new features and bug fixes.',
      type: NotificationType.system,
      category: NotificationCategory.system,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
    ),
    Notification(
      id: 4,
      title: 'Payment Received',
      message: 'Payment of ৳7,000 has been received from Rina Akter',
      type: NotificationType.success,
      category: NotificationCategory.all,
      createdAt: DateTime.now().subtract(const Duration(hours: 8)),
      isRead: true,
    ),
    Notification(
      id: 5,
      title: 'Expense Reminder',
      message: 'Workspace rent payment is due in 3 days',
      type: NotificationType.info,
      category: NotificationCategory.all,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
      actionUrl: '/expenses',
    ),
    Notification(
      id: 6,
      title: 'Error: Backup Failed',
      message: 'The scheduled backup could not be completed. Please try again.',
      type: NotificationType.error,
      category: NotificationCategory.important,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
    Notification(
      id: 7,
      title: 'New Employee Added',
      message: 'A new employee "Cashier" has been added to the system',
      type: NotificationType.info,
      category: NotificationCategory.all,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
  ];

  static final List<FileItem> files = [
    FileItem(
      id: '1',
      name: 'Documents',
      path: '/Documents',
      type: FileType.folder,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    FileItem(
      id: '2',
      name: 'Images',
      path: '/Images',
      type: FileType.folder,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    FileItem(
      id: '3',
      name: 'Reports',
      path: '/Reports',
      type: FileType.folder,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    FileItem(
      id: '4',
      name: 'invoice_2024.pdf',
      path: '/Documents/invoice_2024.pdf',
      type: FileType.document,
      size: 245760,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      modifiedAt: DateTime.now().subtract(const Duration(days: 5)),
      mimeType: 'application/pdf',
    ),
    FileItem(
      id: '5',
      name: 'product_image.jpg',
      path: '/Images/product_image.jpg',
      type: FileType.image,
      size: 1024000,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      modifiedAt: DateTime.now().subtract(const Duration(days: 2)),
      mimeType: 'image/jpeg',
    ),
    FileItem(
      id: '6',
      name: 'sales_report.xlsx',
      path: '/Reports/sales_report.xlsx',
      type: FileType.document,
      size: 512000,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      modifiedAt: DateTime.now().subtract(const Duration(hours: 12)),
      mimeType:
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    ),
    FileItem(
      id: '7',
      name: 'company_logo.png',
      path: '/Images/company_logo.png',
      type: FileType.image,
      size: 204800,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      modifiedAt: DateTime.now().subtract(const Duration(days: 8)),
      mimeType: 'image/png',
    ),
    FileItem(
      id: '8',
      name: 'presentation.pptx',
      path: '/Documents/presentation.pptx',
      type: FileType.document,
      size: 3145728,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      modifiedAt: DateTime.now().subtract(const Duration(days: 6)),
      mimeType:
          'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    ),
  ];

  static final List<AnalyticsData> analyticsData = [
    AnalyticsData(
      id: '1',
      title: 'Sales Overview',
      category: 'Sales',
      dataPoints: {
        '2024-01': 125000,
        '2024-02': 145000,
        '2024-03': 138000,
        '2024-04': 162000,
        '2024-05': 178000,
        '2024-06': 195000,
      },
      chartType: ChartType.line,
      createdAt: DateTime.now(),
    ),
    AnalyticsData(
      id: '2',
      title: 'Product Categories',
      category: 'Products',
      dataPoints: {
        'Electronics': 35.5,
        'Groceries': 28.2,
        'Fashion': 18.7,
        'Home & Living': 12.3,
        'Sports': 5.3,
      },
      chartType: ChartType.pie,
      createdAt: DateTime.now(),
    ),
    AnalyticsData(
      id: '3',
      title: 'Monthly Revenue',
      category: 'Revenue',
      dataPoints: {
        'Jan': 125000,
        'Feb': 145000,
        'Mar': 138000,
        'Apr': 162000,
        'May': 178000,
        'Jun': 195000,
      },
      chartType: ChartType.bar,
      createdAt: DateTime.now(),
    ),
    AnalyticsData(
      id: '4',
      title: 'Customer Growth',
      category: 'Customers',
      dataPoints: {
        '2024-01': 450,
        '2024-02': 520,
        '2024-03': 580,
        '2024-04': 640,
        '2024-05': 720,
        '2024-06': 810,
      },
      chartType: ChartType.area,
      createdAt: DateTime.now(),
    ),
  ];

  static final List<AnalyticsSummary> analyticsSummary = [
    AnalyticsSummary(
      label: 'Total Sales',
      value: 195000,
      previousValue: 178000,
      unit: 'BDT',
      isPositive: true,
    ),
    AnalyticsSummary(
      label: 'New Customers',
      value: 810,
      previousValue: 720,
      unit: 'Users',
      isPositive: true,
    ),
    AnalyticsSummary(
      label: 'Products Sold',
      value: 1245,
      previousValue: 1180,
      unit: 'Items',
      isPositive: true,
    ),
    AnalyticsSummary(
      label: 'Average Order',
      value: 2450,
      previousValue: 2380,
      unit: 'BDT',
      isPositive: true,
    ),
  ];
}
