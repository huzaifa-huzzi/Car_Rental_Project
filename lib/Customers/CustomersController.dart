

import 'package:get/get.dart';

class CustomerController extends  GetxController {
   /// TableView Screen
  var selectAge = "".obs;

  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;
  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

  /// Reusable Widget Controller
  // pagination  Widget
  final RxInt currentPage = 1.obs;

  // Make pageSize reactive
  final RxInt pageSize = 8.obs;

  RxList<Map<String, dynamic>> carList = <Map<String, dynamic>>[].obs;

  int get totalPages => (carList.length / pageSize.value).ceil();

  RxList<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage.value - 1) * pageSize.value;
    int end = start + pageSize.value;
    if (end > carList.length) end = carList.length;

    if (carList.isEmpty) return <Map<String, dynamic>>[].obs;

    return carList.sublist(start, end).obs;
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void setPageSize(int newSize) {
    pageSize.value = newSize;
    currentPage.value = 1;
  }






}