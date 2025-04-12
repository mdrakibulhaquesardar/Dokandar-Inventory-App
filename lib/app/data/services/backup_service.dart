import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' hide Category;

import '../models/category.dart';
import '../models/product.dart';
import '../models/customer.dart';
import '../models/sale.dart';
import '../models/stock_history.dart';
import '../models/user.dart';
import '../models/store.dart';

class BackupService extends GetxService {
  late Isar isar;

  Future<BackupService> init(Isar isarInstance) async {
    isar = isarInstance;
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
      final directory = await getExportDirectory();
      final file = File('${directory?.path}/dokandar_backup.json');

      // Get all data from collections
      final products = await isar.products.where().findAll();
      final customers = await isar.customers.where().findAll();
      final sales = await isar.sales.where().findAll();
      final stockHistory = await isar.stockHistorys.where().findAll();
      final users = await isar.users.where().findAll();
      final stores = await isar.stores.where().findAll();
      final categories = await isar.categorys.where().findAll();

      // Convert to JSON
      final Map<String, dynamic> data = {
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
        'sales': sales
            .map((s) => {
                  'id': s.id,
                  'invoiceNumber': s.invoiceNumber,
                  'customerId': s.customerId,
                  'items': s.items
                      .map((item) => {
                            'productId': item.productId,
                            'quantity': item.quantity,
                            'unitPrice': item.unitPrice,
                            'total': item.totalPrice,
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
        'categories': categories
            .map((cat) => {
                  'id': cat.id,
                  'name': cat.name,
                  'description': cat.description,
                  'createdAt': cat.createdAt.toIso8601String(),
                  'updatedAt': cat.updatedAt?.toIso8601String(),
                })
            .toList(),
      };

      // Write to file
      await file.writeAsString(jsonEncode(data));
      return file.path;
    } catch (e) {
      debugPrint('Error exporting data: $e');
      rethrow;
    }
  }

  // Get backup file path
  Future<String?> getBackupFilePath() async {
    final exportDir = await getExportDirectory();
    if (exportDir == null) return null;
    return '${exportDir.path}/dokandar_backup.json';
  }

  // Check if backup exists
  Future<bool> backupExists() async {
    final filePath = await getBackupFilePath();
    if (filePath == null) return false;
    return await File(filePath).exists();
  }

  // Get last backup date
  Future<DateTime?> getLastBackupDate() async {
    final filePath = await getBackupFilePath();
    if (filePath == null) return null;

    final file = File(filePath);
    if (await file.exists()) {
      return await file.lastModified();
    }
    return null;
  }
}
