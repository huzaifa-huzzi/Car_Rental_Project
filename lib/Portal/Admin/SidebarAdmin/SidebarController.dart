


import 'package:get/get.dart';

class SideBarAdminController extends GetxController {
  var selected = "Dashboard".obs;
  var subSelected = RxnString();
  var expandedMenus = <String, bool>{}.obs;

  void selectMenu(String title) {
    selected.value = title;
    subSelected.value = null;
  }

  void selectSubItem(String parent, String subTitle) {
    selected.value = parent;
    subSelected.value = subTitle;
  }

  void toggleExpansion(String title) {
    if (expandedMenus.containsKey(title)) {
      expandedMenus[title] = !expandedMenus[title]!;
    } else {
      expandedMenus[title] = true;
    }
  }

  void syncWithRoute(String route) {
    String path = route.toLowerCase();
    if (path == '/dashboard-admin' || path == '/' || path.isEmpty) {
      selected.value = "Dashboard";
    }
    else if (path.contains('/companies')) {
      selected.value = "Companies";
    } else if (path.contains('/reports')) {
      selected.value = "Reports";
    } else if (path.contains('/subscription')) {
      selected.value = "Subscription";
    } else if (path.contains('/payment')) {
      selected.value = "Payment";
    } else if (path.contains('/branding')) {
      selected.value = "Branding";
    } else if (path.contains('/user-role')) {
      selected.value = "User and Role";
    } else if (path.contains('/help')) {
      selected.value = "Help Center";
    }

    subSelected.value = null;
    update();
  }
}