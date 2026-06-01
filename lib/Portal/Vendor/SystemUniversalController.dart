import 'package:get/get.dart';

class SystemUniversalController extends GetxController {
  var searchCarText = "".obs;
  var openedDropdownId = "".obs;

  final List<String> allBrands = ["Toyota", "Ford", "Honda", "Tesla", "BMW", "Audi"];

  final List<String> allModels = [
    "Corolla", "Camry", "Prado", "Hilux",
    "Focus", "Mustang", "F-150", "Explorer",
    "Civic", "Accord", "CR-V",
    "Model S", "Model 3", "Model X", "Model Y"
  ];

  List<String> getFilteredUniversalItems(String id) {
    List<String> currentList = [];
    if (id == 'search_car' || id == 'make2' || id == 'make') {
      currentList = allBrands;
    }
    else if (id == 'Model' || id == 'model2' || id == 'model') {
      currentList = allModels;
    }

    if (searchCarText.value.isEmpty) {
      return currentList;
    } else {
      return currentList
          .where((item) => item.toLowerCase().contains(searchCarText.value.toLowerCase().trim()))
          .toList();
    }
  }
}