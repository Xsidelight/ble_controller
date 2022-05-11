import 'package:ble_controller/app/global/controllers/ble_controller.dart';
import 'package:ble_controller/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final bleController = Get.find<BleController>();

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<BleController>(
              builder: (controller) {
                return SizedBox(
                  height: 400,
                  child: GetBuilder<BleController>(
                    builder: (context) {
                      return Obx(
                        () => ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            title:
                                Text(controller.discoveredDeviceList[index].name),
                            subtitle:
                                Text(controller.discoveredDeviceList[index].id),
                            onTap: () {
                              controller.connect(
                                  controller.discoveredDeviceList[index].id);
                              Get.toNamed(Routes.DEVICE_DETAILS);
                            },
                            onLongPress: () => controller.disconnect(
                                controller.discoveredDeviceList[index].id),
                          ),
                          itemCount: controller.discoveredDeviceList.length,
                        ),
                      );
                    }
                  ),
                );
              },
            ),
            const Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () => bleController.startScanning(),
              child: const Text('Start Scanning'),
            ),
            ElevatedButton(
              onPressed: () => bleController.stopScan(),
              child: const Text('Stop Scanning'),
            ),
          ],
        ),
      ),
    );
  }
}
