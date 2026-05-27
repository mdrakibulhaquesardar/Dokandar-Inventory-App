import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

/// GetX service that tracks network connectivity state reactively.
class ConnectivityService extends GetxService {
  static ConnectivityService get instance => Get.find<ConnectivityService>();

  final RxBool isOnline = false.obs;

  Future<ConnectivityService> init() async {
    // Check current state immediately
    final result = await Connectivity().checkConnectivity();
    isOnline.value = _isConnected(result);

    // Subscribe to changes
    Connectivity().onConnectivityChanged.listen((results) {
      isOnline.value = _isConnected(results);
    });

    return this;
  }

  bool _isConnected(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }
}
