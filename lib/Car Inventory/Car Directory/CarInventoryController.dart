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
  final String defaultHint;

  DocumentHolder({this.path, this.bytes, required this.name, required this.defaultHint});
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
  final seatsController = TextEditingController();
  final engineController = TextEditingController();
  final colorController = TextEditingController();
  final regController = TextEditingController();
  final valueController = TextEditingController();
  final weeklyRentController = TextEditingController();
  var openedDropdown = "".obs;

  RxList<Rx<DocumentHolder?>> selectedDocuments = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers = <TextEditingController>[].obs;

  final List<String> defaultDocumentNames = ["Document", "Document", "Document", "Document", "Document", "Document"];
  final int maxDocuments = 6;


  // Initial state: Only "Add Document" button is shown.

  void addDocumentSlot() {
    if (selectedDocuments.length < maxDocuments) {
      String defaultHint = defaultDocumentNames[selectedDocuments.length];

      documentNameControllers.add(TextEditingController());

      selectedDocuments.add(Rx<DocumentHolder?>(null));
    } else {
      Get.snackbar("Limit Reached", "You can only add a maximum of $maxDocuments documents.");
    }
  }

  void removeDocumentSlot(int index) {
    if (index >= 0 && index < selectedDocuments.length) {
      documentNameControllers[index].dispose();
      documentNameControllers.removeAt(index);

      selectedDocuments.removeAt(index);

    }
  }


  Future<void> pickDocument(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
      withData: kIsWeb ? true : false,
      withReadStream: kIsWeb ? false : true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      String name = file.name;
      String defaultHint = defaultDocumentNames[index];

      if (kIsWeb) {
        if (file.bytes != null) {
          selectedDocuments[index].value = DocumentHolder(bytes: file.bytes, name: name, defaultHint: defaultHint);
        }
      } else {
        if (file.path != null) {
          selectedDocuments[index].value = DocumentHolder(path: file.path, name: name, defaultHint: defaultHint);
        }
      }
    }
  }
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
            selectedImages.add(ImageHolder(bytes: file.bytes, name: file.name));
          }
        } else {

          if (file.path != null) {
            selectedImages.add(ImageHolder(path: file.path, name: file.name));
          }
        }
      }
    }
  }

  RxList<ImageHolder> selectedImages = <ImageHolder>[].obs;

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
    }
  }

  /// Car Details Screen




}