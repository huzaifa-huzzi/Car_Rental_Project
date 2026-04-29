import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/CustomCalendarCar.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
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

  /// ReusableWidgetOfPickup Controller
  // pagination  Widget
  final RxInt currentPage = 1.obs;

  // Make pageSize reactive
  final RxInt pageSize = 10.obs;

  RxList<Map<String, dynamic>> carList = <Map<String, dynamic>>[].obs;

  int get totalPages => (carList.length / pageSize.value).ceil();

  RxList<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage.value - 1) * pageSize.value;
    int end = start + pageSize.value;
    if (end > carList.length) end = carList.length;

    if (carList.isEmpty) return <Map<String, dynamic>>[].obs;

    return carList.sublist(start, end).obs;
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) currentPage.value--;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) currentPage.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void setPageSize(int newSize) {
    pageSize.value = newSize;
    currentPage.value = 1;
  }


  /// Table View Screen
  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;

  RxBool isSearchCategoryOpen = false.obs;
  RxString selectedSearchType = "VIN Number".obs;

  void toggleSearchCategory() {
    isSearchCategoryOpen.value = !isSearchCategoryOpen.value;
    if (isSearchCategoryOpen.value) {
      isFilterOpen.value = false;
    }
  }



  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
    if (isFilterOpen.value) {
      isSearchCategoryOpen.value = false;
    }
  }


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
    List<String> transmissions = ["Auto", "Manual"];
    List<String> years = ["2023", "2022", "2020", "2018", "2017"];

    carList.value = List.generate(10, (i) {
      int index = i % brands.length;
      int transIndex = i % transmissions.length;

      String getStatus(int i) {
        if (i % 3 == 0) return "Available";
        if (i % 3 == 1) return "Maintenance";
        return "Unavailable";
      }

      return {
        "vin": "JTNBA3HK003001234",
        "reg": "1234567890",
        "brand": brands[index],
        "carName" : "Toyota Corolla (2017)",
        "bodyType": "Sedan",
        "status": getStatus(i),
        "transmission": transmissions[transIndex],
        "capacity": "4 Seats",
        "fuel": "Petrol",
        "engine": "2.0L",
        "price": "120\$ Weekly",
      };
    });
  }





  /// ListView Screen


 /// GridView Screen


 /// AddingCar Screen
  var selectedEngine = "".obs;
  var selectedColor = "".obs;
  final regController = TextEditingController();
  final vinController = TextEditingController();
  final valueController = TextEditingController();
  final weeklyRentController = TextEditingController();
  var openedDropdown = "".obs;
  var isDateDropOpen = false.obs;




  RxList<Rx<DocumentHolder?>> selectedDocuments = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers = <TextEditingController>[].obs;

  final List<String> defaultDocumentNames = ["Document", "Document", "Document", "Document", "Document", "Document"];
  final int maxDocuments = 6;



  void addDocumentSlot() {
    if (selectedDocuments.length < maxDocuments) {
      String defaultHint = defaultDocumentNames[selectedDocuments.length];

      documentNameControllers.add(TextEditingController());

      selectedDocuments.add(Rx<DocumentHolder?>(null));
    } else {
      Get.snackbar("Limit Reached", "You can only add a maximum of $maxDocuments documents.");
    }
  }


  final LayerLink carYearLink = LayerLink();
  final TextEditingController selectedYearCarController = TextEditingController();
  var selectedCarYear = "".obs;
  final GlobalKey carYearKey = GlobalKey();

  OverlayEntry? calendarOverlay;

  void toggleCalendar(BuildContext context, LayerLink link, TextEditingController targetController) {
    if (calendarOverlay != null) {
      removeCalendar();
    } else {
      calendarOverlay = _createCalendarOverlay(context, link, targetController);
      Overlay.of(context).insert(calendarOverlay!);
      isDateDropOpen.value = true;
    }
  }

  void removeCalendar() {
    calendarOverlay?.remove();
    calendarOverlay = null;
    isDateDropOpen.value = false;
  }


  OverlayEntry _createCalendarOverlay(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      ) {
    final screenSize = MediaQuery.of(context).size;
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    double overlayWidth;
    if (screenSize.width < 400) {
      overlayWidth = screenSize.width * 0.9;
    } else if (screenSize.width < 600) {
      overlayWidth = 260;
    } else if (screenSize.width < 1000) {
      overlayWidth = 280;
    } else {
      overlayWidth = 300;
    }
    double dx = 0;
    if (position.dx + overlayWidth > screenSize.width) {
      dx = screenSize.width - (position.dx + overlayWidth) - 10;
    }
    if (position.dx + dx < 10) {
      dx = -position.dx + 10;
    }
    double dy = 6;
    double estimatedHeight = 320;

    if (position.dy + estimatedHeight > screenSize.height) {
      dy = -estimatedHeight - 10;
    }

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeCalendar,
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: dy < 0
                ? Alignment.bottomLeft
                : Alignment.topLeft,

            offset: Offset(dx, dy),

            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: SizedBox(
                width: overlayWidth,
                child: CustomCalendarCar(
                  width: overlayWidth,
                  onCancel: removeCalendar,
                  onDateSelected: (date) {
                    selectedCarYear.value = "${date.year}";
                    targetController.text = "${date.year}";
                    removeCalendar();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
  static final GlobalKey<FormState> carInventoryKey = GlobalKey<FormState>();

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "$fieldName is required";
    return null;
  }

  String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "$fieldName is required";
    if (double.tryParse(value) == null) return "Enter a valid number";
    return null;
  }
  final descriptionController = TextEditingController();

  String? validateVIN(String? value) {
    if (value == null || value.isEmpty) return "VIN Number is required";
    if (value.trim().length != 17) {
      return "VIN must be exactly 17 characters";
    }
    return null;
  }

  String? validateRegistration(String? value) {
    if (value == null || value.isEmpty) return "Registration is required";
    if (value.trim().length < 8 || value.trim().length > 10) {
      return "Must be between 8 to 10 characters";
    }
    return null;
  }

  bool saveInventory(BuildContext context) {
    final bool isFormValid = carInventoryKey.currentState?.validate() ?? false;
    final bool isDropValid = validateDropdowns();
    final bool hasImages = selectedImages.isNotEmpty;
    if (!hasImages) {
      dropdownErrors['images'] = "Required";
    } else {
      dropdownErrors['images'] = "";
    }
    return isFormValid && isDropValid && hasImages;
  }
  // Dialogs
  void showSavingDialog(BuildContext context) {
    double progress = 0.0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        Future.delayed(Duration.zero, () async {
          while (progress < 1.0) {
            await Future.delayed(const Duration(milliseconds: 40));
            progress += 0.02;
            (context as Element).markNeedsBuild();
          }
          Navigator.pop(context);
          showSuccessDialog(context);
        });

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 10,
              backgroundColor: Colors.white,
              child: Container(
                width: screenWidth < 600 ? screenWidth * 0.9 : 450,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(IconString.searchingIcon),
                        ),
                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextString.dialogInventory1,
                                style: TTextTheme.h2Style(context),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                TextString.dialogInventory2,
                                style: TTextTheme.bodyRegular16(context),
                              ),
                              const SizedBox(height: 25),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  backgroundColor: AppColors.backgroundOfPickupsWidget,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.emojiBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                TextString.dialogInventory3,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.dialogInventory4,
                                style: TTextTheme.bodyRegular16(context)
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 16, color: AppColors.blackColor),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  var dropdownErrors = <String, String>{}.obs;

  bool validateDropdowns() {
    bool isValid = true;
    List<String> requiredIds = [
      'search_car',
      'Model',
      'year',
      'body',
      'trans',
      'seats',
      'engine',
      'color',
      'fuel',
      'status'
    ];

    for (var id in requiredIds) {
      String value = "";
      if (id == 'search_car') {
        value = selectedBrand.value;
      } else if (id == 'Model') value = selectedModel.value;
      else if (id == 'year') value = selectedCarYear.value;
      else if (id == 'body') value = selectedBodyType.value;
      else if (id == 'trans') value = selectedTransmission.value;
      else if (id == 'seats') value = selectedSeats.value;
      else if (id == 'engine') value = selectedEngine.value;
      else if (id == 'color') value = selectedColor.value;
      else if (id == 'fuel') value = selectedFuel.value;
      else if (id == 'status') value = selectedStatus.value;

      if (value.isEmpty) {
        dropdownErrors[id] = "Please select an option";
        isValid = false;
      } else {
        dropdownErrors[id] = "";
      }
    }
    return isValid;
  }



  /// Car Details Screen
  RxInt selectedIndex = 0.obs;


  void changeImage(int index) {
    selectedIndex.value = index;
  }
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



  /// Editing Car Screen
  final seats2Controller = TextEditingController();
  final engine2Controller = TextEditingController();
  final color2Controller = TextEditingController();
  final reg2Controller = TextEditingController();
  final vin2Controller = TextEditingController();
  final value2Controller = TextEditingController();
  final weekly2RentController = TextEditingController();
  var openedDropdown2 = "".obs;

  var selectedBrand2 = "".obs;
  var selectedModel2 = "".obs;
  var selectedYear2 = "".obs;
  var selectedBodyType2 = "".obs;
  var selectedStatus2 = "".obs;
  var selectedTransmission2 = "".obs;
  var selectedFuel2 = "".obs;



  RxList<Rx<DocumentHolder?>> selectedDocuments2 = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers2 = <TextEditingController>[].obs;

  final List<String> defaultDocumentNames2 = ["Document", "Document", "Document", "Document", "Document", "Document"];
  final int maxDocuments2 = 6;



  void addDocumentSlot2() {
    if (selectedDocuments2.length < maxDocuments2) {
      documentNameControllers2.add(TextEditingController());
      selectedDocuments2.add(Rx<DocumentHolder?>(null));
    }
  }


  void removeDocumentSlot2(int index) {
    documentNameControllers2[index].dispose();
    documentNameControllers2.removeAt(index);
    selectedDocuments2.removeAt(index);
  }



  Future<void> pickDocument2(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
      withData: kIsWeb ? true : false,
      withReadStream: kIsWeb ? false : true,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      String name = file.name;
      String defaultHint = defaultDocumentNames2[index];

      if (kIsWeb) {
        if (file.bytes != null) {
          selectedDocuments2[index].value = DocumentHolder(bytes: file.bytes, name: name, defaultHint: defaultHint);
        }
      } else {
        if (file.path != null) {
          selectedDocuments2[index].value = DocumentHolder(path: file.path, name: name, defaultHint: defaultHint);
        }
      }
    }
  }

  Future<void> pickImage2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'svg'],
      withData: kIsWeb ? true : false,
      withReadStream: kIsWeb ? false : true,
    );

    if (result != null) {
      for (var file in result.files) {
        if (kIsWeb && file.bytes != null) {
          selectedImages2.add(ImageHolder(bytes: file.bytes, name: file.name));
        } else if (!kIsWeb && file.path != null) {
          selectedImages2.add(ImageHolder(path: file.path, name: file.name));
        }
      }
    }
  }


  RxList<ImageHolder> selectedImages2 = <ImageHolder>[].obs;

  void removeImage2(int index) {
    selectedImages2.removeAt(index);
  }

  /// Sorting
  var sortColumn = "".obs;
  var sortOrder = 0.obs;

  void toggleSort(String columnName) {
    if (sortColumn.value == columnName) {
      sortOrder.value = (sortOrder.value + 1) % 3;
      if (sortOrder.value == 0) sortColumn.value = "";
    } else {
      sortColumn.value = columnName;
      sortOrder.value = 1;
    }
  }


  @override
  void onClose() {
    // 1. Adding Car Screen Controllers
    seatsController.dispose();
    regController.dispose();
    vinController.dispose();
    valueController.dispose();
    weeklyRentController.dispose();

    //  Document Controllers (Adding Car)
    for (var controller in documentNameControllers) {
      controller.dispose();
    }

    //  Editing Car Screen Controllers
    seats2Controller.dispose();
    engine2Controller.dispose();
    color2Controller.dispose();
    reg2Controller.dispose();
    vin2Controller.dispose();
    value2Controller.dispose();
    weekly2RentController.dispose();

    //  Document Controllers (Editing Car)
    for (var controller in documentNameControllers2) {
      controller.dispose();
    }

    super.onClose();
  }


  var searchCarText = "".obs;
  var openedDropdown3 = "".obs;
  var selectedBrand4 = "Select Car".obs;

  List<String> get filteredCars {
    List<String> allCars = ["Toyota Corolla", "Ford Focus", "Tesla Model S", "Volkswagen Golf"];
    if (searchCarText.value.isEmpty) return allCars;
    return allCars.where((car) => car.toLowerCase().contains(searchCarText.value.toLowerCase())).toList();
  }

  final List<String> allBrands = ["Toyota", "Ford", "Honda", "Tesla", "BMW", "Audi"];

  final Map<String, List<String>> brandModels = {
    "Toyota": ["Corolla", "Camry", "Prado", "Hilux"],
    "Ford": ["Focus", "Mustang", "F-150", "Explorer"],
    "Honda": ["Civic", "Accord", "CR-V"],
    "Tesla": ["Model S", "Model 3", "Model X", "Model Y"],
  };


  var seatsController = TextEditingController(text: "5");
  var selectedSeats = "5".obs;
  final List<String> bodyTypes = ["Sedan", "SUV", "Hatchback", "Coupe", "Wagon", "Convertible", "ute", "Van", "Truck", "Other"];
  final List<String> transmissions = ["Automatic", "Manual"];
  final List<String> fuelTypes = ["Petrol", "Diesel", "Hybrid", "Plug-in Hybrid", "Electric", "LPG"];
  final List<String> statuses = ["Available", "Maintenance", "Unavailable"];
  final List<String> seatOptions = ["2", "4", "5", "7"];
  final List<String> engineOptions = ["0.8", "1.0", "1.2", "1.5", "2.0"];
  final List<String> colorOptions = ["White", "Black", "Silver", "Grey", "Red", "Blue", "Green", "Yellow", "Brown", "Gold", "Orange", "Purple", "Other"];

  List<String> getFilteredItems(String id) {
    List<String> currentList = [];

    switch (id) {
      case 'search_car':
        currentList = allBrands;
        break;

      case 'Model':
        currentList = selectedBrand.value.isEmpty
            ? []
            : (brandModels[selectedBrand.value] ?? []);
        break;

      case 'body':
        currentList = bodyTypes;
        break;

      case 'trans':
        currentList = transmissions;
        break;

      case 'fuel':
        currentList = fuelTypes;
        break;

      case 'status':
        currentList = statuses;
        break;

      case 'seats':
        currentList = seatOptions;
        break;

      case 'engine':
        currentList = engineOptions;
        break;

      case 'color':
        currentList = colorOptions;
        break;

      default:
        currentList = [];
    }
    if (searchCarText.value.isEmpty) {
      return currentList;
    } else {
      return currentList
          .where((item) => item.toLowerCase().contains(searchCarText.value.toLowerCase().trim()))
          .toList();
    }
  }

  void resetSearch() {
    searchCarText.value = "";
    openedDropdown3.value = "";
    openedDropdown2.value = "";
  }

}