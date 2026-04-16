import 'package:car_rental_project/Portal/Staff/SidebarStaff/SidebarStaffController.dart';
import 'package:get/get.dart';

class SidebarStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SidebarStaffController>(
          () => SidebarStaffController(),
      fenix: true,
    );
  }
}