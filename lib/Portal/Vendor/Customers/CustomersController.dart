import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/CustomCalendarSutomer.dart';
import 'package:car_rental_project/Resources/Colors.dart';
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
    carList2.addAll(List.generate(
        50, (index) => {"id": index, "Customer name": "Customer $index"}));
  }

  int get totalPages {
    if (carList2.isEmpty) return 1;
    return (carList2.length / pageSize2.value).ceil();
  }

  List<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage2.value - 1) * pageSize2.value;
    if (start >= carList2.length) return [];
    int end = start + pageSize2.value;
    return carList2.sublist(
        start, end > carList2.length ? carList2.length : end);
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
  var imageError = false.obs;

  Future<void> pickProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: kIsWeb
    );

    if (result != null) {
      final file = result.files.first;
      profileImage.value = ImageHolder(
        bytes: kIsWeb ? file.bytes : null,
        path: kIsWeb ? null : file.path,
        name: file.name,
      );
      imageError.value = false;
    }
  }

  bool validateProfileImage() {
    if (profileImage.value == null) {
      imageError.value = true;
      Get.snackbar(
          "Photo Required",
          "Please upload a profile photo to continue.",
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
      );
      return false;
    } else {
      imageError.value = false;
      return true;
    }
  }

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
  RxList<TextEditingController> documentNameControllers = <
      TextEditingController>[].obs;
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

  final LayerLink dobLink = LayerLink();
  final LayerLink expiryLink = LayerLink();
  final TextEditingController selectedYearCarController = TextEditingController();
  var selectedCarYear = "".obs;
  final GlobalKey carYearKey = GlobalKey();
  var isDateDropOpen = false.obs;

  OverlayEntry? calendarOverlay;

  void toggleCalendar(BuildContext context, LayerLink link,
      TextEditingController targetController, {bool isYearOnly = false}) {
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


  OverlayEntry _createCalendarOverlay(BuildContext context,
      LayerLink link,
      TextEditingController targetController,) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    bool isMobile = screenSize.width < 600;

    double overlayWidth;
    if (screenSize.width < 400) {
      overlayWidth = screenSize.width * 0.9;
    } else {
      overlayWidth = 300;
    }

    return OverlayEntry(
      builder: (context) =>
          Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: removeCalendar,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                      color: AppColors.fieldsBackground.withOpacity(0.05)),
                ),
              ),
              isMobile
                  ? Center(
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: overlayWidth,
                    child: _buildCalendarContent(
                        overlayWidth, targetController),
                  ),
                ),
              )
                  : CompositedTransformFollower(
                link: link,
                showWhenUnlinked: false,
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                offset: const Offset(0, 8),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: overlayWidth,
                    child: _buildCalendarContent(
                        overlayWidth, targetController),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildCalendarContent(double width, TextEditingController controller) {
    return CustomCalendarCustomer(
      width: width,
      allowFuture: controller == licenseExpiryController,
      onCancel: removeCalendar,
      onDateSelected: (date) {
        String day = date.day.toString().padLeft(2, '0');
        String month = date.month.toString().padLeft(2, '0');
        if (controller == selectedYearCarController) {
          controller.text = "${date.year}";
        } else {
          controller.text = "$day/$month/${date.year}";
        }
        removeCalendar();
      },
    );
  }
  static final GlobalKey<FormState> customerFormKey = GlobalKey<FormState>();
  var dropdownErrors = <String, String>{}.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) return "Enter a valid email address";
    return null;
  }

  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "$fieldName is required";
    return null;
  }
  bool saveCustomer2(BuildContext context) {
    bool isFormValid = customerFormKey.currentState?.validate() ?? false;
    bool hasProfileImg = profileImage.value != null;
    if (!hasProfileImg) {
      Get.snackbar("Photo Required", "Please upload customer profile photo",
          backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    }

    return isFormValid && hasProfileImg;
  }
   /// StepTwoCustomer
  var isCredentialsGenerated = false.obs;
  var userName = "talhabukhari".obs;
  var password = "5ellostore.".obs;
  var isPasswordVisible = false.obs;
  void generateCredentials() {
    isCredentialsGenerated.value = true;
  }
  void regeneratePassword() {
    password.value = "newpassword123";
  }

  Future<void> saveCustomer(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
  }
  var isPasswordHidden = true.obs;
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
  RxString selectedCode = "+61".obs;
  RxString selectedFlag = "🇦🇺".obs;
  var selectedCountryName = "Australia".obs;
  final phoneController = TextEditingController();
  final searchController = TextEditingController();



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
  static final editCustomerFormKey = GlobalKey<FormState>();
  RxBool imageError2 = false.obs;

  String? validateRequired2(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  String? validateEmail2(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return emailValid ? null : "Please enter a valid email";
  }

  bool validateProfileImage2() {
    if (profileImage2.value == null) {
      imageError2.value = true;
      return false;
    }
    imageError2.value = false;
    return true;
  }

// Update Logic
  void updateCustomerData(BuildContext context) {
    if (editCustomerFormKey.currentState!.validate() && validateProfileImage2()) {
      // Agar sab theek hai to update process karein
      print("Form Validated! Updating...");
    } else {
      print("Validation Failed");
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