import 'package:get/get.dart';

import '../controllers/setting_controller.dart';
import '../controllers/feedback_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
    Get.lazyPut<FeedbackController>(
      () => FeedbackController(),
    );
  }
}
