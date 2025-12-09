import 'package:get/get.dart';

class SideBarController extends GetxController {
  var selected = "Car Inventory".obs;
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

   /// Mobile appbar code
}
