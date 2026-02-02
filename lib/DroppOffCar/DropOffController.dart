import 'package:car_rental_project/Resources/Colors.dart' show AppColors;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;

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


class DropOffController extends GetxController{
  var isSearchCategoryOpen = false.obs;
  var selectedSearchType = "Customer Name".obs;

       /// Pagination Bar
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 10.obs;
  final RxInt selectedView3 = 0.obs;

  RxList<Map<String, dynamic>> carList3 = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    generateDummyData();
    odoControllerStepTwo.text = "12457678";
    fuelLevelControllerStepTwo.text = "Full (100%)";
    exteriorCleanlinessControllerStepTwo.text = "Excellent";
    interiorCleanlinessControllerStepTwo.text = "Excellent";

    bondAmountControllerStepTwo.text = "2600 \$";
    paidBondControllerStepTwo.text = "600 \$";
    dueBondAmountControllerStepTwo.text = "2000 \$";

    odoControllerStepTwoAdd.text = "12457678";
    fuelLevelControllerStepTwoAdd.text = "Full (100%)";
    exteriorCleanlinessControllerStepTwoAdd.text = "Excellent";
    interiorCleanlinessControllerStepTwoAdd.text = "Excellent";

    bondAmountControllerStepTwoAdd.text = "2600 \$";
    paidBondControllerStepTwoAdd.text = "600 \$";
    dueBondAmountControllerStepTwoAdd.text = "2000 \$";
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

  /// Table View Screen Data
  var hoveredRowIndex = (-1).obs;

  void generateDummyData() {
    carList3.clear();
    for (int i = 0; i < 25; i++) {
      carList3.add({
        "customerName": "Jack Morrison",
        "customerEmail": "jackMorrison@rhyta.com",
        "vin": "JTNBA3HK003001234",
        "reg": "1234567890",
        "carRent": "Toyota Corolla (2017)",
        "damage": i % 4 == 0,
        "dropoffDate": "Aug 2, 2026",
        "status": "Completed",
      });
    }
  }
  /// Detail View Screen
  var isDamageInspectionOpen = false.obs;
  final weeklyRentControllerStepTwo = TextEditingController();
  final rentBondAmountControllerStepTwo  = TextEditingController();
  final rentDueAmountControllerStepTwo  = TextEditingController();


  final bondAmountControllerStepTwo  = TextEditingController();
  final paidBondControllerStepTwo  = TextEditingController();
  final dueBondAmountControllerStepTwo  = TextEditingController();
  final dueBondReturnedControllerStepTwo  = TextEditingController();

  final odoControllerStepTwo  = TextEditingController();
  final fuelLevelControllerStepTwo  = TextEditingController();
  final interiorCleanlinessControllerStepTwo  = TextEditingController();
  final exteriorCleanlinessControllerStepTwo  = TextEditingController();
  final additionalCommentsControllerStepTwo  = TextEditingController();
  final additionalCommentsControllerDropOff  = TextEditingController();
  final odoControllerDropOff  = TextEditingController();
  final fuelLevelControllerDropOff  = TextEditingController();
  final interiorCleanlinessControllerDropOff  = TextEditingController();
  final exteriorCleanlinessControllerDropOff  = TextEditingController();


  var isPersonalUseStepTwo  = true.obs;
  var isManualPaymentStepTwo  = true.obs;
  final startDateControllerStepTwo  = TextEditingController();
  final startTimeControllerStepTwo  = TextEditingController();
  final endDateControllerStepTwo  = TextEditingController();
  final endTimeControllerStepTwo  = TextEditingController();
  final ownerNameController = TextEditingController(text: "Softsnip");
  final hirerNameController = TextEditingController(text: "Softsnip");

  var selectedDamageType2 = 1.obs;
  var damagePoints2 = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes2 = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];


  /// Add Pickup Car
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = "".obs;
  var isDamageInspectionOpen2 = false.obs;
  final RxString selectedSearchType2 = "Customer Name".obs;
  final RxInt resultCount = 3.obs;
  final RxBool isLoading = false.obs;
  final ScrollController horizontalScrollController = ScrollController();

  void onSearchChanged(String val) {
    searchQuery.value = val;
    if (val.isNotEmpty) {
      fetchResults();
    }
  }
  Future<void> fetchResults() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    resultCount.value = 3;
    isLoading.value = false;
  }

  var isDamageInspectionOpenAdd = false.obs;
  final weeklyRentControllerStepTwoAdd = TextEditingController();
  final rentBondAmountControllerStepTwoAdd  = TextEditingController();
  final rentDueAmountControllerStepTwoAdd  = TextEditingController();


  final bondAmountControllerStepTwoAdd  = TextEditingController();
  final paidBondControllerStepTwoAdd  = TextEditingController();
  final dueBondAmountControllerStepTwoAdd  = TextEditingController();
  final dueBondReturnedControllerStepTwoAdd  = TextEditingController();

  final odoControllerStepTwoAdd  = TextEditingController();
  final fuelLevelControllerStepTwoAdd  = TextEditingController();
  final interiorCleanlinessControllerStepTwoAdd  = TextEditingController();
  final exteriorCleanlinessControllerStepTwoAdd  = TextEditingController();
  final additionalCommentsControllerStepTwoAdd  = TextEditingController();
  final additionalCommentsControllerDropOffAdd  = TextEditingController();
  final odoControllerDropOffAdd  = TextEditingController();
  final fuelLevelControllerDropOffAdd  = TextEditingController();
  final interiorCleanlinessControllerDropOffAdd  = TextEditingController();
  final exteriorCleanlinessControllerDropOffAdd  = TextEditingController();


  var isPersonalUseStepTwoAdd  = true.obs;
  var isManualPaymentStepTwoAdd  = true.obs;
  final startDateControllerStepTwoAdd  = TextEditingController();
  final startTimeControllerStepTwoAdd  = TextEditingController();
  final endDateControllerStepTwoAdd  = TextEditingController();
  final endTimeControllerStepTwoAdd  = TextEditingController();
  final ownerNameControllerAdd = TextEditingController(text: "Softsnip");
  final hirerNameControllerAdd = TextEditingController(text: "Softsnip");

  var selectedDamageType3 = 1.obs;
  var damagePoints3 = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes3 = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];

  RxList<ImageHolder> pickupCarImages3 = <ImageHolder>[].obs;
  final int maxPickupImages2 = 10;

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



  @override
  void onClose() {

     weeklyRentControllerStepTwo.dispose();
     rentBondAmountControllerStepTwo.dispose();
     rentDueAmountControllerStepTwo.dispose();

    bondAmountControllerStepTwo.dispose();
    paidBondControllerStepTwo.dispose();
     dueBondAmountControllerStepTwo.dispose();
     dueBondReturnedControllerStepTwo.dispose();

     odoControllerStepTwo.dispose();
     fuelLevelControllerStepTwo.dispose();
     interiorCleanlinessControllerStepTwo.dispose();
     exteriorCleanlinessControllerStepTwo.dispose();
     additionalCommentsControllerStepTwo.dispose();
     odoControllerDropOff.dispose();
     fuelLevelControllerDropOff.dispose();
     interiorCleanlinessControllerDropOff.dispose();
     exteriorCleanlinessControllerDropOff.dispose();

     startDateControllerStepTwo.dispose();
     startTimeControllerStepTwo.dispose();
     endDateControllerStepTwo.dispose();
     endTimeControllerStepTwo.dispose();

     weeklyRentControllerStepTwoAdd.dispose();
     rentBondAmountControllerStepTwoAdd.dispose();
     rentDueAmountControllerStepTwoAdd.dispose();

     bondAmountControllerStepTwoAdd.dispose();
     paidBondControllerStepTwoAdd.dispose();
     dueBondAmountControllerStepTwoAdd.dispose();
     dueBondReturnedControllerStepTwoAdd.dispose();

     odoControllerStepTwoAdd.dispose();
     fuelLevelControllerStepTwoAdd.dispose();
     interiorCleanlinessControllerStepTwoAdd.dispose();
     exteriorCleanlinessControllerStepTwoAdd.dispose();
     additionalCommentsControllerStepTwoAdd.dispose();
     odoControllerDropOffAdd.dispose();
     fuelLevelControllerDropOffAdd.dispose();
     interiorCleanlinessControllerDropOffAdd.dispose();
     exteriorCleanlinessControllerDropOffAdd.dispose();

     startDateControllerStepTwoAdd.dispose();
     startTimeControllerStepTwoAdd.dispose();
     endDateControllerStepTwoAdd.dispose();
     endTimeControllerStepTwoAdd.dispose();


     searchController.dispose();
     horizontalScrollController.dispose();

    super.onClose();
  }





}