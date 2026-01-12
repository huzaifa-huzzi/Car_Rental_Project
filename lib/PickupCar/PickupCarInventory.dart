import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;

class DocumentHolder {
  final Uint8List? bytes;
  final String? path;
  final String name;
  DocumentHolder({this.bytes, this.path, required this.name});
}

class ImageHolder {
  final String? path;
  final Uint8List? bytes;
  final String? name;

  ImageHolder({this.path, this.bytes, this.name});
}


class PickupCarController extends GetxController {
  var selectAge = "".obs;
  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;

  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

  /// Pagination State
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 8.obs;
  final RxInt selectedView3 = 0.obs;

  RxList<Map<String, dynamic>> carList3 = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    generateDummyData();
  }

  int get totalPages {
    if (carList3.isEmpty) return 1;
    return (carList3.length / pageSize3.value).ceil();
  }

  List<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage3.value - 1) * pageSize3.value;
    int end = start + pageSize3.value;

    if (start >= carList3.length) return [];
    return carList3.sublist(
        start, end > carList3.length ? carList3.length : end);
  }

  void goToPreviousPage() {
    if (currentPage3.value > 1) currentPage3.value--;
  }

  void goToNextPage() {
    if (currentPage3.value < totalPages) currentPage3.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage3.value = page;
  }

  void setPageSize(int newSize) {
    pageSize3.value = newSize;
    currentPage3.value = 1;
  }

  /// Popup Widget Logic
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

  /// CardList pickup Header Widget
  var isSearchCategoryOpen = false.obs;
  var selectedSearchType = "Customer Name".obs;

  // Filter Values
  var selectedMake = "Toyota".obs;
  var selectedModel = "Corolla".obs;
  var selectedYear = "2017".obs;
  var selectedStatus = "Completed".obs;
  var startDate = "12/12/25".obs;
  var endDate = "12/12/25".obs;

  void toggleSearchCategory() {
    isSearchCategoryOpen.value = !isSearchCategoryOpen.value;
    if (isSearchCategoryOpen.value) isFilterOpen.value = false;
  }

  List<String> makes = ["Toyota", "Honda", "Suzuki", "Tesla"];
  List<String> statuses = ["Completed", "Pending", "Cancelled"];

  void generateDummyData() {
    carList3.clear();

    List<String> customers = [
      "Alice Johnson",
      "Bob Smith",
      "Charlie Davis",
      "Diana Prince",
      "Ethan Hunt"
    ];
    List<String> statuses = ["Completed", "Awaiting", "Processing", "Overdue"];


    for (int i = 0; i < 25; i++) {
      carList3.add({
        "customerName": customers[i % customers.length],
        "vin": "JTNBA3HK003001234",
        "reg": "1234567890",
        "make": "Toyota",
        "model": "Corolla",
        "year": "2017",
        "rentPerWeek": "\$50",
        "rentalPeriod": "3 days",
        "pickupStart": "Jan 08, 2026",
        "pickupEnd": "Jan 15, 2026",
        "status": statuses[i % statuses.length],
      });
    }
  }

  /// Pick up Detail Screen
  RxList<PlatformFile> carImages = <PlatformFile>[].obs;
  var isPersonalUse = true.obs;
  var isManualPayment = true.obs;

  // --- Rent Time Section Controllers ---
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();

  // --- Signature Section Controllers ---
  final ownerNameController = TextEditingController(text: "Softsnip");
  final hirerNameController = TextEditingController(text: "Softsnip");

  // --- Pehle se mojood controllers (Reference ke liye) ---
  final weeklyRentController = TextEditingController();
  final rentBondAmountController = TextEditingController();
  final rentDueAmountController = TextEditingController();

  final bondAmountController = TextEditingController();
  final paidBondController = TextEditingController();
  final dueBondAmountController = TextEditingController();

  final odoController = TextEditingController();
  final fuelLevelController = TextEditingController();
  final interiorCleanlinessController = TextEditingController();
  final exteriorCleanlinessController = TextEditingController();
  final additionalCommentsController = TextEditingController();

  final dropoffNotesController = TextEditingController();

  // Observables for Dropdowns/Selection
  var dropoffLocation = "Softsnip Head Office".obs;
  var dropoffType = "Business".obs;
  var dropoffSeverity = "Minor".obs;

  @override
  void onClose() {
    // Memory leak se bachne ke liye controllers ko dispose karna zaroori hai
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    ownerNameController.dispose();
    hirerNameController.dispose();
    super.onClose();
  }

  RxList<ImageHolder> selectedImages = <ImageHolder>[].obs;
  final int maxImages = 10; // Limit for images

  Future<void> pickImage() async {
    if (selectedImages.length >= maxImages) {
      Get.snackbar("Limit Reached",
          "You can only upload a maximum of $maxImages images.");
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true, // Multiple pick allowed
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: kIsWeb,
    );

    if (result != null) {
      for (var file in result.files) {
        if (selectedImages.length < maxImages) {
          if (kIsWeb && file.bytes != null) {
            selectedImages.add(ImageHolder(bytes: file.bytes, name: file.name));
          } else if (file.path != null) {
            selectedImages.add(ImageHolder(path: file.path, name: file.name));
          }
        }
      }
      if (result.files.length + selectedImages.length > maxImages) {
        Get.snackbar("Note", "Only first 10 images were added.");
      }
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }


}

