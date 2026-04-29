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
    final r = route.toLowerCase();

    if (r == '/dashboard' || r == '/') {
      selected.value = "Dashboard";

      // Car Inventory
    } else if (r.startsWith('/carinventory') ||
        r.startsWith('/cardetails') ||
        r.startsWith('/addnewcar') ||
        r.startsWith('/editcar')) {
      selected.value = "Car Inventory";

      // Customers
    } else if (r.startsWith('/customers') ||
        r.startsWith('/customerdetails') ||
        r.startsWith('/addnewcustomer') ||
        r.startsWith('/editcustomers') ||
        r.startsWith('/steptwocustomer')) {
      selected.value = "Customers";

      // Pickup Car
    } else if (r.startsWith('/pickupcar') ||
        r.startsWith('/pickupdetail') ||
        r.startsWith('/addpickup') ||
        r.startsWith('/steponepickup') ||
        r.startsWith('/steptwowidgetscreen') ||
        r.startsWith('/stepthreewidgetscreen') ||
        r.startsWith('/editpickup')) {
      selected.value = "Pickup Car";

      // Pickup T&C
    } else if (r.startsWith('/pickupt&c') ||
        r.startsWith('/addpickupt&c') ||
        r.startsWith('/pickupt&cdescription')) {
      selected.value = "Pickup T&C";

      // Dropoff Car
    } else if (r.startsWith('/dropoffcar') ||
        r.startsWith('/dropoffdetail') ||
        r.startsWith('/adddropoff') ||
        r.startsWith('/adddropoffdetailtwo') ||
        r.startsWith('/steptwodropoff') ||
        r.startsWith('/stepthreedropoff') ||
        r.startsWith('/dropofft&c') ||
        r.startsWith('/adddropofft&c') ||
        r.startsWith('/dropofft&cdescription')) {
      selected.value = "Dropoff Car";

      // Staff
    } else if (r.startsWith('/staff') ||
        r.startsWith('/editstaffscreen') ||
        r.startsWith('/addstaff')) {
      selected.value = "Staff";

      // Payment
    } else if (r.startsWith('/payment') ||
        r.startsWith('/addpayment') ||
        r.startsWith('/invoicesdetail')) {
      selected.value = "Payment";
    }

    subSelected.value = null;
  }
}




