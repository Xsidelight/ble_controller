import 'package:ble_controller/app/global/controllers/ble_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/global/controllers/permission_handler_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<PermissionHandlerController>(PermissionHandlerController());
  Get.put<BleController>(BleController());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
