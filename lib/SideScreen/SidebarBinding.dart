import 'package:car_rental_project/SideScreen/SideBarController.dart';
import 'package:get/get.dart';

class SidebarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SideBarController>(
          () => SideBarController(),
      fenix: true,
    );
  }
}
