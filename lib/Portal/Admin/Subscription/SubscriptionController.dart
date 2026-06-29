import 'package:car_rental_project/Portal/Admin/Subscription/ReusableWidget/CustomCalendarSubscription.dart';
import 'package:car_rental_project/Resources/Colors.dart';
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

class SubscriptionController extends GetxController {

  /// Main Screen
  var showMainSubscriptionDesign = true.obs;
  var selectedTab = "All".obs;
  var openedDropdown2 = "".obs;
  var selectedCustomerValue = "Customer Name".obs;

  final searchController = TextEditingController();
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 5.obs;
  int get totalPages => 4;

  void goToPreviousPage() { if (currentPage3.value > 1) currentPage3.value--; }
  void goToNextPage() { if (currentPage3.value < totalPages) currentPage3.value++; }
  void goToPage(int page) { currentPage3.value = page; }
  var sortColumn = "".obs;
  var sortOrder = 0.obs;
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


  /// Subscription fee
  late TextEditingController monthlyFeeController;
  late TextEditingController yearlyFeeController;


  /// Add Subscription
  final companyName = TextEditingController();
  final adressController = TextEditingController();
  final phoneNumber = TextEditingController();
  final emailAddress = TextEditingController();
  final licenseNumber = TextEditingController();
  final registrationDate = TextEditingController();
  final taxNumber = TextEditingController();
  var accountStatus = "Active".obs;
  var focusedField = "".obs;
  RxList<ImageHolder> selectedImages2 = <ImageHolder>[].obs;
  var selectedPlan = "Monthly".obs;
  final totalCars = TextEditingController();
  final availableCars = TextEditingController();
  final underMaintenance = TextEditingController();
  final startDateController = TextEditingController(text: "4/03/2027");
  final endDateController = TextEditingController(text: "4/03/2027");
  var isDateDropOpen = false.obs;
  OverlayEntry? calendarOverlay;

  final LayerLink startDateLink = LayerLink();
  final LayerLink endDateLink = LayerLink();
  void setFocus(String fieldName) => focusedField.value = fieldName;
  void clearFocus() => focusedField.value = "";
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

  void removeImage2(int index) {
    selectedImages2.removeAt(index);
  }
  void toggleCalendar(BuildContext context, LayerLink link, TextEditingController targetController) {
    if (calendarOverlay != null) {
      removeCalendar();
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      double calendarWidth = screenWidth < 600 ? (screenWidth * 0.66) : 300;

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
            offset: const Offset(0, 6),
            child: Material(
              elevation: 12,
              shadowColor: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width,
                  maxHeight: 320,
                ),
                child: CustomCalendarSubscription(
                  width: width,
                  onCancel: removeCalendar,
                  onDateSelected: (date) {
                    targetController.text = "${date.day}/${date.month}/${date.year}";
                    removeCalendar();
                  },
                ),
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

  void updateDateRange(DateTime selectedDate) {
    print("Date Updated: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
  }

  @override
  void onInit() {
    super.onInit();
    monthlyFeeController = TextEditingController();
    yearlyFeeController = TextEditingController();
  }

  void updateCarSubscriptionFees() {
    Get.snackbar(
      "Success",
      "Car subscription fees updated successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.completedColor,
      colorText: Colors.white,
    );
  }


   /// Detail Screen
  Color getDetailStatusColor() {
    switch (accountStatus.value.trim().toLowerCase()) {
      case 'active':
        return  AppColors.completedColor;
      case 'suspended':
        return Colors.red;
      case 'expired':
        return AppColors.tableHeading;
      default:
        return AppColors.toolBackground;
    }
  }
  Color getDetailStatusTextColor() {
    switch (accountStatus.value.trim().toLowerCase()) {
      case 'active':
        return Colors.white;
      case 'suspended':
        return Colors.white;
      case 'expired':
        return Colors.white;
      default:
        return AppColors.blackColor;
    }
  }


  /// Invoices Detail
  var searchCarText = "".obs;
  var selectedYear = "2024".obs;
  final TextEditingController searchController2 = TextEditingController();
  int get currentYear => DateTime.now().year;

  List<String> get yearsList2 {
    return List.generate(
      (currentYear - 1950) + 1,
          (index) => (currentYear - index).toString(),
    );
  }

  List<String> get yearsList => yearsList2;


  @override
  void onClose() {
    searchController.dispose();
    searchController2.dispose();
    companyName.dispose();
    adressController.dispose();
    phoneNumber.dispose();
    emailAddress.dispose();
    licenseNumber.dispose();
    registrationDate.dispose();
    taxNumber.dispose();
    totalCars.dispose();
    availableCars.dispose();
    underMaintenance.dispose();
    startDateController.dispose();
    endDateController.dispose();
    removeCalendar();
    super.onClose();
  }
}