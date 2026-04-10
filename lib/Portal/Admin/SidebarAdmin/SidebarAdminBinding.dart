

import 'package:car_rental_project/Portal/Admin/SidebarAdmin/SidebarController.dart';
import 'package:get/get.dart';

class SidebarAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SideBarAdminController>(
          () => SideBarAdminController(),
      fenix: true,
    );
  }
}
