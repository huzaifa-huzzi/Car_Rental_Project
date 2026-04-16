import 'package:car_rental_project/Portal/Staff/Setting/ReusableWidget/CustomCalendarSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingStaffController extends GetxController {
  var selectedTabIndex = 0.obs;
  var isDropdownOpen = false.obs;
  var selectedSubTabIndex = 0.obs;
  var openedDropdown2;
  var isEditing = false.obs;

  void changeSubTab(int index) {
    selectedSubTabIndex.value = index;
  }

  void toggleEdit(bool value) {
    isEditing.value = value;
  }




  void changeTab(int index) {
    selectedTabIndex.value = index;
    isDropdownOpen.value = false;
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  var focusedField = "".obs;
  var selectedGender = "Select Gender".obs;

  void setFocus(String label) => focusedField.value = label;
  void clearFocus() => focusedField.value = "";

  final LayerLink dobLink = LayerLink();
  final TextEditingController dobTextController = TextEditingController();
  var isDateDropOpen = false.obs;
  OverlayEntry? calendarOverlay;

  void toggleCalendar(BuildContext context, LayerLink link, TextEditingController targetController) {
    if (calendarOverlay != null) {
      removeCalendar();
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      double calendarWidth = screenWidth < 500 ? screenWidth * 0.85 : 280;
      calendarOverlay = _createCalendarOverlay(context, link, targetController, calendarWidth);
      Overlay.of(context).insert(calendarOverlay!);
      isDateDropOpen.value = true;
    }
  }

  OverlayEntry _createCalendarOverlay(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      double width,
      ) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 500;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeCalendar,
              behavior: HitTestBehavior.opaque,
            ),
          ),
          isMobile
              ? Center(
            child: Material(
              elevation: 15,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: CustomCalendarSettings(
                width: screenWidth * 0.9,
                onCancel: removeCalendar,
                onDateSelected: (date) {
                  targetController.text = "${date.day}/${date.month}/${date.year}";
                  removeCalendar();
                },
              ),
            ),
          )
              : CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 8),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: CustomCalendarSettings(
                width: width,
                onCancel: removeCalendar,
                onDateSelected: (date) {
                  targetController.text = "${date.day}/${date.month}/${date.year}";
                  removeCalendar();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void removeCalendar() {
    calendarOverlay?.remove();
    calendarOverlay = null;
    isDateDropOpen.value = false;
  }


}