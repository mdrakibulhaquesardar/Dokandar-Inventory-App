import 'package:isar/isar.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  @Index()
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

