class Category {
  int? id;

  late String name;
  String? description;
  late DateTime createdAt;
  DateTime? updatedAt;
  late bool isActive;

  Category({required this.name, this.description, this.isActive = true}) {
    createdAt = DateTime.now();
    updatedAt = null;
  }
}
