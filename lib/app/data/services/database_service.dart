import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';
import '../models/customer.dart';
import '../models/sale.dart';
import '../models/stock_history.dart';

class DatabaseService extends GetxService {
  late Isar isar;

  Future<DatabaseService> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ProductSchema, CustomerSchema, SaleSchema, StockHistorySchema],
      directory: dir.path,
    );
    return this;
  }

  // Product operations
  Future<List<Product>> getAllProducts() async {
    return await isar.products.where().findAll();
  }

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

  // Sale operations
  Future<List<Sale>> getAllSales() async {
    return await isar.sales.where().findAll();
  }

  Future<void> saveSale(Sale sale) async {
    await isar.writeTxn(() async {
      await isar.sales.put(sale);
    });
  }

  // // Stock History operations
  // Future<List<StockHistory>> getStockHistory(int productId) async {
  //   return await isar.stockHistories
  //       .filter()
  //       .productIdEqualTo(productId)
  //       .findAll();
  // }
  //
  // Future<void> saveStockHistory(StockHistory history) async {
  //   await isar.writeTxn(() async {
  //     await isar.stockHistories.put(history);
  //   });
  // }
}
