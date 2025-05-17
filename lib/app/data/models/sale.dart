import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

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
  late double dueAmount;
  late DateTime saleDate;
  String? notes;
  late bool isCompleted;
  DateTime? updatedAt;
  DateTime? createdAt;

  Sale({
    required this.customerId,
    required this.items,
    required this.totalAmount,
    this.discount = 0,
    required this.paidAmount,
    this.dueAmount = 0,
    required this.invoiceNumber,
    this.notes,
    this.isCompleted = true,

  }) {
    createdAt = DateTime.now();
    updatedAt = null;
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


}

@embedded
class SaleItem {
  late String productName;
  late int productId;
  late double quantity;
  late double unitPrice;
  late double totalPrice;

  SaleItem() {
    productName = '';
    productId = 0;
    quantity = 0;
    unitPrice = 0;
    totalPrice = 0;
  }

  // Named constructor for creating a SaleItem
  static SaleItem create({
    required String productName,
    required int productId,
    required double quantity,
    required double unitPrice,
  }) {
    final item = SaleItem()
      ..productName = productName
      ..productId = productId
      ..quantity = quantity
      ..unitPrice = unitPrice
      ..totalPrice = quantity * unitPrice;
    return item;
  }
}
