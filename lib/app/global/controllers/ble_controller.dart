import 'dart:async';

import 'package:ble_controller/app/data/services/log/logger.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';

class BleController extends GetxController {
  final flutterReactiveBle = FlutterReactiveBle();
  var discoveredDeviceList = <DiscoveredDevice>[].obs;
  var discoveredServices = <DiscoveredService>[].obs;

  StreamSubscription? streamSubscription;
  void startScanning() {
    streamSubscription =
        flutterReactiveBle.scanForDevices(withServices: []).listen((device) {
      logger.i('Discovered device names ---> ${device.name}');
      final knownDeviceIndex =
          discoveredDeviceList.indexWhere((d) => d.id == device.id);
      if (knownDeviceIndex >= 0) {
        discoveredDeviceList[knownDeviceIndex] = device;
      } else {
        discoveredDeviceList.add(device);
      }
    });
  }

  //Connect to device
  late StreamSubscription<ConnectionStateUpdate> _connection;
  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();
  Future<void> connect(String deviceId) async {
    _connection = flutterReactiveBle.connectToDevice(id: deviceId).listen(
      (update) {
        logger.i(
            'ConnectionState for device $deviceId : ${update.connectionState}');
        _deviceConnectionController.add(update);
      },
      onError: (Object e) =>
          logger.e('Connecting to device $deviceId resulted in error $e'),
    );
  }

  Future<void> discoverServices(String deviceId) async {
    try {
      logger.i('Start discovering services for: $deviceId');
      final result = await flutterReactiveBle.discoverServices(deviceId);
      for (var element in result) {
        discoveredServices.add(element);
      }
      logger.i('Discovering services finished');
    } on Exception catch (e) {
      logger.e('Error occured when discovering services: $e');
      rethrow;
    }
  }

  Future<void> disconnect(String deviceId) async {
    try {
      logger.i('disconnecting to device: $deviceId');
      await _connection.cancel();
    } on Exception catch (e, _) {
      logger.e("Error disconnecting from a device: $e");
    } finally {
      // Since [_connection] subscription is terminated, the "disconnected" state cannot be received and propagated
      _deviceConnectionController.add(
        ConnectionStateUpdate(
          deviceId: deviceId,
          connectionState: DeviceConnectionState.disconnected,
          failure: null,
        ),
      );
    }
  }

  void stopScan() {
    if (streamSubscription != null) {
      streamSubscription!.cancel();
    }
    logger.w('Scann has stopped!');
  }
}
