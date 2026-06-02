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
    final r = route.toLowerCase().split('?').first;

    if (r == '/dashboard' || r == '/') {
      selected.value = "Dashboard";
      subSelected.value = null;

      // Car Inventory
    } else if (r.startsWith('/carinventory') ||
        r.startsWith('/cardetails') ||
        r.startsWith('/addnewcar') ||
        r.startsWith('/editcar')) {
      selected.value = "Car Inventory";
      subSelected.value = null;

      // Customers
    } else if (r.startsWith('/customers') ||
        r.startsWith('/addnewcustomer') ||
        r.startsWith('/editcustomers') ||
        r.startsWith('/customerdetails') ||
        r.startsWith('/steptwocustomer')) {
      selected.value = "Customers";
      subSelected.value = null;
    } else if (r.startsWith('/pickupcar') ||
        r.startsWith('/pickupdetail') ||
        r.startsWith('/addpickup') ||
        r.startsWith('/steponepickup') ||
        r.startsWith('/steptwowidgetscreen') ||
        r.startsWith('/stepthreewidgetscreen') ||
        r.startsWith('/editpickup') ||
        r.startsWith('/pickupt&c') ||
        r.startsWith('/addpickupt&c') ||
        r.startsWith('/pickupt&cdescription')) {
      selected.value = "Pickup Car";
      if (r.contains('t&c')) {
        subSelected.value = "Pickup T&C";
      } else {
        subSelected.value = null;
      }
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

      if (r.contains('t&c')) {
        subSelected.value = "DropOff T&C";
      } else {
        subSelected.value = null;
      }

      // Staff
    } else if (r.startsWith('/staff') ||
        r.startsWith('/editstaffscreen') ||
        r.startsWith('/addstaff')) {
      selected.value = "Staff";
      subSelected.value = null;

      // Payment
    } else if (r.startsWith('/payment') ||
        r.startsWith('/addpayment') ||
        r.startsWith('/invoicesdetail')) {
      selected.value = "Payment";
      subSelected.value = null;
    }
  }
}




