import 'package:get/get.dart';
import '../controllers/users_controller.dart';
import '../controllers/roles_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(() => UsersController());
    Get.lazyPut<RolesController>(() => RolesController());
  }
}
