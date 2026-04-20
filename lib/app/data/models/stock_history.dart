class StockHistory {
  int? id;

  late int productId;
  late double quantity;
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

enum StockOperation { purchase, sale, adjustment, returnItem }
