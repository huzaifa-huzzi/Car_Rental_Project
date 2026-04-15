
import 'package:get/get.dart';

class CompaniesAdminController extends GetxController {

  var selectedTab = "Pending".obs;
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 5.obs;
  var selectedTab2 = 0.obs;
  var openedDropdown2 = "".obs;
  var selectedCustomerValue = "Customer Name".obs;
  final RxList<Map<String, dynamic>> baseData = <Map<String, dynamic>>[].obs;
  var totalCount = 128.obs;
  var verifiedCount = 104.obs;
  var notVerifiedCount = 24.obs;

  int get totalPages => 1;

  void goToPreviousPage() {}
  void goToNextPage() {}
  void goToPage(int page) {}
  void setPageSize(int newSize) {
    pageSize3.value = newSize;
  }


  var selectedCategory = "Email Status".obs;
  var selectedSubFilter = "All".obs;
  var allCompanies = <Map<String, dynamic>>[
    {
      "companyName": "Plus Drivers",
      "ownerName": "Adam Jhone",
      "email": "aussie@gmail.com",
      "emailStatus": "Not Verified",
      "status": "Active",
      "plan": "Monthly",
      "planStatus": "Demo",
      "joiningDate": "7th April, 2026",
      "activeCars": 78
    },
    {
      "companyName": "Outback",
      "ownerName": "Adam Jhone",
      "email": "aussie@gmail.com",
      "emailStatus": "Verified",
      "status": "Pending", // Account Status filter check karega
      "plan": "Weekly",
      "planStatus": "Subscribed", // Plan Status filter check karega
      "joiningDate": "7th April, 2026",
      "activeCars": 78
    },
    {
      "companyName": "Horizon",
      "ownerName": "Adam Jhone",
      "email": "aussie@gmail.com",
      "emailStatus": "Verified",
      "status": "Suspended",
      "plan": "Weekly",
      "planStatus": "Overdue",
      "joiningDate": "7th April, 2026",
      "activeCars": 78
    },
    {
      "companyName": "Blue Coast",
      "ownerName": "Adam Jhone",
      "email": "aussie@gmail.com",
      "emailStatus": "Verified",
      "status": "Inactive",
      "plan": "Weekly",
      "planStatus": "Cancelled",
      "joiningDate": "7th April, 2026",
      "activeCars": 78
    },
  ].obs;

  Map<String, List<Map<String, dynamic>>> get dynamicTabs => {
    "Email Status": [
      {"name": "All", "count": 128},
      {"name": "Verified", "count": 104},
      {"name": "Not Verified", "count": 24},
    ],
    "Account Status": [
      {"name": "All", "count": 128},
      {"name": "Active", "count": 14},
      {"name": "Pending", "count": 92},
      {"name": "Suspended", "count": 14},
      {"name": "Inactive", "count": 8},
    ],
    "Plan Status": [
      {"name": "All", "count": 128},
      {"name": "Demo", "count": 104},
      {"name": "Subscribed", "count": 24},
      {"name": "Overdue", "count": 24},
      {"name": "Cancelled", "count": 24},
    ],
  };

  List<Map<String, dynamic>> get filteredCompanies {
    String dataKey = {
      "Email Status": "emailStatus",
      "Account Status": "status",
      "Plan Status": "planStatus",
    }[selectedCategory.value] ?? "emailStatus";

    if (selectedSubFilter.value == "All") {
      return allCompanies;
    }

    // Yahan hum trim aur lowercase kar rahe hain taake match pakka ho
    return allCompanies.where((item) {
      String itemValue = item[dataKey]?.toString().trim().toLowerCase() ?? "";
      String filterValue = selectedSubFilter.value.trim().toLowerCase();
      return itemValue == filterValue;
    }).toList();
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
    selectedSubFilter.value = "All";
  }

  void changeTab(String tabName) {
    selectedSubFilter.value = tabName;
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

}