import 'package:isar/isar.dart';

part 'stock_history.g.dart';

@collection
class StockHistory {
  Id id = Isar.autoIncrement;

  late int productId;
  late double quantity;
  @enumerated
  late StockOperation operation;
  late DateTime timestamp;
  String? notes;
  double? unitPrice;

  StockHistory({
    required this.productId,
    required this.quantity,
    required this.operation,
    this.notes,
    this.unitPrice,
  }) : timestamp = DateTime.now();
}

@Enumerated(EnumType.ordinal)
enum StockOperation {
  purchase,
  sale,
  adjustment,
  returnItem,
}
