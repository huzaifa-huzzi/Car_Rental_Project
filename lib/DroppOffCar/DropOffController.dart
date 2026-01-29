import 'package:car_rental_project/Resources/Colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DamagePoint {
  final double dx;
  final double dy;
  final int typeId;
  final Color color;

  DamagePoint({required this.dx, required this.dy, required this.typeId, required this.color});
}

class DropOffController extends GetxController{

       /// Pagination Bar
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 8.obs;
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

  var selectedDamageType = 1.obs;
  var damagePoints = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];


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

    super.onClose();
  }





}