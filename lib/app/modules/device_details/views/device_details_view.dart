import 'package:ble_controller/app/global/controllers/ble_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/device_details_controller.dart';

class DeviceDetailsView extends GetView<DeviceDetailsController> {
  DeviceDetailsView({Key? key}) : super(key: key);
  final _bleController = Get.find<BleController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeviceDetailsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemBuilder: (context, index) {
              var service = _bleController.discoveredServices[index];
              return ListTile(
                title: Text(service.serviceId.toString()),
              );
            },
          ),
        ),
      ),
    );
  }
}
