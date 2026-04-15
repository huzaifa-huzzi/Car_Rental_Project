
import 'dart:typed_data';
import 'package:car_rental_project/Portal/Admin/Comapnies/ReusableWidget/CustomCalendarCompany.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ImageHolder {
  final String? path;
  final Uint8List? bytes;
  final String? name;

  ImageHolder({this.path, this.bytes, this.name});
}

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
      "status": "Pending",
      "plan": "Weekly",
      "planStatus": "Subscribed",
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


  /// Add Companies
  var focusedField = "".obs;

  final totalCars = TextEditingController();
  final availableCars = TextEditingController();
  final underMaintenance = TextEditingController();
  final totalStaff = TextEditingController();

  final companyName = TextEditingController();
  final adressController = TextEditingController();
  final phoneNumber = TextEditingController();
  final emailAddress = TextEditingController();
  final licenseNumber = TextEditingController();
  final registrationDate = TextEditingController();
  final taxNumber = TextEditingController();
  var accountStatus = "Active".obs;

  void setFocus(String fieldName) => focusedField.value = fieldName;
  void clearFocus() => focusedField.value = "";

  @override
  void onClose() {
    totalCars.dispose(); availableCars.dispose(); underMaintenance.dispose();
    totalStaff.dispose(); companyName.dispose(); phoneNumber.dispose();
    emailAddress.dispose(); licenseNumber.dispose(); registrationDate.dispose();
    taxNumber.dispose();
    super.onClose();
  }


  Future<void> pickImage2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: kIsWeb ? true : false,
      withReadStream: kIsWeb ? false : true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (kIsWeb && file.bytes != null) {
          selectedImages2.add(ImageHolder(bytes: file.bytes, name: file.name));
        } else if (!kIsWeb && file.path != null) {
          selectedImages2.add(ImageHolder(path: file.path, name: file.name));
        }
      }
    }
  }

  final facebookLink = TextEditingController();
  final twitterLink = TextEditingController();
  final instagramLink = TextEditingController();
  final linkedinLink = TextEditingController();
  final youtubeLink = TextEditingController();

  var selectedPlan = "Monthly".obs; //
  var selectedPlanStatus = "Subscribed".obs; //

  final startDateController = TextEditingController(text: "4/03/2027");
  final endDateController = TextEditingController(text: "4/03/2027");
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
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeCalendar,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
          ),

          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: const Offset(0, 8),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: CustomCalendarCompany(
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

  final LayerLink startDateLink = LayerLink();
  final LayerLink endDateLink = LayerLink();
  void updateDateRange(DateTime selectedDate) {
    print("Date Updated: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
  }



  RxList<ImageHolder> selectedImages2 = <ImageHolder>[].obs;

  void removeImage2(int index) {
    selectedImages2.removeAt(index);
  }


  /// Details Screen

}