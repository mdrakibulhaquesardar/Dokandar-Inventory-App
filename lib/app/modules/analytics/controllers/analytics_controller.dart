import 'package:get/get.dart';
import '../../../core/services/database_service.dart';
import '../../../data/models/analytics_data.dart';

class AnalyticsController extends GetxController {
  DatabaseService get _databaseService => Get.find<DatabaseService>();

  final RxList<AnalyticsData> analyticsData = <AnalyticsData>[].obs;
  final RxList<AnalyticsSummary> summary = <AnalyticsSummary>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalytics();
    loadSummary();
  }

  Future<void> loadAnalytics() async {
    isLoading.value = true;
    try {
      final data = await _databaseService.getAllAnalytics();
      analyticsData.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load analytics');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadSummary() async {
    try {
      final data = await _databaseService.getAnalyticsSummary();
      summary.value = data;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load summary');
    }
  }

  AnalyticsData? getAnalyticsById(String id) {
    try {
      return analyticsData.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
}
