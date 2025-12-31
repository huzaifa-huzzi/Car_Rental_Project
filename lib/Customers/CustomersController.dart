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
  final RxInt pageSize2 = 8.obs;
  final RxInt selectedView2 = 0.obs;

  RxList<Map<String, dynamic>> carList2 = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    carList2.addAll(List.generate(50, (index) => {"id": index, "name": "Customer $index"}));
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



}