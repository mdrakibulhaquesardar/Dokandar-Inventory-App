import '../../data/models/category.dart';
import '../../data/models/product.dart';
import '../../data/models/customer.dart';
import '../../data/models/sale.dart';
import '../../data/models/stock_history.dart';
import '../../data/models/user.dart';
import '../../data/models/store.dart';

abstract class DatabaseServiceRepository {
  // Database lifecycle
  Future<void> init();
  Future<void> close();
  Future<void> clear();

  // User operations
  Future<bool> hasUser();
  Future<User?> getUser();
  Future<void> saveUser(User user);
  Future<List<User>> getAllUsers();
  Future<User?> getUserById(int id);
  Future<void> deleteUser(int id);

  // Store operations
  Future<Store?> getStore();
  Future<void> saveStore(Store store);
  Future<void> updateStore(Store store);

  // Product operations
  Future<List<Product>> getAllProducts();
  Future<int> getTotalProducts();
  Future<double> getTotalProductsPrice();
  Future<List<Product>> getLowStockProducts();
  Future<Product?> getProductById(int id);
  Future<void> saveProduct(Product product);
  Future<void> deleteProduct(int id);
  Future<List<Product>> searchProducts(String query);

  // Customer operations
  Future<List<Customer>> getAllCustomers();
  Future<Customer?> getCustomerById(int id);
  Future<String?> getCustomerNameById(int id);
  Future<void> saveCustomer(Customer customer);
  Future<void> updateCustomer(Customer customer);
  Future<void> deleteCustomer(int id);

  // Sale operations
  Future<List<Sale>> getAllSales();
  Future<double> getTotalSales();
  Future<List<Sale>> getSalesToday();
  Future<double> getTotalSalesToday();
  Future<void> saveSale(Sale sale);
  Future<void> totalRevenue();
  Future<void> deleteSale(int id);
  Future<void> updateSalePayment(int id, double paidAmount, double dueAmount);

  // Stock History operations
  Future<List<StockHistory>> getStockHistory(int productId);
  Future<void> saveStockHistory(StockHistory history);

  // Category operations
  Future<List<Category>> getAllCategories();
  Future<Category?> getCategoryById(int id);
  Future<void> saveCategory(Category category);
  Future<void> deleteCategory(int id);
}
