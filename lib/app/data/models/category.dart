
import 'package:isar/isar.dart';

part 'category.g.dart';

@collection
class Category {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String name;
  String? description;
  late DateTime createdAt;
  DateTime? updatedAt;
  late bool isActive;

  Category({
    required this.name,
    this.description,
    this.isActive = true,
  }) {
    createdAt = DateTime.now();
    updatedAt = null;
  }


}