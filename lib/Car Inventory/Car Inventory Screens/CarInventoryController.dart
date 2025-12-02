import 'package:get/get.dart';
import 'dart:math';

class CarInventoryController extends GetxController {
  RxInt selectedView = 0.obs;

  RxList<Map<String, dynamic>> carList = <Map<String, dynamic>>[].obs;

  final _random = Random();


  String _getRandomStatus() {
    final statusOptions = ["Available", "Maintenance", "Unavailable"];
    final randomIndex = _random.nextInt(statusOptions.length);
    return statusOptions[randomIndex];
  }

  @override
  void onInit() {
    super.onInit();

    /// Dummy data
    List<String> brands = ["Aston", "BMW", "Audi", "Ford", "Honda"];
    List<String> models = ["Martin", "X7", "A4", "Focus", "Civic"];
    List<String> years = ["2023", "2022", "2020", "2018", "2017"];
    List<String> chassis = ["WVC-098", "HFC-082", "XYZ-345", "ABC-123", "QWE-678"];


    /// 20 data entries
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
}