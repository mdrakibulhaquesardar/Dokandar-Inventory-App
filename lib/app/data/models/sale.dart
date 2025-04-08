import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'product.dart';
import 'customer.dart';

part 'sale.g.dart';

@collection
class Sale {
  Id id = Isar.autoIncrement;

  late String invoiceNumber;
  late int customerId;
  late List<SaleItem> items;
  late double totalAmount;
  late double discount;
  late double paidAmount;
  late DateTime saleDate;
  String? notes;
  late bool isCompleted;

  Sale({
    required this.customerId,
    required this.items,
    required this.totalAmount,
    this.discount = 0,
    required this.paidAmount,
    required this.invoiceNumber,
    this.notes,
    this.isCompleted = true,
  }) {
    saleDate = DateTime.now();
  }

  // Factory constructor for generating invoice number
  factory Sale.withGeneratedInvoice({
    required int customerId,
    required List<SaleItem> items,
    required double totalAmount,
    double discount = 0,
    required double paidAmount,
    String? notes,
    bool isCompleted = true,
  }) {
    return Sale(
      customerId: customerId,
      items: items,
      totalAmount: totalAmount,
      discount: discount,
      paidAmount: paidAmount,
      invoiceNumber: const Uuid().v4(),
      notes: notes,
      isCompleted: isCompleted,
    );
  }

  double get dueAmount => totalAmount - discount - paidAmount;
}

@embedded
class SaleItem {
  late int productId;
  late double quantity;
  late double unitPrice;
  late double totalPrice;

  SaleItem() {
    productId = 0;
    quantity = 0;
    unitPrice = 0;
    totalPrice = 0;
  }

  // Named constructor for creating a SaleItem
  static SaleItem create({
    required int productId,
    required double quantity,
    required double unitPrice,
  }) {
    final item = SaleItem()
      ..productId = productId
      ..quantity = quantity
      ..unitPrice = unitPrice
      ..totalPrice = quantity * unitPrice;
    return item;
  }
}
