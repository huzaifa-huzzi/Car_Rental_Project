
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/CustomCalenderPayment.dart';
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


class PaymentController extends GetxController {
  final RxList<Map<String, dynamic>> baseData = <Map<String, dynamic>>[].obs;
  var selectedTab = "Pending".obs;
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 5.obs;
  var selectedTab2 = 0.obs;
  var openedDropdown2 = "".obs;
  var selectedCustomerValue = "Customer Name".obs;

  var isDateDropOpen = false.obs;
  var isWeeklyDropOpen = false.obs;
  var selectedFilter = "Weekly".obs;
  var selectedDateRangeText = "".obs;
  var chartData = <double>[30, 45, 25, 50, 35, 40, 20].obs;
  var weeklyData = <double>[30, 45, 25, 50, 35, 40, 20].obs;
  var monthlyData = <double>[40, 35, 35, 32].obs;
  var yearlyData = <double>[35, 35, 45, 35, 35, 35, 25, 30, 32, 28, 35, 34].obs;
  List<double> get currentChartData {
    if (selectedFilter.value == "Weekly") return weeklyData;
    if (selectedFilter.value == "Monthly") return monthlyData;
    return yearlyData;
  }

  double get getMaxY {
    if (currentChartData.isEmpty) return 55;
    double maxVal = currentChartData.reduce((a, b) => a > b ? a : b);
    return maxVal + 10;
  }

  void updateDateRange(DateTime startDate) {
    if (selectedFilter.value == "Weekly") {
      DateTime endDate = startDate.add(const Duration(days: 6));
      String startStr = "${startDate.day} ${_getMonthAbbr(startDate.month)}, ${startDate.year}";
      String endStr = "${endDate.day} ${_getMonthAbbr(endDate.month)}, ${endDate.year}";
      selectedDateRangeText.value = "$startStr - $endStr";

      chartData.value = List.generate(7, (index) => (index + 2) * 10.0);
    }
    else if (selectedFilter.value == "Monthly") {
      selectedDateRangeText.value = "${_getMonthName(startDate.month)} ${startDate.year}";
      chartData.value = List.generate(4, (index) => (index + 3) * 12.0);
    }
    else if (selectedFilter.value == "Yearly") {
      selectedDateRangeText.value = "${startDate.year}";
      chartData.value = List.generate(12, (index) => (index + 1) * 8.0);
    }
  }


  String _getMonthName(int month) => ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][month - 1];
  String _getMonthAbbr(int month) => ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1];



  OverlayEntry? calendarOverlay;

  void toggleCalendar(BuildContext context, LayerLink link, TextEditingController targetController, double width) {
    if (calendarOverlay != null) {
      removeCalendar();
    } else {
      calendarOverlay = _createCalendarOverlay(context, link, targetController, width);
      Overlay.of(context).insert(calendarOverlay!);
      isDateDropOpen.value = true;
    }
  }

  void removeCalendar() {
    calendarOverlay?.remove();
    calendarOverlay = null;
    isDateDropOpen.value = false;
  }

  OverlayEntry _createCalendarOverlay(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      double width,
      ) {
    final screenSize = MediaQuery.of(context).size;
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    double overlayWidth = screenSize.width < 500 ? 260 : 280;
    double dx = 0;
    if (position.dx + overlayWidth > screenSize.width) {
      dx = screenSize.width - (position.dx + overlayWidth) - 10;
    }

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeCalendar,
              child: Container(color: Colors.transparent),
            ),
          ),

          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(dx, 8),

            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: CustomCalendarPayment(
                width: overlayWidth,
                onCancel: removeCalendar,
                onDateSelected: (date) {
                  targetController.text =
                  "${date.day}/${date.month}/${date.year}";
                  updateDateRange(date);
                  removeCalendar();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    baseData.assignAll([
      {"id": "INV-RSC-202603-0001","customerName": "Jhon Martin", "duration": "Mar 7, 2026 - Mar 14 2026", "car": "Mazda CX-5 (2017)", "amount": "245"},
      {"id": "INV-RSC-202603-0002", "customerName": "Ethan Miles","duration": "Mar 7, 2026 - Mar 14 2026", "car": "Mazda CX-5 (2017)", "amount": "245"},
      {"id": "INV-RSC-202603-0003", "customerName": "Adam Jhones","duration": "Mar 7, 2026 - Mar 14 2026", "car": "Mazda CX-5 (2017)", "amount": "245"},
    ]);

    loadOtherPayments();
    loadOtherPaymentsinvoices();
    reasonFocusNode.addListener(() {
      isReasonFocused.value = reasonFocusNode.hasFocus;
    });
  }
  List<Map<String, dynamic>> get displayedCarList {
    return baseData.map((item) {
      var newItem = Map<String, dynamic>.from(item);
      newItem['status'] = selectedTab.value;
      return newItem;
    }).toList();
  }

  void changeTab(String tabName) {
    selectedTab.value = tabName;
    currentPage3.value = 1;
  }
  int get totalPages => 1;

  void goToPreviousPage() {}
  void goToNextPage() {}
  void goToPage(int page) {}
  void setPageSize(int newSize) {
    pageSize3.value = newSize;
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

  /// Invoices Detail screen
  var isImageHovered = false.obs;
  void setHover(bool value) => isImageHovered.value = value;
  final FocusNode reasonFocusNode = FocusNode();
  var isReasonFocused = false.obs;

  var selectedImage = Rxn<ImageHolder>();

  Future<void> pickPaymentReceipt() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null) {
        selectedImage.value = ImageHolder(
          path: kIsWeb ? null : result.files.single.path,
          bytes: result.files.single.bytes,
          name: result.files.single.name,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Could not pick file: $e");
    }
  }

  void clearSelection() {
    selectedImage.value = null;
  }


  var otherPaymentsListinvoices = <Map<String, dynamic>>[].obs;



  void loadOtherPaymentsinvoices() {
    otherPaymentsListinvoices.assignAll([
      {
        "id": "INV-RSC-202603-0001",
        "customerName": "Adam Jhones",
        "duration": "Mar 7, 2026 - Mar 14, 2026",
        "car": "Mazada CX-5 (2017)",
        "amount": "545",
        "status": "Pending"
      },
      {
        "id": "INV-RSC-202603-0002",
        "customerName": "Adam Jhones",
        "duration": "Mar 7, 2026 - Mar 14, 2026",
        "car": "Mazada CX-5 (2017)",
        "amount": "7565",
        "status": "Pending"
      },
    ]);
  }

  var sortColumn3 = "".obs;
  var sortOrder3 = 0.obs;

  void toggleSort3(String columnName) {
    if (sortColumn3.value == columnName) {
      sortOrder3.value = (sortOrder3.value + 1) % 3;
      if (sortOrder3.value == 0) sortColumn3.value = "";
    } else {
      sortColumn3.value = columnName;
      sortOrder3.value = 1;
    }
  }

  /// Add Payment
  final invoiceIdController = TextEditingController();
  final customerNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final paymentAmountController = TextEditingController();
  final dueDateController = TextEditingController();
  final carNameController = TextEditingController();
  final registrationController = TextEditingController();
  var selectedCarType = 'Sedan'.obs;
  var selectedTransmission = 'Automatic'.obs;
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final durationController = TextEditingController();

  @override
  void onClose() {
    invoiceIdController.dispose();
    customerNameController.dispose();
    phoneNumberController.dispose();
    paymentAmountController.dispose();
    dueDateController.dispose();
    carNameController.dispose();
    registrationController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    durationController.dispose();
    super.onClose();
  }




  var selectedImage2 = Rxn<ImageHolder>();
  var isImageHovered2 = false.obs;
  void setHover2(bool value) => isImageHovered2.value = value;
  Future<void> pickPaymentReceipt2() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null) {
        selectedImage2.value = ImageHolder(
          path: kIsWeb ? null : result.files.single.path,
          bytes: result.files.single.bytes,
          name: result.files.single.name,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Could not pick file: $e");
    }
  }

  void clearSelection2() {
    selectedImage2.value = null;
  }

  var otherPaymentsList = <Map<String, dynamic>>[].obs;



  void loadOtherPayments() {
    otherPaymentsList.assignAll([
      {
        "id": "INV-RSC-202603-0001",
        "customerName": "Adam Jhones",
        "duration": "Mar 7, 2026 - Mar 14, 2026",
        "car": "Mazada CX-5 (2017)",
        "amount": "545",
        "status": "Pending"
      },
      {
        "id": "INV-RSC-202603-0002",
        "customerName": "Adam Jhones",
        "duration": "Mar 7, 2026 - Mar 14, 2026",
        "car": "Mazada CX-5 (2017)",
        "amount": "7565",
        "status": "Pending"
      },
    ]);
  }

  var sortColumn2 = "".obs;
  var sortOrder2 = 0.obs;

  void toggleSort2(String columnName) {
    if (sortColumn2.value == columnName) {
      sortOrder2.value = (sortOrder2.value + 1) % 3;
      if (sortOrder2.value == 0) sortColumn2.value = "";
    } else {
      sortColumn2.value = columnName;
      sortOrder2.value = 1;
    }
  }




}