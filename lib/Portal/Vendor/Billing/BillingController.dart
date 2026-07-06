import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingController extends GetxController {
  var openedDropdown2 = "".obs;
  var searchCarText = "".obs;
  var isDefaultPayment = false.obs;
  var selectedTabIndex = 0.obs;

  var dropdownErrors = <String, String>{}.obs;
  var selectedMonth = "".obs;
  var selectedYear = "".obs;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final cvcController = TextEditingController();

  int get currentYear => DateTime.now().year;

  List<String> get yearsList => List.generate(
      (currentYear - 1950) + 1,
          (index) => (currentYear - index).toString()
  );

  final List<String> monthsList = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  List<String> getFilteredItems(String id) {
    String query = searchCarText.value.toLowerCase();
    if (id == "year") {
      return yearsList.where((year) => year.contains(query)).toList();
    } else if (id == "month") {
      return monthsList.where((month) => month.toLowerCase().contains(query)).toList();
    }
    return [];
  }
  void clearAllFields() {
    nameController.clear();
    numberController.clear();
    cvcController.clear();
    selectedMonth.value = "";
    selectedYear.value = "";
    isDefaultPayment.value = false;
    searchCarText.value = "";
    openedDropdown2.value = "";
  }
}