import 'package:get/get.dart';


class SidebarStaffController extends GetxController {
  var selected = "Dashboard".obs;
  var subSelected = RxnString();
  var expandedMenus = <String, bool>{}.obs;

  void selectMenu(String title) {
    selected.value = title;
    subSelected.value = null;
    update();
  }

  void selectSubItem(String parent, String subTitle) {
    selected.value = parent;
    subSelected.value = subTitle;
    update();
  }
  void toggleExpansion(String title) {
    if (expandedMenus.containsKey(title)) {
      expandedMenus[title] = !expandedMenus[title]!;
    } else {
      expandedMenus[title] = true;
    }
    update();
  }

  void syncWithRoute(String route) {
    String path = route.toLowerCase();

    if (path.contains('/dashboard-staff')) {
      selected.value = "Dashboard";
    }
    else if (path.contains('/car-inventory')) {
      selected.value = "Car Inventory";
    }
    else if (path.contains('/pickup-staff')) {
      selected.value = "Pick up";
    }
    else if (path.contains('/settings-staff')) {
      selected.value = "Settings";
    }
    else {
      selected.value = "";
    }

    subSelected.value = null;
    update();
  }
}