import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:path/path.dart' as path;

import '../models/category.dart';
import '../models/product.dart';
import '../models/customer.dart';
import '../models/sale.dart';
import '../models/stock_history.dart';
import '../models/user.dart';
import '../models/store.dart';

class BackupService extends GetxService {
  late Isar isar;
  late Directory _backupDir;

  Future<BackupService> init(Isar isarInstance) async {
    isar = isarInstance;
    _backupDir = await getExportDirectory() ?? Directory('/storage/emulated/0/Dokandar/Backup');
    return this;

  }

  //Request Storage Permission
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 13 and above, we need to request photos and videos permission
      if (await Permission.photos.status.isDenied) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          return false;
        }
      }

      // For Android 10 and above, we need to request manage external storage
      if (await Permission.manageExternalStorage.status.isDenied) {
        final status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          return false;
        }
      }

      // For older Android versions, request storage permission
      if (await Permission.storage.status.isDenied) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          return false;
        }
      }
    }
    return true;
  }

  // Get or Create Custom Directory
  Future<Directory?> getExportDirectory() async {
    try {
      final backupDir = Directory('/storage/emulated/0/Dokandar/Backup');

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      return backupDir;
    } catch (e) {
      print('Error creating backup directory: $e');
      return null;
    }
  }

  // Export JSON File to That Directory
  Future<String> exportIsarToFile() async {
    try {
      // Export all collections
      final sales = await isar.sales.where().findAll();
      final products = await isar.products.where().findAll();
      final customers = await isar.customers.where().findAll();
      final categories = await isar.categorys.where().findAll();
      final stockHistory = await isar.stockHistorys.where().findAll();
      final users = await isar.users.where().findAll();
      final stores = await isar.stores.where().findAll();

      // Convert to JSON
      final backupData = {
        'sales': sales
            .map((s) => {
                  'id': s.id,
                  'invoiceNumber': s.invoiceNumber,
                  'customerId': s.customerId,
                  'items': s.items
                      .map((item) => {
                            'productId': item.productId,
                            'productName': item.productName,
                            'quantity': item.quantity,
                            'unitPrice': item.unitPrice,
                            'totalPrice': item.totalPrice,
                          })
                      .toList(),
                  'totalAmount': s.totalAmount,
                  'discount': s.discount,
                  'paidAmount': s.paidAmount,
                  'dueAmount': s.dueAmount,
                  'saleDate': s.saleDate.toIso8601String(),
                  'notes': s.notes,
                  'isCompleted': s.isCompleted,
                  'createdAt': s.createdAt?.toIso8601String(),
                  'updatedAt': s.updatedAt?.toIso8601String(),
                })
            .toList(),
        'products': products
            .map((p) => {
                  'id': p.id,
                  'sku': p.sku,
                  'name': p.name,
                  'category': p.category,
                  'stockQuantity': p.stockQuantity,
                  'unitPrice': p.unitPrice,
                  'buyingPrice': p.buyingPrice,
                  'createdAt': p.createdAt.toIso8601String(),
                  'updatedAt': p.updatedAt?.toIso8601String(),
                  'isActive': p.isActive,
                })
            .toList(),
        'customers': customers
            .map((c) => {
                  'id': c.id,
                  'name': c.name,
                  'phone': c.phone,
                  'address': c.address,
                  'createdAt': c.createdAt.toIso8601String(),
                  'updatedAt': c.updatedAt?.toIso8601String(),
                })
            .toList(),
        'categories': categories
            .map((cat) => {
                  'id': cat.id,
                  'name': cat.name,
                  'description': cat.description,
                  'createdAt': cat.createdAt.toIso8601String(),
                  'updatedAt': cat.updatedAt?.toIso8601String(),
                })
            .toList(),
        'stockHistory': stockHistory
            .map((sh) => {
                  'id': sh.id,
                  'productId': sh.productId,
                  'quantity': sh.quantity,
                  'operation': sh.operation.index,
                  'timestamp': sh.timestamp.toIso8601String(),
                  'notes': sh.notes,
                  'unitPrice': sh.unitPrice,
                })
            .toList(),
        'users': users
            .map((u) => {
                  'id': u.id,
                  'name': u.name,
                  'email': u.email,
                  'phone': u.phone,
                  'password': u.password,
                  'role': u.role,
                  'isActive': u.isActive,
                  'isPremium': u.isPremium,
                  'createdAt': u.createdAt.toIso8601String(),
                  'updatedAt': u.updatedAt?.toIso8601String(),
                })
            .toList(),
        'stores': stores
            .map((st) => {
                  'id': st.id,
                  'name': st.name,
                  'address': st.address,
                  'phone': st.phone,
                  'email': st.email,
                  'website': st.website,
                  'logo': st.logo,
                  'createdAt': st.createdAt.toIso8601String(),
                  'updatedAt': st.updatedAt?.toIso8601String(),
                })
            .toList(),
      };

      // Create backup file with timestamp Like backup_12-04-2025_11-17-17


      final timestamp = DateFormat('dd-MM-yyyy_hh-mm-ss a').format(DateTime.now().toLocal());

      final backupFile = File(path.join(_backupDir.path, 'backup_$timestamp.json'));
      await backupFile.writeAsString(jsonEncode(backupData));
      return backupFile.path;
    } catch (e) {
      debugPrint('Error exporting data: $e');
      rethrow;
    }
  }

  // Check if backup exists
  Future<bool> backupExists() async {
    final filePath = await getExportDirectory();
    if (filePath == null) return false;
    return await filePath.exists();
  }

  // Get last backup date
  Future<DateTime?> getLastBackupDate() async {
    try {
      final files = await _backupDir.list().toList();
      if (files.isEmpty) return null;

      // Sort files by modification date
      files.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      return files.first.statSync().modified;
    } catch (e) {
      print('Error getting last backup date: $e');
      return null;
    }
  }

  Future<void> importIsarFromFile() async {
    try {
      final files = await _backupDir.list().toList();
      if (files.isEmpty) {
        throw Exception('কোন ব্যাকআপ ফাইল পাওয়া যায়নি');
      }

      // Sort files by modification date and get the latest
      files.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
      final latestBackup = File(files.first.path);

      // Read and parse backup file
      final backupData = jsonDecode(await latestBackup.readAsString());

      // Clear existing data
      await isar.writeTxn(() async {
        await isar.clear();
      });

      // Import data
      await isar.writeTxn(() async {
        // Import sales
        for (var saleData in backupData['sales']) {
          final sale = Sale(
            customerId: saleData['customerId'],
            items: (saleData['items'] as List)
                .map((item) => SaleItem.create(
                      productName: item['productName'],
                      productId: item['productId'],
                      quantity: item['quantity'],
                      unitPrice: item['unitPrice'],
                    ))
                .toList(),
            totalAmount: saleData['totalAmount'],
            discount: saleData['discount'],
            paidAmount: saleData['paidAmount'],
            invoiceNumber: saleData['invoiceNumber'],
            notes: saleData['notes'],
            isCompleted: saleData['isCompleted'],
          )
            ..id = saleData['id']
            ..dueAmount = saleData['dueAmount']
            ..saleDate = DateTime.parse(saleData['saleDate'])
            ..createdAt = saleData['createdAt'] != null
                ? DateTime.parse(saleData['createdAt'])
                : null
            ..updatedAt = saleData['updatedAt'] != null
                ? DateTime.parse(saleData['updatedAt'])
                : null;
          await isar.sales.put(sale);
        }

        // Import products
        for (var productData in backupData['products']) {
          final product = Product(
            name: productData['name'],
            category: productData['category'],
            stockQuantity: productData['stockQuantity'],
            unitPrice: productData['unitPrice'],
            buyingPrice: productData['buyingPrice'],
            sku: productData['sku'],
          )
            ..id = productData['id']
            ..createdAt = DateTime.parse(productData['createdAt'])
            ..updatedAt = productData['updatedAt'] != null
                ? DateTime.parse(productData['updatedAt'])
                : null
            ..isActive = productData['isActive'];
          await isar.products.put(product);
        }

        // Import customers
        for (var customerData in backupData['customers']) {
          final customer = Customer(
            name: customerData['name'],
            phone: customerData['phone'],
          )
            ..id = customerData['id']
            ..address = customerData['address']
            ..createdAt = DateTime.parse(customerData['createdAt'])
            ..updatedAt = customerData['updatedAt'] != null
                ? DateTime.parse(customerData['updatedAt'])
                : null;
          await isar.customers.put(customer);
        }

        // Import categories
        for (var categoryData in backupData['categories']) {
          final category = Category(
            name: categoryData['name'],
          )
            ..id = categoryData['id']
            ..description = categoryData['description']
            ..createdAt = DateTime.parse(categoryData['createdAt'])
            ..updatedAt = categoryData['updatedAt'] != null
                ? DateTime.parse(categoryData['updatedAt'])
                : null;
          await isar.categorys.put(category);
        }

        // Import stock history
        for (var stockHistoryData in backupData['stockHistory']) {
          final stockHistory = StockHistory(
            productId: stockHistoryData['productId'],
            quantity: stockHistoryData['quantity'],
            operation: StockOperation.values[stockHistoryData['operation']],
          )
            ..id = stockHistoryData['id']
            ..timestamp = DateTime.parse(stockHistoryData['timestamp'])
            ..notes = stockHistoryData['notes']
            ..unitPrice = stockHistoryData['unitPrice'];
          await isar.stockHistorys.put(stockHistory);
        }

        // Import users
        for (var userData in backupData['users']) {
          final user = User()
            ..id = userData['id']
            ..name = userData['name']
            ..email = userData['email']
            ..phone = userData['phone']
            ..password = userData['password']
            ..role = userData['role']
            ..isActive = userData['isActive']
            ..isPremium = userData['isPremium']
            ..createdAt = DateTime.parse(userData['createdAt'])
            ..updatedAt = userData['updatedAt'] != null
                ? DateTime.parse(userData['updatedAt'])
                : null;
          await isar.users.put(user);
        }

        // Import stores
        for (var storeData in backupData['stores']) {
          final store = Store(
            name: storeData['name'],
            address: storeData['address'],
            phone: storeData['phone'],
            email: storeData['email'],
            businessType:
                'retail', // Default value since it's not in backup data
          )
            ..id = storeData['id']
            ..website = storeData['website']
            ..logo = storeData['logo']
            ..createdAt = DateTime.parse(storeData['createdAt'])
            ..updatedAt = storeData['updatedAt'] != null
                ? DateTime.parse(storeData['updatedAt'])
                : null;
          await isar.stores.put(store);
        }
      });
    } catch (e) {
      print('Error importing data: $e');
      rethrow;
    }
  }
}
