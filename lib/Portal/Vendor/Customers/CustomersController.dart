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

class ImageHolder {
  final String? path;
  final Uint8List? bytes;
  final String? name;

  ImageHolder({this.path, this.bytes, this.name});
}


class CustomerController extends GetxController {
  var selectAge = "".obs;
  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;

  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

   /// Pagination
  // Pagination State
  final RxInt currentPage2 = 1.obs;
  final RxInt pageSize2 = 10.obs;
  final RxInt selectedView2 = 0.obs;

  RxList<Map<String, dynamic>> carList2 = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    carList2.addAll(List.generate(50, (index) => {"id": index, "Customer name": "Customer $index"}));
  }

  int get totalPages {
    if (carList2.isEmpty) return 1;
    return (carList2.length / pageSize2.value).ceil();
  }

  List<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage2.value - 1) * pageSize2.value;
    if (start >= carList2.length) return [];
    int end = start + pageSize2.value;
    return carList2.sublist(start, end > carList2.length ? carList2.length : end);
  }

  void goToPreviousPage() {
    if (currentPage2.value > 1) currentPage2.value--;
  }

  void goToNextPage() {
    if (currentPage2.value < totalPages) currentPage2.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage2.value = page;
  }

  void setPageSize(int newSize) {
    pageSize2.value = newSize;
    currentPage2.value = 1;
  }

  /// CustomerDetail Screen
  // Popup Logic
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

  /// Add Customer Screen

  Rxn<ImageHolder> profileImage = Rxn<ImageHolder>();

  final givenNameController = TextEditingController();
  final surnameController = TextEditingController();
  final dobController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final noteController = TextEditingController();

  final licenseNameController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final licenseExpiryController = TextEditingController();
  final licenseCardNumberController = TextEditingController();

  RxList<Rx<DocumentHolder?>> selectedDocuments = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers = <TextEditingController>[].obs;
  final int maxDocuments = 6;

  final ccNumberController = TextEditingController();
  final ccHolderController = TextEditingController();
  final ccExpiryController = TextEditingController();
  final ccCvcController = TextEditingController();
  final ccCountryController = TextEditingController();
  var selectedCardIndex = 0.obs;

  RxInt totalCardsAdd2 = 1.obs;

  void addNewCardSlot() {
    if (totalCardsAdd2.value < 5) {
      totalCardsAdd2.value++;
      selectedCardIndex.value = totalCardsAdd2.value - 1;
    } else {
      Get.snackbar("Limit Reached", "You can only add up to 5 cards.");
    }
  }

  // Pick Profile Image
  Future<void> pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, withData: kIsWeb);
    if (result != null) {
      final file = result.files.first;
      profileImage.value = ImageHolder(
        bytes: kIsWeb ? file.bytes : null,
        path: kIsWeb ? null : file.path,
        name: file.name,
      );
    }
  }

  void addDocumentSlot() {
    if (selectedDocuments.length < maxDocuments) {
      documentNameControllers.add(TextEditingController());
      selectedDocuments.add(Rx<DocumentHolder?>(null));
    }
  }

  void removeDocumentSlot(int index) {
    if (selectedDocuments.length > 1) {
      documentNameControllers[index].dispose();
      documentNameControllers.removeAt(index);
      selectedDocuments.removeAt(index);
    } else {
      selectedDocuments[index].value = null;
      documentNameControllers[index].clear();
    }
  }

  Future<void> pickDocument(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      withData: kIsWeb,
    );
    if (result != null) {
      final file = result.files.first;
      selectedDocuments[index].value = DocumentHolder(
        bytes: kIsWeb ? file.bytes : null,
        path: kIsWeb ? null : file.path,
        name: file.name,
      );
    }
  }

  /// Edit Customer Screen
  Rxn<ImageHolder> profileImage2 = Rxn<ImageHolder>();

  final givenNameController2 = TextEditingController();
  final surnameController2 = TextEditingController();
  final dobController2 = TextEditingController();
  final contactController2 = TextEditingController();
  final emailController2 = TextEditingController();
  final addressController2 = TextEditingController();

  final noteController2 = TextEditingController();

  final licenseNameController2 = TextEditingController();
  final licenseNumberController2 = TextEditingController();
  final licenseExpiryController2 = TextEditingController();
  final licenseCardNumberController2 = TextEditingController();

  RxList<Rx<DocumentHolder?>> selectedDocuments2 = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers2 = <TextEditingController>[].obs;
  final int maxDocuments2 = 6;

  RxInt totalCards = 1.obs;

  void addNewCard() {
    if (totalCards.value < 5) {
      totalCards.value++;
      selectedCardIndex2.value = totalCards.value - 1;
    } else {
      Get.snackbar("Limit Reached", "You can only add up to 5 cards.");
    }
  }

  final ccNumberController2 = TextEditingController();
  final ccHolderController2 = TextEditingController();
  final ccExpiryController2 = TextEditingController();
  final ccCvcController2 = TextEditingController();
  final ccCountryController2 = TextEditingController();
  var selectedCardIndex2 = 0.obs;

  // Pick Profile Image
  Future<void> pickProfileImage2() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, withData: kIsWeb);
    if (result != null) {
      final file = result.files.first;
      profileImage2.value = ImageHolder(
        bytes: kIsWeb ? file.bytes : null,
        path: kIsWeb ? null : file.path,
        name: file.name,
      );
    }
  }

  void addDocumentSlot2() {
    if (selectedDocuments2.length < maxDocuments2) {
      documentNameControllers2.add(TextEditingController());
      selectedDocuments2.add(Rx<DocumentHolder?>(null));
    }
  }

  void removeDocumentSlot2(int index) {
    if (selectedDocuments.length > 1) {
      documentNameControllers2[index].dispose();
      documentNameControllers2.removeAt(index);
      selectedDocuments2.removeAt(index);
    } else {
      selectedDocuments2[index].value = null;
      documentNameControllers2[index].clear();
    }
  }

  Future<void> pickDocument2(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      withData: kIsWeb,
    );
    if (result != null) {
      final file = result.files.first;
      selectedDocuments2[index].value = DocumentHolder(
        bytes: kIsWeb ? file.bytes : null,
        path: kIsWeb ? null : file.path,
        name: file.name,
      );
    }
  }

  /// CardList Customer Header Widget
  RxBool isSearchCategoryOpen = false.obs;
  RxString selectedSearchType = "Customer Name".obs;

  void toggleSearchCategory() {
    isSearchCategoryOpen.value = !isSearchCategoryOpen.value;
    if (isSearchCategoryOpen.value) {
      isFilterOpen.value = false;
    }
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
    // 1. Add Customer Screen Controllers
    givenNameController.dispose();
    surnameController.dispose();
    dobController.dispose();
    contactController.dispose();
    emailController.dispose();
    addressController.dispose();
    noteController.dispose();
    licenseNameController.dispose();
    licenseNumberController.dispose();
    licenseExpiryController.dispose();
    licenseCardNumberController.dispose();
    ccNumberController.dispose();
    ccHolderController.dispose();
    ccExpiryController.dispose();
    ccCvcController.dispose();
    ccCountryController.dispose();

    // Dynamic Document Controllers (Add Screen)
    for (var controller in documentNameControllers) {
      controller.dispose();
    }

    // 2. Edit Customer Screen Controllers
    givenNameController2.dispose();
    surnameController2.dispose();
    dobController2.dispose();
    contactController2.dispose();
    emailController2.dispose();
    addressController2.dispose();
    noteController2.dispose();
    licenseNameController2.dispose();
    licenseNumberController2.dispose();
    licenseExpiryController2.dispose();
    licenseCardNumberController2.dispose();
    ccNumberController2.dispose();
    ccHolderController2.dispose();
    ccExpiryController2.dispose();
    ccCvcController2.dispose();
    ccCountryController2.dispose();

    // Dynamic Document Controllers (Edit Screen)
    for (var controller in documentNameControllers2) {
      controller.dispose();
    }

    super.onClose();
  }




}