import 'package:get/get.dart';

class SideBarController extends GetxController {
  var selected = "Dashboard".obs;
  var subSelected = RxnString();
  var incomeRedDot = 5.obs;

  var expandedMenus = <String, bool>{}.obs;

  void toggleExpansion(String title) {
    if (expandedMenus.containsKey(title)) {
      expandedMenus[title] = !expandedMenus[title]!;
    } else {
      expandedMenus[title] = true;
    }
  }

  void selectMenu(String title) {
    selected.value = title;
    subSelected.value = null;
    expandedMenus.forEach((key, value) {
      if (key != title) expandedMenus[key] = false;
    });
  }

  void selectSubItem(String parent, String subTitle) {
    selected.value = parent;
    subSelected.value = subTitle;
  }

  void syncWithRoute(String route) {
    if (route == '/dashboard' || route == '/') {
      selected.value = "Dashboard";
    } else if (route.startsWith('/carInventory')) {
      selected.value = "Car Inventory";
    } else if (route.startsWith('/customers')) {
      selected.value = "Customers";
    } else if (route.startsWith('/pickupcar')) {
      selected.value = "Pickup Car";
    } else if (route.startsWith('/dropoffCar')) {
      selected.value = "Dropoff Car";
    }else if (route.startsWith('/Payment')) {
      selected.value = "Payment";
    } else if (route.startsWith('/staff')) {
      selected.value = "Staff";
    }
    subSelected.value = null;
  }
}




