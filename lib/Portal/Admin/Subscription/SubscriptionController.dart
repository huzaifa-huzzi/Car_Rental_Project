import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  // --- View Toggle State ---
  // true = Add Company View (Show Stats Cards, Filters, Table)
  // false = Change Subscription Fee View (Hide existing design)
  var showMainSubscriptionDesign = true.obs;

  // --- Top Filters & Tab State ---
  var selectedTab = "All".obs;
  var openedDropdown2 = "".obs;
  var selectedCustomerValue = "Customer Name".obs;

  final searchController = TextEditingController();

  // --- Your Pagination State ---
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 5.obs;
  int get totalPages => 4;

  void goToPreviousPage() { if (currentPage3.value > 1) currentPage3.value--; }
  void goToNextPage() { if (currentPage3.value < totalPages) currentPage3.value++; }
  void goToPage(int page) { currentPage3.value = page; }

  // --- Sorting State ---
  var sortColumn = "".obs;
  var sortOrder = 0.obs; // 0 = none, 1 = asc, 2 = desc

  // --- Mock Data ---
  var allSubscriptions = <Map<String, dynamic>>[
    {"companyName": "Plus Drivers", "type": "Monthly", "cars": 40, "charges": "\$1,345.00", "nextBilling": "9/03/26", "status": "Active"},
    {"companyName": "Outback Wheels", "type": "Monthly", "cars": 100, "charges": "\$1,345.00", "nextBilling": "9/03/26", "status": "Active"},
    {"companyName": "Blue Coast", "type": "Yearly", "cars": 410, "charges": "\$12,345.00", "nextBilling": "9/03/26", "status": "Suspended"},
    {"companyName": "TrueMate", "type": "Monthly", "cars": 10, "charges": "\$1,345.00", "nextBilling": "9/03/26", "status": "Expired"},
    {"companyName": "Horizon Auto", "type": "Yearly", "cars": 45, "charges": "\$12,345.00", "nextBilling": "9/03/26", "status": "Active"},
  ].obs;

  List<Map<String, dynamic>> get filteredSubscriptions {
    List<Map<String, dynamic>> list = allSubscriptions;
    if (selectedTab.value != "All") {
      list = list.where((item) => item["status"].toString().toLowerCase() == selectedTab.value.toLowerCase()).toList();
    }
    if (searchController.text.isNotEmpty) {
      list = list.where((item) => item["companyName"].toString().toLowerCase().contains(searchController.text.toLowerCase())).toList();
    }
    return list;
  }

  void changeTab(String tabName) => selectedTab.value = tabName;

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
    searchController.dispose();
    super.onClose();
  }
}