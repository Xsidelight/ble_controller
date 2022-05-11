
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerController extends GetxController {
  Future<void> checkAndRequestPermission() async {
    final statusBluetooth = await Permission.bluetooth.status;
    final statusLocation = await Permission.location.status;
    if (statusBluetooth.isDenied || statusLocation.isDenied) {
      await [
        Permission.location,
        Permission.bluetooth,
      ].request();
    }
  }
}
