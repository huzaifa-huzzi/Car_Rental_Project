

import 'package:car_rental_project/Resources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffController extends GetxController {
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
  final phoneController = TextEditingController();
  final positionC = TextEditingController();
  final searchController = TextEditingController();
  var selectedCountryName = "Australia".obs;
  var selectedCode = "+61".obs;
  var selectedStatus = 'Active'.obs;
  var permissions = <String>[].obs;
  var textFieldErrors = <String, String>{}.obs;
  var permissionsError = "".obs;
  var statusError = "".obs;

  final List<String> statusItems = [
    "Active",
    "Awaiting",
    "InActive",
    "Suspended"
  ];

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value
        .trim()
        .isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  void togglePermission(String val) {
    if (permissions.contains(val)) {
      permissions.remove(val);
    } else {
      permissions.add(val);
    }
    if (permissions.isNotEmpty) permissionsError.value = "";
  }

  bool validateStaffForm() {
    bool isValid = true;
    textFieldErrors.clear();
    statusError.value = "";
    permissionsError.value = "";

    final fields = {
      'First Name': firstNameC.text,
      'Last Name': lastNameC.text,
      'Email': emailC.text,
      'Phone Number': phoneController.text,
      'Position': positionC.text,
    };

    fields.forEach((key, value) {
      if (value.trim().isEmpty) {
        textFieldErrors[key] = "$key is required";
        isValid = false;
      } else if (key == 'Email' && !GetUtils.isEmail(value)) {
        textFieldErrors[key] = "Email is invalid";
        isValid = false;
      }
    });

    if (selectedStatus.value.isEmpty) {
      statusError.value = "Status is required";
      isValid = false;
    }

    if (permissions.isEmpty) {
      permissionsError.value = "Select at least one permission";
      isValid = false;
    }

    return isValid;
  }

  void submitData(BuildContext context) {
    if (validateStaffForm()) {
      String fullNumber = "${selectedCode.value} ${phoneController.text}";
      print("Final Data: ${firstNameC.text}, Phone: $fullNumber");
    } else {
      Get.snackbar(
        "Error",
        "Please check the fields",
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

   /// Edit Staff
  final firstNameCEdit = TextEditingController();
  final lastNameCEdit = TextEditingController();
  final emailCEdit = TextEditingController();
  final phoneControllerEdit = TextEditingController();
  final searchControllerEdit = TextEditingController();
  final positionCEdit = TextEditingController();
  final searchController2 = TextEditingController();
  var selectedCountryNameEdit = "Australia".obs;
  var selectedCodeEdit = "+61".obs;
  var selectedStatusEdit = "".obs;
  var permissionsEdit = <String>[].obs;
  var selectedCode2 = "+61".obs;
  var textFieldErrorsEdit = <String, String>{}.obs;
  var statusErrorEdit = "".obs;
  var permissionsErrorEdit = "".obs;

  final List<String> statusItems2 = [
    "Active",
    "Awaiting",
    "InActive",
    "Suspended"
  ];

  void togglePermissionEdit(String val) {
    if (permissionsEdit.contains(val)) {
      permissionsEdit.remove(val);
    } else {
      permissionsEdit.add(val);
    }
    if (permissionsEdit.isNotEmpty) permissionsErrorEdit.value = "";
  }

  String? validateRequiredEdit(String? value, String fieldName) {
    if (value == null || value
        .trim()
        .isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  bool validateEditStaffForm() {
    bool isValid = true;
    textFieldErrorsEdit.clear();
    statusErrorEdit.value = "";
    permissionsErrorEdit.value = "";

    final fields = {
      'First Name': firstNameCEdit.text,
      'Last Name': lastNameCEdit.text,
      'Email': emailCEdit.text,
      'Phone': phoneControllerEdit.text,
      'Position': positionCEdit.text,
    };

    fields.forEach((key, value) {
      if (value.trim().isEmpty) {
        textFieldErrorsEdit[key] = "$key is required";
        isValid = false;
      } else if (key == 'Email' && !GetUtils.isEmail(value)) {
        textFieldErrorsEdit[key] = "Email is invalid";
        isValid = false;
      }
    });

    if (selectedStatusEdit.value.isEmpty) {
      statusErrorEdit.value = "Status is required";
      isValid = false;
    }

    if (permissionsEdit.isEmpty) {
      permissionsErrorEdit.value = "Select at least one permission";
      isValid = false;
    }

    return isValid;
  }

  void submitDataEdit(BuildContext context) {
    if (validateEditStaffForm()) {
      String fullNumber = "${selectedCodeEdit.value} ${phoneControllerEdit
          .text}";
      print("Update Data: ${firstNameCEdit.text}, Phone: $fullNumber");
    }
  }
  /// Sorting
  var sortColumn = "".obs;
  var sortOrder = 0.obs;

  void toggleSort(String columnName) {
    if (sortColumn.value == columnName) {
      sortOrder.value = (sortOrder.value + 1) % 3;
      if (sortOrder.value == 0) sortColumn.value = "";
    } else {
      sortColumn.value = columnName;
      sortOrder.value = 1;
    }
  }


  @override
  void onClose() {
    firstNameC.dispose();
    lastNameC.dispose();
    emailC.dispose();
    positionC.dispose();
    firstNameCEdit.dispose();
    lastNameCEdit.dispose();
    emailCEdit.dispose();
    positionCEdit.dispose();
    super.onClose();
  }


  @override
  void onInit() {
    super.onInit();
    generateDummyData();
  }




}