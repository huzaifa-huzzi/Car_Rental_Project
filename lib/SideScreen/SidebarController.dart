import 'package:get/get.dart';


class SideBarController extends GetxController {
  var selected = "Dashboard".obs;
  var subSelected = RxnString();
  var incomeRedDot = 5.obs;
  var isExpensesExpanded = false.obs;

  void selectMenu(String title) {
    selected.value = title;
    subSelected.value = null;
    if (title != "Expenses") {
      isExpensesExpanded.value = false;
    }
  }

  void toggleExpensesSub() {
    isExpensesExpanded.value = !isExpensesExpanded.value;
    selected.value = "Expenses";
  }

  void selectSubItem(String parent, String subTitle) {
    selected.value = parent;
    subSelected.value = subTitle;
  }

  void setIncomeRedDot(int value) {
    incomeRedDot.value = value;
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
    } else if (route.startsWith('/staff')) {
      selected.value = "Staff";
    }

    // Reset states
    subSelected.value = null;
    isExpensesExpanded.value = false;
  }
}





