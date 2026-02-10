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
  final double dx;
  final double dy;
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
  final ScrollController customerScrollController = ScrollController();
  final ScrollController carScrollController = ScrollController();

  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

  /// Pagination State
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 10.obs;
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
  var selectYear = "2017".obs;
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




  RxList<ImageHolder> vehicleInspectionImages = <ImageHolder>[].obs;
  final int maxInspectionImages = 10;

  Future<void> uploadInspectionPhotos() async {
    if (vehicleInspectionImages.length >= maxInspectionImages) {
      Get.snackbar("Limit Reached", "Maximum $maxInspectionImages photos allowed.");
      return;
    }

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        withData: true,
      );

      if (result != null) {
        for (var file in result.files) {
          if (vehicleInspectionImages.length < maxInspectionImages) {
            vehicleInspectionImages.add(ImageHolder(
                bytes: file.bytes,
                path: kIsWeb ? null : file.path,
                name: file.name
            ));
          }
        }
      }
    } catch (e) {
      debugPrint("File Picker Error: $e");
    }
  }

  void deleteInspectionPhoto(int index) {
    if (index >= 0 && index < vehicleInspectionImages.length) {
      vehicleInspectionImages.removeAt(index);
    }
  }
  /// Add Pickup Car
  var isCustomerDropdownOpen = false.obs;
  var isCarDropdownOpen = false.obs;
  var isDamageInspectionOpen = false.obs;

  var isCustomerDropdownOpen2 = false.obs;

  // Rent Purpose
  var selectedRentPurpose = "Personal Use".obs;

  final weeklyRentController2 = TextEditingController();
  final dailyRentController2 = TextEditingController();
  final bondAmountController2 = TextEditingController();
  final paidBondController2 = TextEditingController();
  final leftBondController2 = TextEditingController();
  final customerSearchController = TextEditingController();
  final carSearchController = TextEditingController();
  final additionalAddCommentsController = TextEditingController();

  final odoAddController = TextEditingController();
  final fuelLevelAddController = TextEditingController();
  final interiorCleanlinessAddController = TextEditingController();
  final exteriorCleanlinessAddController = TextEditingController();
  final additionalCommentsAddController = TextEditingController();

  final startDateAddController = TextEditingController();
  final startTimeAddController = TextEditingController();
  final endDateAddController = TextEditingController();
  final endTimeAddController = TextEditingController();



  void toggleCustomerDropdown() => isCustomerDropdownOpen.value = !isCustomerDropdownOpen.value;
  void toggleCarDropdown() => isCarDropdownOpen.value = !isCarDropdownOpen.value;


  final Rxn<Map<String, dynamic>> selectedCustomer = Rxn<Map<String, dynamic>>();
  final Rxn<Map<String, dynamic>> selectedCar = Rxn<Map<String, dynamic>>();

  void clearCustomer() => selectedCustomer.value = null;
  void clearCar() => selectedCar.value = null;

  var selectedDamageType2 = 1.obs;
  var damagePoints2 = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes2 = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];


  RxList<ImageHolder> AddpickupCarImages = <ImageHolder>[].obs;
  final int maxPickupAddImages = 10;

  final startDateController2 = TextEditingController();
  final startTimeController2 = TextEditingController();
  final endDateController2 = TextEditingController();
  final endTimeController2 = TextEditingController();

  Future<void> pickImage2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (AddpickupCarImages.length < maxPickupAddImages) {
          if (kIsWeb) {
            if (file.bytes != null) {
              AddpickupCarImages.add(ImageHolder(bytes: file.bytes, name: file.name));
            }
          } else {
            if (file.path != null) {
              AddpickupCarImages.add(ImageHolder(path: file.path, name: file.name, bytes: file.bytes));
            }
          }
        }
      }
      AddpickupCarImages.refresh();
    }
  }

  void removeImage2(int index) {
    if (index >= 0 && index < AddpickupCarImages.length) {
      AddpickupCarImages.removeAt(index);
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

  /// StepTwo Widget
  // This will take values from the stepone Widget (  from Add Pickup Car)
   // Note : Backend Developer Will set it accordign to requirments  But I have to show the Dummy Data so, Iam adding this code
  final weeklyRentControllerStepTwo = TextEditingController();
  final rentBondAmountControllerStepTwo  = TextEditingController();
  final rentDueAmountControllerStepTwo  = TextEditingController();

  final bondAmountControllerStepTwo  = TextEditingController();
  final paidBondControllerStepTwo  = TextEditingController();
  final dueBondAmountControllerStepTwo  = TextEditingController();

  final odoControllerStepTwo  = TextEditingController();
  final fuelLevelControllerStepTwo  = TextEditingController();
  final interiorCleanlinessControllerStepTwo  = TextEditingController();
  final exteriorCleanlinessControllerStepTwo  = TextEditingController();
  final additionalCommentsControllerStepTwo  = TextEditingController();


  var isPersonalUseStepTwo  = true.obs;
  var isManualPaymentStepTwo  = true.obs;
  final startDateControllerStepTwo  = TextEditingController();
  final startTimeControllerStepTwo  = TextEditingController();
  final endDateControllerStepTwo  = TextEditingController();
  final endTimeControllerStepTwo  = TextEditingController();

  /// EditPickup
  var isCustomerDropdownEditOpen = false.obs;
  var isCarDropdownEditOpen = false.obs;
  var isDamageInspectionEditOpen = false.obs;

  var isCustomerDropdownEditOpen2 = false.obs;

  // Rent Purpose
  var isPersonalEditUse = true.obs;
  var isManualEditPayment = true.obs;

  final weeklyRentEditController2 = TextEditingController();
  final dailyRentEditController2 = TextEditingController();
  final bondAmountEditController2 = TextEditingController();
  final paidBondEditController2 = TextEditingController();
  final leftBondEditController2 = TextEditingController();
  final customerSearchEditController = TextEditingController();
  final carSearchEditController = TextEditingController();
  final ownerNameEditController = TextEditingController(text: "Softsnip");
  final hirerNameEditController = TextEditingController(text: "Softsnip");
  final additionalCommentsEditController = TextEditingController();


  final odoEditController = TextEditingController();
  final fuelLevelEditController = TextEditingController();
  final interiorCleanlinessEditController = TextEditingController();
  final exteriorCleanlinessEditController = TextEditingController();

  void toggleCustomerEditDropdown() => isCustomerDropdownEditOpen.value = !isCustomerDropdownEditOpen.value;
  void toggleCarEditDropdown() => isCarDropdownEditOpen.value = !isCarDropdownEditOpen.value;


  final Rxn<Map<String, dynamic>> selectedEditCustomer = Rxn<Map<String, dynamic>>();
  final Rxn<Map<String, dynamic>> selectedEditCar = Rxn<Map<String, dynamic>>();

  void clearEditCustomer() => selectedCustomer.value = null;
  void clearEditCar() => selectedCar.value = null;

  var selectedDamageEditType = 1.obs;
  var damageEditPoints = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageEditPoint = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];


  RxList<ImageHolder> pickupCarImages3 = <ImageHolder>[].obs;
  final int maxPickupImages2 = 10;

  final startDateEditController2 = TextEditingController();
  final startTimeEditController2 = TextEditingController();
  final endDateEditController2 = TextEditingController();
  final endTimeEditController2 = TextEditingController();

  Future<void> pickImage3() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (pickupCarImages3.length < maxPickupImages2) {
          if (kIsWeb) {
            if (file.bytes != null) {
              pickupCarImages3.add(ImageHolder(bytes: file.bytes, name: file.name));
            }
          } else {
            if (file.path != null) {
              pickupCarImages3.add(ImageHolder(path: file.path, name: file.name, bytes: file.bytes));
            }
          }
        }
      }
      pickupCarImages3.refresh();
    }
  }

  void removeImage3(int index) {
    if (index >= 0 && index < pickupCarImages3.length) {
      pickupCarImages3.removeAt(index);
    }
  }

  void selectEditCustomer(dynamic customer) {
    selectedEditCustomer.value = customer;
    isCustomerDropdownEditOpen.value = false;
  }

  void selectEditCar(dynamic car) {
    selectedCar.value = car;
    isCarDropdownEditOpen.value = false;
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
    startDateEditController2.dispose();
    startTimeEditController2.dispose();
    endDateEditController2.dispose();
    endTimeEditController2.dispose();
    additionalAddCommentsController.dispose();
    startDateAddController.dispose();
    startTimeAddController.dispose();
    endDateAddController.dispose();
    endTimeAddController.dispose();

    //  Rent & Bond Controllers
    weeklyRentController.dispose();
    rentBondAmountController.dispose();
    rentDueAmountController.dispose();
    bondAmountController.dispose();
    paidBondController.dispose();
    dueBondAmountController.dispose();
    weeklyRentEditController2.dispose();
    dailyRentEditController2.dispose();
    bondAmountEditController2.dispose();
    paidBondEditController2.dispose();
    leftBondEditController2.dispose();
    customerSearchEditController.dispose();

    // Inspection & Comments Controllers
    odoController.dispose();
    fuelLevelController.dispose();
    interiorCleanlinessController.dispose();
    exteriorCleanlinessController.dispose();
    additionalCommentsController.dispose();
    odoAddController.dispose();
    fuelLevelAddController.dispose();
    interiorCleanlinessAddController.dispose();
    exteriorCleanlinessAddController.dispose();
    additionalCommentsAddController.dispose();
    odoEditController.dispose();
    fuelLevelEditController.dispose();
    interiorCleanlinessEditController.dispose();
    exteriorCleanlinessEditController.dispose();
    odoEditController.dispose();
    fuelLevelEditController.dispose();
    interiorCleanlinessEditController.dispose();
    exteriorCleanlinessEditController.dispose();

    //  Add Pickup Car Controllers
    weeklyRentController2.dispose();
    dailyRentController2.dispose();
    bondAmountController2.dispose();
    paidBondController2.dispose();
    leftBondController2.dispose();

    //  Search Controllers
    customerSearchController.dispose();
    carSearchController.dispose();
    customerScrollController.dispose();
    carScrollController.dispose();

    super.onClose();
  }

}
