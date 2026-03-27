
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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

  @override
  void onInit() {
    super.onInit();
    baseData.assignAll([
      {"id": "INV-RSC-202603-0001","customerName": "Jhon Martin", "duration": "Mar 7, 2026 - Mar 14 2026", "car": "Mazda CX-5 (2017)", "amount": "245"},
      {"id": "INV-RSC-202603-0002", "customerName": "Ethan Miles","duration": "Mar 7, 2026 - Mar 14 2026", "car": "Mazda CX-5 (2017)", "amount": "245"},
      {"id": "INV-RSC-202603-0003", "customerName": "Adam Jhones","duration": "Mar 7, 2026 - Mar 14 2026", "car": "Mazda CX-5 (2017)", "amount": "245"},
    ]);
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

}