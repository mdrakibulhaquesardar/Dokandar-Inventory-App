class Expense {
  int? id;

  DateTime? date;

  late String title;
  String? category;
  String? note;
  double amount = 0;

  Expense({
    required this.title,
    required this.amount,
    this.category,
    this.note,
    DateTime? date,
  }) {
    this.date = date ?? DateTime.now();
  }
}
