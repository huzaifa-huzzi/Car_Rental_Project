import 'package:get/get.dart';

class CustomerController extends GetxController {
  var selectAge = "".obs;
  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;

  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

   /// Pagination
  // Pagination State
  final RxInt currentPage2 = 1.obs;
  final RxInt pageSize2 = 8.obs;
  final RxInt selectedView2 = 0.obs;

  RxList<Map<String, dynamic>> carList2 = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    carList2.addAll(List.generate(50, (index) => {"id": index, "name": "Customer $index"}));
  }

  int get totalPages {
    if (carList2.isEmpty) return 1;
    return (carList2.length / pageSize2.value).ceil();
  }

  List<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage2.value - 1) * pageSize2.value;
    if (start >= carList2.length) return [];
    int end = start + pageSize2.value;
    return carList2.sublist(start, end > carList2.length ? carList2.length : end);
  }

  void goToPreviousPage() {
    if (currentPage2.value > 1) currentPage2.value--;
  }

  void goToNextPage() {
    if (currentPage2.value < totalPages) currentPage2.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage2.value = page;
  }

  void setPageSize(int newSize) {
    pageSize2.value = newSize;
    currentPage2.value = 1;
  }

  /// CustomerDetail Screen
  // Popup Logic
  RxBool isOpen = false.obs;
  RxString imagePath = ''.obs;

  void open(String assetPath) {
    imagePath.value = assetPath;
    isOpen.value = true;
  }

  void close() {
    isOpen.value = false;
    imagePath.value = '';
  }
}