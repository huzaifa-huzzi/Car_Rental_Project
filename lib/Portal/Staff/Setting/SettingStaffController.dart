import 'package:get/get.dart';

class SettingStaffController extends GetxController {
  var selectedTabIndex = 0.obs;
  var isDropdownOpen = false.obs;
  var selectedSubTabIndex = 0.obs;

  void changeSubTab(int index) {
    selectedSubTabIndex.value = index;
  }


  void changeTab(int index) {
    selectedTabIndex.value = index;
    isDropdownOpen.value = false;
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  var focusedField = "".obs;

  void setFocus(String label) => focusedField.value = label;
  void clearFocus() => focusedField.value = "";
}