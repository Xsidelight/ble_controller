import 'package:get/get.dart';

import '../modules/device_details/bindings/device_details_binding.dart';
import '../modules/device_details/views/device_details_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DEVICE_DETAILS,
      page: () => DeviceDetailsView(),
      binding: DeviceDetailsBinding(),
    ),
  ];
}
