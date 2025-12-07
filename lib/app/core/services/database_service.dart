

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/category.dart';
import '../../data/models/product.dart';
import '../../data/models/customer.dart';
import '../../data/models/sale.dart';
import '../../data/models/stock_history.dart';
import '../../data/models/user.dart';
import '../../data/models/store.dart';
import '../repository/database_service_repository.dart';
import '../../config/app_config.dart';
import 'backup_service.dart';

class DatabaseService extends GetxService implements DatabaseServiceRepository {
  late Isar isar;
  late BackupService backupService;

  @override
  Future<DatabaseService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    // Database name is configured in AppConfig.databaseName
    // Note: Isar uses the directory path, but the name is referenced for documentation
    isar = await Isar.open(
      [
        ProductSchema,
        CustomerSchema,
        SaleSchema,
        StockHistorySchema,
        UserSchema,
        StoreSchema,
        CategorySchema
      ],
      directory: dir.path,
    );

    // Initialize backup service
    backupService = await BackupService().init(isar);
    return this;
  }

  @override
  Future<void> close() async {
    await isar.close();
  }

  @override
  Future<void> clear() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }


  @override
  Future<bool> hasUser() async {
    final userCount = await isar.users.count();
    return userCount > 0;
  }

  @override
  Future<User?> getUser() async {
    return await isar.users.where().findFirst();
  }

  @override
  Future<void> saveUser(User user) async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  @override
  Future<Store?> getStore() async {
    return await isar.stores.where().findFirst();
  }

  @override
  Future<void> saveStore(Store store) async {
    await isar.writeTxn(() async {
      await isar.stores.put(store);
    });
  }

  @override
  Future<List<Product>> getAllProducts() async {
    return await isar.products.where().findAll();
  }

  @override
  Future<int> getTotalProducts() async {
    return await isar.products.count();
  }

  @override
  Future<double> getTotalProductsPrice() async {
    final products = await isar.products.where().findAll();
    double total = 0;
    for (var product in products) {
      total += product.unitPrice * product.stockQuantity;
    }
    return total;
  }

  @override
  Future<List<Product>> getLowStockProducts() async {
    return await isar.products.filter().stockQuantityLessThan(AppConfig.lowStockThreshold.toDouble()).findAll();
  }

  @override
  Future<Product?> getProductById(int id) async {
    return await isar.products.get(id);
  }

  @override
  Future<void> saveProduct(Product product) async {
    await isar.writeTxn(() async {
      await isar.products.put(product);
    });
  }

  @override
  Future<void> deleteProduct(int id) async {
    await isar.writeTxn(() async {
      await isar.products.delete(id);
    });
  }

  @override
  Future<List<Customer>> getAllCustomers() async {
    return await isar.customers.where().findAll();
  }

  @override
  Future<int> getTotalCustomers() async {
    return await isar.customers.count();
  }

  @override
  Future<Customer?> getCustomerById(int id) async {
    return await isar.customers.get(id);
  }

  @override
  Future<String?> getCustomerNameById(int id) async {
    final customer = await isar.customers.get(id);
    return customer?.name;
  }

  @override
  Future<void> saveCustomer(Customer customer) async {
    await isar.writeTxn(() async {
      await isar.customers.put(customer);
    });
  }

  @override
  Future<void> updateCustomer(Customer customer) async {
    await isar.writeTxn(() async {
      await isar.customers.put(customer);
    });
  }

  @override
  Future<void> deleteCustomer(int id) async {
    await isar.writeTxn(() async {
      await isar.customers.delete(id);
    });
  }

  @override
  Future<List<Sale>> getAllSales() async {
    return await isar.sales.where().findAll();
  }

  @override
  Future<double> getTotalSales() async {
    final sales = await isar.sales.where().findAll();
    double total = 0;
    for (var sale in sales) {
      total += sale.totalAmount;
    }
    return total;
  }

  @override
  //totalRevenue
  Future<double> totalRevenue() async {
    final sales = await isar.sales.where().findAll();
    double total = 0;
    for (var sale in sales) {
      total += sale.totalAmount;
    }
    return total;
  }

  @override
  Future<List<Sale>> getSalesToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await isar.sales
        .filter()
        .createdAtGreaterThan(startOfDay, include: true)
        .and()
        .createdAtLessThan(endOfDay, include: false)
        .findAll();
  }

  @override
  Future<double> getTotalSalesToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final sales = await isar.sales
        .filter()
        .createdAtGreaterThan(startOfDay, include: true)
        .and()
        .createdAtLessThan(endOfDay, include: false)
        .findAll();

    double total = 0;
    for (var sale in sales) {
      total += sale.totalAmount;
    }
    return total;
  }

  @override
  Future<void> saveSale(Sale sale) async {
    await isar.writeTxn(() async {
      await isar.sales.put(sale);
    });
  }

  @override
  Future<void> deleteSale(int id) async {
    await isar.writeTxn(() async {
      await isar.sales.delete(id);
    });
  }

  @override
  Future<void> updateSalePayment(int id, double paidAmount, double dueAmount) async {
    await isar.writeTxn(() async {
      final sale = await isar.sales.get(id);
      if (sale != null) {
        sale.paidAmount = paidAmount;
        sale.dueAmount = dueAmount;
        await isar.sales.put(sale);
      }
    });
  }


  @override
  Future<void> updateStore(Store store) async {
    await isar.writeTxn(() async {
      await isar.stores.put(store);
    });
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    return await isar.products
        .filter()
        .nameContains(query,caseSensitive: false)
        .or()
        .skuContains(query,caseSensitive: false)
        .findAll();
  }

  @override
  Future<List<StockHistory>> getStockHistory(int productId) async {
    return await isar.stockHistorys
        .filter()
        .productIdEqualTo(productId)
        .findAll();
  }

  @override
  Future<void> saveStockHistory(StockHistory history) async {
    await isar.writeTxn(() async {
      await isar.stockHistorys.put(history);
    });
  }

  @override
  Future<List<User>> getAllUsers() async {
    return await isar.users.where().findAll();
  }

  @override
  Future<User?> getUserById(int id) async {
    return await isar.users.get(id);
  }

  @override
  Future<void> deleteUser(int id) async {
    await isar.writeTxn(() async {
      await isar.users.delete(id);
    });
  }

  @override
  Future<List<Category>> getAllCategories() async {
    return await isar.categorys.where().findAll();
  }

  @override
  Future<Category?> getCategoryById(int id) async {
    return await isar.categorys.get(id);
  }

  @override
  Future<void> saveCategory(Category category) async {
    await isar.writeTxn(() async {
      await isar.categorys.put(category);
    });
  }

  @override
  Future<void> deleteCategory(int id) async {
    await isar.writeTxn(() async {
      await isar.categorys.delete(id);
    });
  }
}
