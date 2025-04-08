import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'product.g.dart';

@collection
class Product {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String sku;

  late String name;
  late String category;
  late double stockQuantity;
  late double unitPrice;
  late double buyingPrice;
  late DateTime createdAt;
  DateTime? updatedAt;
  late bool isActive;

  Product({
    required this.name,
    required this.category,
    required this.stockQuantity,
    required this.unitPrice,
    required this.buyingPrice,
    required this.sku,
    this.isActive = true,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }

  // Factory constructor for generating SKU
  factory Product.withGeneratedSku({
    required String name,
    required String category,
    required double stockQuantity,
    required double unitPrice,
    required double buyingPrice,
    bool isActive = true,
  }) {
    return Product(
      name: name,
      category: category,
      stockQuantity: stockQuantity,
      unitPrice: unitPrice,
      buyingPrice: buyingPrice,
      sku: const Uuid().v4(),
      isActive: isActive,
    );
  }

  // Calculate profit margin
  double get profitMargin => ((unitPrice - buyingPrice) / buyingPrice) * 100;

  // Check if stock is low (less than 10 units)
  bool get isLowStock => stockQuantity < 10;

  // Update stock quantity
  void updateStock(double quantity) {
    stockQuantity += quantity;
    updatedAt = DateTime.now();
  }
}
