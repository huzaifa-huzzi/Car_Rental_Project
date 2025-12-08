import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;

class ImageHolder {
  final String? path;
  final Uint8List? bytes;
  final String? name;

  ImageHolder({this.path, this.bytes, this.name});
}

class DocumentHolder {
  final String? path;
  final Uint8List? bytes;
  final String name;

  DocumentHolder({this.path, this.bytes, required this.name});
}


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


 /// AddingCar Screen
 final  seatsController = TextEditingController();
 final engineController = TextEditingController();
 final colorController = TextEditingController();
 final  regController = TextEditingController();
 final  valueController = TextEditingController();
 final  weeklyRentController = TextEditingController();
  var openedDropdown = "".obs;
  Rx<DocumentHolder?> selectedDoc1 = Rx<DocumentHolder?>(null);
  Rx<DocumentHolder?> selectedDoc2 = Rx<DocumentHolder?>(null);
  Rx<DocumentHolder?> selectedDoc3 = Rx<DocumentHolder?>(null);

  TextEditingController docName1Controller = TextEditingController();
  TextEditingController docName2Controller = TextEditingController();



  RxList<ImageHolder> selectedImages = <ImageHolder>[].obs;


  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: kIsWeb ? true : false,
      withReadStream: kIsWeb ? false : true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (kIsWeb) {

          if (file.bytes != null) {
            selectedImages.add(ImageHolder(bytes: file.bytes));
          }
        } else {

          if (file.path != null) {
            selectedImages.add(ImageHolder(path: file.path));
          }
        }
      }
    }
  }

  void toggleDropdown(String id) {
    if (openedDropdown.value == id) {
      openedDropdown.value = "";
    } else {
      openedDropdown.value = id;
    }
  }


  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }



  }

  Future<void> pickDocument(Rx<DocumentHolder?> doc) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
      withData: kIsWeb,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      if (kIsWeb) {
        if (file.bytes != null) {
          doc.value = DocumentHolder(bytes: file.bytes, name: file.name);
        }
      } else {
        if (file.path != null) {
          doc.value = DocumentHolder(path: file.path, name: file.name);
        }
      }
    }
  }




}