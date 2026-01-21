import 'package:car_rental_project/Resources/Colors.dart';
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
class DamagePoint {
  final double dx; // 0.0 to 1.0 (Percentage of width)
  final double dy; // 0.0 to 1.0 (Percentage of height)
  final int typeId;
  final Color color;

  DamagePoint({required this.dx, required this.dy, required this.typeId, required this.color});
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
  var customerName = "Alice".obs;
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
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final ownerNameController = TextEditingController(text: "Softsnip");
  final hirerNameController = TextEditingController(text: "Softsnip");
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


  var selectedDamageType = 1.obs;
  var damagePoints = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];

  RxList<ImageHolder> selectedImages = <ImageHolder>[].obs;
  final int maxImages = 10;

  Future<void> pickImage() async {
    if (selectedImages.length >= maxImages) {
      Get.snackbar("Limit Reached",
          "You can only upload a maximum of $maxImages images.");
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
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

  /// Add Pickup Car
  var isCustomerDropdownOpen = false.obs;
  var isCarDropdownOpen = false.obs;
  var isDamageInspectionOpen = false.obs;

  var isCustomerDropdownOpen2 = false.obs;

  // Rent Purpose
  var rentPurpose = "Personal Use".obs; // Default value

  // Weekly Rent Controllers
  final weeklyRentController2 = TextEditingController();
  final dailyRentController2 = TextEditingController();

  // Bond Payment Controllers
  final bondAmountController2 = TextEditingController();
  final paidBondController2 = TextEditingController();
  final leftBondController2 = TextEditingController();

  // Selected Data (Null matlab abhi select nahi hua)
  var selectedCustomer = Rxn<dynamic>();
  var selectedCar = Rxn<dynamic>();

  // Search Controllers
  final customerSearchController = TextEditingController();
  final carSearchController = TextEditingController();

  void toggleCustomerDropdown() => isCustomerDropdownOpen.value = !isCustomerDropdownOpen.value;
  void toggleCarDropdown() => isCarDropdownOpen.value = !isCarDropdownOpen.value;

  var selectedDamageType2 = 1.obs;
  var damagePoints2 = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes2 = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];

  // Controller Variables for Step 2/3
  RxList<ImageHolder> pickupCarImages = <ImageHolder>[].obs;
  final int maxPickupImages = 10;

// Agreement Time Controllers
  final startDateController2 = TextEditingController();
  final startTimeController2 = TextEditingController();
  final endDateController2 = TextEditingController();
  final endTimeController2 = TextEditingController();

  Future<void> pickImage2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: true, // Web aur Mobile dono ke liye bytes le aayega
    );

    if (result != null) {
      for (var file in result.files) {
        if (pickupCarImages.length < maxPickupImages) {
          if (kIsWeb) {
            if (file.bytes != null) {
              pickupCarImages.add(ImageHolder(bytes: file.bytes, name: file.name));
            }
          } else {
            if (file.path != null) {
              pickupCarImages.add(ImageHolder(path: file.path, name: file.name, bytes: file.bytes));
            }
          }
        }
      }
      // YE LINE ZAROORI HAI: Ye GetX ko batati hai ke list update ho gayi hai
      pickupCarImages.refresh();
    }
  }

  void removeImage2(int index) {
    if (index >= 0 && index < pickupCarImages.length) {
      pickupCarImages.removeAt(index);
    }
  }

  void selectCustomer(dynamic customer) {
    selectedCustomer.value = customer;
    isCustomerDropdownOpen.value = false;
  }

  void selectCar(dynamic car) {
    selectedCar.value = car;
    isCarDropdownOpen.value = false;
  }


  @override
  void onClose() {
    // 1. Pickup Detail Screen Controllers
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    ownerNameController.dispose();
    hirerNameController.dispose();

    startDateController2.dispose();
    startTimeController2.dispose();
    endDateController2.dispose();
    endTimeController2.dispose();

    // 2. Rent & Bond Controllers (Set 1)
    weeklyRentController.dispose();
    rentBondAmountController.dispose();
    rentDueAmountController.dispose();
    bondAmountController.dispose();
    paidBondController.dispose();
    dueBondAmountController.dispose();

    // 3. Inspection & Comments Controllers
    odoController.dispose();
    fuelLevelController.dispose();
    interiorCleanlinessController.dispose();
    exteriorCleanlinessController.dispose();
    additionalCommentsController.dispose();

    // 4. Add Pickup Car Controllers (Set 2 / Suffix 2)
    weeklyRentController2.dispose();
    dailyRentController2.dispose();
    bondAmountController2.dispose();
    paidBondController2.dispose();
    leftBondController2.dispose();

    // 5. Search Controllers
    customerSearchController.dispose();
    carSearchController.dispose();

    super.onClose();
  }

}

