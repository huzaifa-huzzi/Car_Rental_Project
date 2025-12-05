import 'package:get/get.dart';
import 'dart:math';

class CarInventoryController extends GetxController {
  var selectedBrand = "".obs;
  var selectedModel = "".obs;
  var selectedYear = "".obs;
  var selectedBodyType = "".obs;
  var selectedStatus = "".obs;
  var selectedTransmission = "".obs;
  var selectedFuel = "".obs;


  var selectedView = 0.obs;

  void selectView(int index) {
    selectedView.value = index;
  }

  /// Reusable Widget Controller
   // pagination  Widget
  final RxInt currentPage = 1.obs;
  final int pageSize = 8;

  RxList<Map<String, dynamic>> carList = <Map<String, dynamic>>[].obs;


  int get totalPages => (carList.length / pageSize).ceil();


  RxList<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage.value - 1) * pageSize;
    int end = start + pageSize;
    if (end > carList.length) {
      end = carList.length;
    }


    if (carList.isEmpty) return <Map<String, dynamic>>[].obs;

    return carList.sublist(start, end).obs;
  }


  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }


  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }


  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }


  /// Table View Screen
  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;
  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

  // DUMMY DATA SETUP
  final _random = Random();

  String _getRandomStatus() {
    final statusOptions = ["Available", "Maintenance", "Unavailable"];
    final randomIndex = _random.nextInt(statusOptions.length);
    return statusOptions[randomIndex];
  }

  @override
  void onInit() {
    super.onInit();

    List<String> brands = ["Aston", "BMW", "Audi", "Ford", "Honda"];
    List<String> models = ["Martin", "X7", "A4", "Focus", "Civic"];
    List<String> years = ["2023", "2022", "2020", "2018", "2017"];
    List<String> chassis = ["WVC-098", "HFC-082", "XYZ-345", "ABC-123", "QWE-678"];

    carList.value = List.generate(20, (i) {
      int index = i % brands.length;
      return {
        "brand": brands[index],
        "model": models[index],
        "year": years[index],
        "chasis": chassis[index],
        "rental": "Sedan",
        "status": _getRandomStatus(),
        "usage": "Auto",
        "seats": "2 Person",
        "fuel": "Petrol",
        "engine": "2.0 (L)",
        "price": "120\$ Weekly",
      };
    });
  }


  /// ListView Screen


 /// GridView Screen


}