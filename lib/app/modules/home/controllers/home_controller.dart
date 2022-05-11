import 'package:ble_controller/app/global/controllers/permission_handler_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _permissionController = Get.find<PermissionHandlerController>();

  @override
  void onInit() {
    _permissionController.checkAndRequestPermission();
    super.onInit();
  }
}
