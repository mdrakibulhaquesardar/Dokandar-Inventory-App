import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/customer.dart';

class DueCustomersController extends GetxController {
  final DatabaseService _databaseService = Get.find<DatabaseService>();
  final RxList<Customer> dueCustomers = <Customer>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDueCustomers();
  }

  Future<void> loadDueCustomers() async {
    isLoading.value = true;
    try {
      final allCustomers = await _databaseService.getAllCustomers();
      dueCustomers.value = allCustomers.where((customer) => customer.hasDue).toList();
    } catch (e) {
      Get.snackbar('ত্রুটি', 'বাকিদার তালিকা লোড করতে ব্যর্থ হয়েছে');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateDuePayment(Customer customer, double amount) async {
    if (amount <= 0 || amount > customer.totalDue) return;

    try {
      customer.totalDue -= amount;
      customer.hasDue = customer.totalDue > 0;
      customer.updatedAt = DateTime.now();

      await _databaseService.saveCustomer(customer);
      await loadDueCustomers(); // Refresh the list

      Get.back(result: true);
      Get.snackbar(
        'সফল',
        'পেমেন্ট আপডেট করা হয়েছে',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'ত্রুটি',
        'পেমেন্ট আপডেট করতে ব্যর্থ হয়েছে',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
