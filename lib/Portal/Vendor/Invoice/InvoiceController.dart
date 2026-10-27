import 'package:car_rental_project/Portal/Vendor/Invoice/ReusableWidget/CustomCalendarInvoice2.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class InvoiceController extends GetxController {
  final RxList<Map<String, dynamic>> baseInvoiceData = <Map<String, dynamic>>[].obs;
  var selectedTab = "All".obs;
  final RxInt currentPage = 1.obs;
  final RxInt pageSize = 5.obs;
  var openedDropdown = "".obs;
  var selectedCustomerValue = "Customer Name".obs;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  var selectedCountryName = "Australia".obs;
  var selectedCode = "+61".obs;
  var isLoadingCountries = false.obs;
  var selectedInvoiceType = "Manual Invoice".obs;
  bool isBillDropdownOpen = false;

  List<Country> getFilteredCountries() {
    final List<Country> allCountries = CountryService().getAll();
    if (searchController.text.isEmpty) {
      return allCountries;
    }
    return allCountries.where((country) {
      return country.name.toLowerCase().contains(searchController.text.toLowerCase()) ||
          country.countryCode.toLowerCase().contains(searchController.text.toLowerCase());
    }).toList();
  }

  final LayerLink dateFilterLink = LayerLink();
  final TextEditingController dateTextController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  var isDateDropOpen = false.obs;
  var selectedFilter = "Weekly".obs;
  var selectedDateRangeText = "".obs;
  OverlayEntry? calendarOverlay;

  var sortColumn = "".obs;
  var sortOrder = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInvoiceData();
  }

  void loadInvoiceData() {
    baseInvoiceData.assignAll([
      {
        "invNo": "ABC 1234",
        "customerName": "Ethan Miles",
        "carName": "Mazda CX-5 (2017)",
        "date": "17/10/26",
        "amount": "7565",
        "status": "Overdue",
      },
      {
        "invNo": "ABC 1234",
        "customerName": "Adam Jhones",
        "carName": "Mazda CX-5 (2017)",
        "date": "17/10/26",
        "amount": "545",
        "status": "Pending",
      },
      {
        "invNo": "ABC 1234",
        "customerName": "Jhon Martin",
        "carName": "Mazda CX-5 (2017)",
        "date": "17/10/26",
        "amount": "7565",
        "status": "Completed",
      },
      {
        "invNo": "ABC 1234",
        "customerName": "Ethan Miles",
        "carName": "Honda Civic RS Turbo(2020)",
        "date": "17/10/26",
        "amount": "245",
        "status": "Completed",
      },
    ]);
  }

  List<Map<String, dynamic>> get displayedInvoiceList {
    List<Map<String, dynamic>> filtered = baseInvoiceData;

    if (selectedTab.value != "All") {
      filtered = filtered
          .where((item) =>
      item["status"].toString().toLowerCase() ==
          selectedTab.value.toLowerCase())
          .toList();
    }

    if (searchController.text.trim().isNotEmpty) {
      String query = searchController.text.toLowerCase();
      filtered = filtered.where((item) {
        return item["customerName"].toString().toLowerCase().contains(query) ||
            item["invNo"].toString().toLowerCase().contains(query) ||
            item["carName"].toString().toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  void changeTab(String tabName) {
    selectedTab.value = tabName;
    currentPage.value = 1;
  }

  void toggleSort(String columnName) {
    if (sortColumn.value == columnName) {
      sortOrder.value = (sortOrder.value + 1) % 3;
      if (sortOrder.value == 0) sortColumn.value = "";
    } else {
      sortColumn.value = columnName;
      sortOrder.value = 1;
    }
  }

  void toggleCalendar(BuildContext context, LayerLink link, TextEditingController targetController, double width) {
    if (calendarOverlay != null) {
      removeCalendar();
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      double dynamicWidth = screenWidth < 500 ? screenWidth * 0.85 : 320;
      calendarOverlay = _createCalendarOverlay(context, link, targetController, dynamicWidth);
      Overlay.of(context).insert(calendarOverlay!);
      isDateDropOpen.value = true;
    }
  }

  void removeCalendar() {
    calendarOverlay?.remove();
    calendarOverlay = null;
    isDateDropOpen.value = false;
  }

  OverlayEntry _createCalendarOverlay(BuildContext context, LayerLink link, TextEditingController targetController, double width) {
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
              child: CustomCalendarInvoice2(
                width: overlayWidth,
                onCancel: removeCalendar,
                onDateSelected: (date) {
                  targetController.text = "${date.day}/${date.month}/${date.year}";
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

  void updateDateRange(DateTime startDate) {
    DateTime endDate = startDate.add(const Duration(days: 6));
    String startStr = "${startDate.day} ${_getMonthAbbr(startDate.month)}, ${startDate.year}";
    String endStr = "${endDate.day} ${_getMonthAbbr(endDate.month)}, ${endDate.year}";
    selectedDateRangeText.value = "$startStr\n$endStr";
  }

  String _getMonthAbbr(int month) => [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ][month - 1];

   // Invoice Add Details
  final LayerLink pickupDateLink = LayerLink();
  final LayerLink returnDateLink = LayerLink();

  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();

  void toggleSingleDateCalendar(BuildContext context, LayerLink link, TextEditingController targetController) {
    if (calendarOverlay != null) {
      removeCalendar();
    } else {
      double screenWidth = MediaQuery.of(context).size.width;
      double dynamicWidth = screenWidth < 500 ? screenWidth * 0.85 : 300;

      calendarOverlay = OverlayEntry(
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
              offset: const Offset(0, 8),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                child: CustomCalendarInvoice2(
                  width: dynamicWidth,
                  onCancel: removeCalendar,
                  onDateSelected: (date) {
                    targetController.text = "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString().substring(2)}";
                    removeCalendar();
                  },
                ),
              ),
            ),
          ],
        ),
      );

      Overlay.of(context).insert(calendarOverlay!);
      isDateDropOpen.value = true;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    dateTextController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}