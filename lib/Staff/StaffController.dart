

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffController extends GetxController{
  final RxString selectedSearchType2 = "Staff Name".obs;


  /// Pagination Bar
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 10.obs;
  final RxInt selectedView3 = 0.obs;

  RxList<Map<String, dynamic>> carList3 = <Map<String, dynamic>>[].obs;

  int get totalPages {
    if (carList3.isEmpty) return 1;
    return (carList3.length / pageSize3.value).ceil();
  }

  List<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage3.value - 1) * pageSize3.value;
    int end = start + pageSize3.value;

    if (start >= carList3.length) return [];
    return carList3.sublist(
        start, end > carList3.length ? carList3.length : end);
  }

  void goToPreviousPage() {
    if (currentPage3.value > 1) currentPage3.value--;
  }

  void goToNextPage() {
    if (currentPage3.value < totalPages) currentPage3.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage3.value = page;
  }

  void setPageSize(int newSize) {
    pageSize3.value = newSize;
    currentPage3.value = 1;
  }

  /// Table View Screen Data
  var hoveredRowIndex = (-1).obs;

  void generateDummyData() {
    carList3.clear();
    for (int i = 0; i < 25; i++) {
      carList3.add({
        "customerName": "Jack Morrison",
        "customerEmail": "jackMorrison@rhyta.com",
        "vin": "JTNBA3HK003001234",
        "reg": "1234567890",
        "carRent": "Toyota Corolla (2017)",
        "damage": i % 4 == 0,
        "dropoffDate": "Aug 2, 2026",
        "status": "Completed",
      });
    }
  }

  /// Add Staff Screen
  final firstNameC = TextEditingController();
  final lastNameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final positionC = TextEditingController();


  var selectedStatus = 'Active'.obs;
  var permissions = <String>[].obs;

  final List<String> statusItems = ["Active", "Awaiting", "InActive", "Suspended"];

  void togglePermission(String val) {
    if (permissions.contains(val)) {
      permissions.remove(val);
    } else {
      permissions.add(val);
    }
  }

  void submitData() {
    print("Sending Invitation for: ${firstNameC.text}");
  }

  /// Edit Staff Screen
  final firstNameCEdit = TextEditingController();
  final lastNameCEdit = TextEditingController();
  final emailCEdit = TextEditingController();
  final phoneCEdit = TextEditingController();
  final positionCEdit = TextEditingController();


  var selectedStatusEdit = 'Active'.obs;
  var permissionsEdit = <String>[].obs;

  final List<String> statusItemsEdit = ["Active", "Awaiting", "InActive", "Suspended"];

  void togglePermissionEdit(String val) {
    if (permissionsEdit.contains(val)) {
      permissionsEdit.remove(val);
    } else {
      permissionsEdit.add(val);
    }
  }

  void submitDataEdit() {
    print("Sending Invitation for: ${firstNameCEdit.text}");
  }

  @override
  void onClose() {
    firstNameC.dispose();
    lastNameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    positionC.dispose();
    firstNameCEdit.dispose();
    lastNameCEdit.dispose();
    emailCEdit.dispose();
    phoneCEdit.dispose();
    positionCEdit.dispose();
    super.onClose();
  }


  @override
  void onInit() {
    super.onInit();
    generateDummyData();
  }




}