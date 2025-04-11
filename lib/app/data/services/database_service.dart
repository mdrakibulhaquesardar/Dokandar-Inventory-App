import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../models/customer.dart';
import '../models/sale.dart';
import '../models/stock_history.dart';
import '../models/user.dart';
import '../models/store.dart';

class DatabaseService extends GetxService {
  late Isar isar;

  Future<DatabaseService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ProductSchema, CustomerSchema, SaleSchema, StockHistorySchema, UserSchema, StoreSchema , CategorySchema],
      directory: dir.path,
    );
    return this;
  }

  // Check if any user exists in the database
  Future<bool> hasUser() async {
    final userCount = await isar.users.count();
    return userCount > 0;
  }

  // Get the first user
  Future<User?> getUser() async {
    return await isar.users.where().findFirst();
  }

  // Save user data
  Future<void> saveUser(User user) async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  // Get store information
  Future<Store?> getStore() async {
    return await isar.stores.where().findFirst();
  }

  // Save store data
  Future<void> saveStore(Store store) async {
    await isar.writeTxn(() async {
      await isar.stores.put(store);
    });
  }

  // Product operations
  Future<List<Product>> getAllProducts() async {
    return await isar.products.where().findAll();
  }

  // get Low Stock Products

  Future<List<Product>> getLowStockProducts() async {
    return await isar.products
        .filter()
        .stockQuantityLessThan(10)
        .findAll();
  }

  // Get All Products

  Future<Product?> getProductById(int id) async {
    return await isar.products.get(id);
  }

  Future<void> saveProduct(Product product) async {
    await isar.writeTxn(() async {
      await isar.products.put(product);
    });
  }

  Future<void> deleteProduct(int id) async {
    await isar.writeTxn(() async {
      await isar.products.delete(id);
    });
  }

  // Customer operations
  Future<List<Customer>> getAllCustomers() async {
    return await isar.customers.where().findAll();
  }

  Future<void> saveCustomer(Customer customer) async {
    await isar.writeTxn(() async {
      await isar.customers.put(customer);
    });
  }

  Future<void> updateCustomer(Customer customer) async {
    await isar.writeTxn(() async {
      await isar.customers.put(customer);
    });
  }

  Future<void> deleteCustomer(int id) async {
    await isar.writeTxn(() async {
      await isar.customers.delete(id);
    });
  }

  // Sale operations
  Future<List<Sale>> getAllSales() async {
    return await isar.sales.where().findAll();
  }


  // get total sales all time

  Future<double> getTotalSales() async {
    final sales = await isar.sales.where().findAll();
    double total = 0;
    for (var sale in sales) {
      total += sale.totalAmount;
    }
    return total;
  }


  // get sale only today

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

  Future<void> saveSale(Sale sale) async {
    await isar.writeTxn(() async {
      await isar.sales.put(sale);
    });
  }

  Future<void> updateStore(Store store) async {
    await isar.writeTxn(() async {
      await isar.stores.put(store);
    });
  }

  //searchProducts

  Future<List<Product>> searchProducts(String query) async {
    return await isar.products
        .filter()
        .nameContains(query)
        .or()
        .skuContains(query)
        .findAll();
  }


  // Stock History operations
  Future<List<StockHistory>> getStockHistory(int productId) async {
    return await isar.stockHistorys
        .filter()
        .productIdEqualTo(productId)
        .findAll();
  }

  Future<void> saveStockHistory(StockHistory history) async {
    await isar.writeTxn(() async {
      await isar.stockHistorys.put(history);
    });
  }

  // User operations
  Future<List<User>> getAllUsers() async {
    return await isar.users.where().findAll();
  }
  Future<User?> getUserById(int id) async {
    return await isar.users.get(id);
  }


  Future<void> deleteUser(int id) async {
    await isar.writeTxn(() async {
      await isar.users.delete(id);
    });
  }


  //Category operations

  Future<List<Category>> getAllCategories() async {
    return await isar.categorys.where().findAll();
  }
  Future<Category?> getCategoryById(int id) async {
    return await isar.categorys.get(id);
  }

  Future<void> saveCategory(Category category) async {
    await isar.writeTxn(() async {
      await isar.categorys.put(category);
    });
  }

  Future<void> deleteCategory(int id) async {
    await isar.writeTxn(() async {
      await isar.categorys.delete(id);
    });
  }








}
