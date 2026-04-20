import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/customer.dart';
import '../../../utils/vibration_helper.dart';
import 'package:dokandar_app_inventory/l10n/app_localizations.dart';

class DueCustomersController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();
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
      dueCustomers.value =
          allCustomers.where((customer) => customer.hasDue).toList();
    } catch (e) {
      final l10n = AppLocalizations.of(Get.context!)!;
      Get.snackbar(l10n.error, l10n.failedToLoadDueCustomers);
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

      VibrationHelper.onSuccess();
      Get.back(result: true);
      final l10n = AppLocalizations.of(Get.context!)!;
      Get.snackbar(
        l10n.success,
        l10n.paymentUpdated,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      final l10n = AppLocalizations.of(Get.context!)!;
      Get.snackbar(
        l10n.error,
        l10n.failedToUpdatePayment,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
