// import 'package:get/get.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../../data/models/category.dart';
//
// class CategoryController extends GetxController {
//   late Future<Isar> db;
//   RxList<Category> categories = <Category>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     initDB();
//   }
//
//   Future<void> initDB() async {
//     final dir = await getApplicationDocumentsDirectory();
//     db = Future.value(await Isar.open(
//       [CategorySchema],
//       directory: dir.path,
//     ));
//     loadCategories();
//   }
//
//   Future<void> loadCategories() async {
//     final isar = await db;
//     final allCategories = await isar.categorys.where().findAll();
//     categories.value = allCategories;
//   }
//
//   Future<void> addCategory(String name, String description) async {
//     final category = Category()
//       ..name = name
//       ..description = description;
//
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.categorys.put(category);
//     });
//     await loadCategories();
//   }
//
//   Future<void> updateCategory(Category category) async {
//     category.updatedAt = DateTime.now();
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.categorys.put(category);
//     });
//     await loadCategories();
//   }
//
//   Future<void> deleteCategory(int id) async {
//     final isar = await db;
//     await isar.writeTxn(() async {
//       await isar.categorys.delete(id);
//     });
//     await loadCategories();
//   }
// }