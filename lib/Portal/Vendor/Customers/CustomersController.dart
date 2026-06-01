import 'package:car_rental_project/Portal/Vendor/Customers/CustomersDetails/Widget/PdfViewer.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/CustomCalendarSutomer.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:country_picker/country_picker.dart' hide Country;
import 'package:country_picker/src/country.dart';
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

  //  CORE GLOBAL & FILTER VARIABLES

  var selectAge = "".obs;
  RxBool isFilterOpen = false.obs;
  var hoveredRowIndex = (-1).obs;
  final customerFormKey = GlobalKey<FormState>();

  final RxInt currentPage2 = 1.obs;
  final RxInt pageSize2 = 10.obs;
  final RxInt selectedView2 = 0.obs;

  RxList<Map<String, dynamic>> carList2 = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> displayedCarList = <Map<String, dynamic>>[].obs;

  int get totalPages {
    if (carList2.isEmpty) return 1;
    return (carList2.length / pageSize2.value).ceil();
  }


  @override
  void onInit() {
    super.onInit();
    ever(currentPage2, (_) => _updateDisplayedList());
    ever(pageSize2, (_) => _updateDisplayedList());
  }

  @override
  void onReady() {
    super.onReady();
    _asyncLoadData();
  }

  void _asyncLoadData() async {
    try {
      isLoadingCountries.value = true;
      await Future.delayed(const Duration(milliseconds: 50));
      carList2.assignAll(List.generate(
          50, (index) => {"id": index, "Customer name": "Customer $index"}
      ));
      _updateDisplayedList();
      final data = CountryService().getAll();
      countryList.assignAll(data);
    } catch (e) {
      debugPrint("Error loading initialization data: $e");
    } finally {
      isLoadingCountries.value = false;
    }
  }

  //  PAGINATION LOGIC
  void _updateDisplayedList() {
    if (carList2.isEmpty) {
      displayedCarList.clear();
      return;
    }

    int start = (currentPage2.value - 1) * pageSize2.value;
    if (start >= carList2.length) {
      start = 0;
    }

    int end = start + pageSize2.value;
    if (end > carList2.length) end = carList2.length;

    displayedCarList.value = carList2.sublist(start, end);
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

  void toggleFilter() {
    isFilterOpen.value = !isFilterOpen.value;
  }

 // CUSTOMER DETAIL VIEW LOGIC

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

  final List<Map<String, dynamic>> documentsList = [
    {
      "title": "Gov ID",
      "status": "PDF",
      "isPdf": true,
      "filePath": ImageString.carRentalPdf,
    },
    {
      "title": "Passport",
      "status": "JPG",
      "isPdf": false,
      "filePath": ImageString.registrationForm,
    },
    {
      "title": "Driving License",
      "status": "PNG",
      "isPdf": false,
      "filePath": ImageString.registrationForm,
    },
  ];

  void handleDynamicView(BuildContext context, Map<String, dynamic> doc) {
    final String path = (doc["filePath"] ?? "") as String;
    final bool isPdf = (doc["isPdf"] ?? false) as bool;
    final String title = (doc["title"] ?? "Document") as String;

    if (path.isEmpty) return;

    if (isPdf) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GovIdPdfViewer(assetPath: path, title: title),
        ),
      );
    } else {
      open(path);
    }
  }

  void handleDynamicDownload(Map<String, dynamic> doc) {
    final String fileUrl = (doc["filePath"] ?? "") as String;
    debugPrint("Standard downloading active: $fileUrl");
  }

  //  ADD CUSTOMER CONTROLLERS & LOGIC

  Rxn<ImageHolder> profileImage = Rxn<ImageHolder>();
  var imageError = false.obs;

  // Form Fields Controllers
  final givenNameController = TextEditingController();
  final surnameController = TextEditingController();
  final dobController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final noteController = TextEditingController();

  // License Block
  final licenseNameController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final licenseExpiryController = TextEditingController();
  final licenseExpiryController2 = TextEditingController();
  final licenseCardNumberController = TextEditingController();

  // Documents Dynamic Management
  RxList<Rx<DocumentHolder?>> selectedDocuments = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers = <TextEditingController>[].obs;
  final int maxDocuments = 6;

  // Cards Block
  final ccNumberController = TextEditingController();
  final ccHolderController = TextEditingController();
  final ccExpiryController = TextEditingController();
  final ccCvcController = TextEditingController();
  final ccCountryController = TextEditingController();
  var selectedCardIndex = 0.obs;
  RxInt totalCardsAdd2 = 1.obs;

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
    }
    imageError.value = false;
    return true;
  }

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

  //  CUSTOM CUSTOM CALENDAR OVERLAY LOGIC

  final LayerLink dobLink = LayerLink();
  final LayerLink dobLink2 = LayerLink();
  final LayerLink expiryLink = LayerLink();
  final LayerLink expiryLink2 = LayerLink();
  final TextEditingController selectedYearCarController = TextEditingController();
  var selectedCarYear = "".obs;
  final GlobalKey carYearKey = GlobalKey();
  var isDateDropOpen = false.obs;

  OverlayEntry? calendarOverlay;

  void toggleCalendar(BuildContext context, LayerLink link, TextEditingController targetController, {bool isYearOnly = false}) {
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

  OverlayEntry _createCalendarOverlay(BuildContext context, LayerLink link, TextEditingController targetController) {
    final screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 600;
    double overlayWidth = screenSize.width < 400 ? screenSize.width * 0.9 : 300;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeCalendar,
              behavior: HitTestBehavior.opaque,
              child: Container(color: AppColors.fieldsBackground.withOpacity(0.05)),
            ),
          ),
          isMobile
              ? Center(
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(width: overlayWidth, child: _buildCalendarContent(overlayWidth, targetController)),
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
              child: SizedBox(width: overlayWidth, child: _buildCalendarContent(overlayWidth, targetController)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarContent(double width, TextEditingController targetController) {
    return CustomCalendarCustomer(
      width: width,
      onCancel: () => removeCalendar(),
      onDateSelected: (date) {
        targetController.text = "${date.day}/${date.month}/${date.year}";
        removeCalendar();
      },
    );
  }

  //  COUNTRY ENGINE VARIABLES & VALIDATION

  var dropdownErrors = <String, String>{}.obs;
  var countryList = <Country>[].obs;
  var isLoadingCountries = true.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
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
      imageError.value = true;
      Get.snackbar("Photo Required", "Please upload customer profile photo", backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    }
    bool isLicenseValid = licenseNameController.text.trim().isNotEmpty;
    if (!isLicenseValid) {
      Get.snackbar("License Required", "License Name is required", backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    }
    return isFormValid && hasProfileImg && isLicenseValid;
  }

  //  STEP TWO CUSTOMER (CREDENTIALS)

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;
  var isCredentialsGenerated = false.obs;
  var userNameError = RxnString();
  var passwordError = RxnString();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  bool validateFields() {
    bool isValid = true;
    if (userNameController.text.trim().isEmpty) {
      userNameError.value = "User name is required";
      isValid = false;
    } else {
      userNameError.value = null;
    }
    String pwd = passwordController.text;
    bool hasCapital = pwd.contains(RegExp(r'[A-Z]'));
    bool hasSpecial = pwd.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = pwd.length >= 8;

    if (pwd.isEmpty) {
      passwordError.value = "Password is required";
      isValid = false;
    } else if (!hasCapital || !hasSpecial || !hasMinLength) {
      passwordError.value = "The password must contain special character, capital letter, and length must be at least 8 characters";
      isValid = false;
    } else {
      passwordError.value = null;
    }
    return isValid;
  }

  Future<void> saveCustomer(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
  }

  RxString selectedCode = "+61".obs;
  RxString selectedFlag = "🇦🇺".obs;
  var selectedCountryName = "Australia".obs;
  RxString selectedCode2 = "+61".obs;
  RxString selectedFlag2 = "🇦🇺".obs;
  var selectedCountryName2 = "Australia".obs;

  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final searchController = TextEditingController();
  final searchController2 = TextEditingController();

  //  EDIT CUSTOMER SCREEN CONTROLLERS

  Rxn<ImageHolder> profileImage2 = Rxn<ImageHolder>();
  final phoneController2 = TextEditingController();
  final givenNameController2 = TextEditingController();
  final surnameController2 = TextEditingController();
  final dobController2 = TextEditingController();
  final contactController2 = TextEditingController();
  final emailController2 = TextEditingController();
  final addressController2 = TextEditingController();
  final noteController2 = TextEditingController();

  final licenseNameController2 = TextEditingController();
  final licenseNumberController2 = TextEditingController();
  final licenseCardNumberController2 = TextEditingController();

  RxList<Rx<DocumentHolder?>> selectedDocuments2 = <Rx<DocumentHolder?>>[].obs;
  RxList<TextEditingController> documentNameControllers2 = <TextEditingController>[].obs;
  final int maxDocuments2 = 6;
  RxInt totalCards = 1.obs;
  var selectedCardIndex2 = 0.obs;

  final ccNumberController2 = TextEditingController();
  final ccHolderController2 = TextEditingController();
  final ccExpiryController2 = TextEditingController();
  final ccCvcController2 = TextEditingController();
  final ccCountryController2 = TextEditingController();

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
    if (value == null || value.trim().isEmpty) return "$fieldName is required";
    return null;
  }

  String? validateEmail2(String? value) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
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

  void updateCustomerData(BuildContext context) {
    if (editCustomerFormKey.currentState!.validate() && validateProfileImage2()) {
      debugPrint("Form Validated! Updating...");
    }
  }

  void addNewCard() {
    if (totalCards.value < 5) {
      totalCards.value++;
      selectedCardIndex2.value = totalCards.value - 1;
    } else {
      Get.snackbar("Limit Reached", "You can only add up to 5 cards.");
    }
  }

  //  HEADER & SORTING LOGIC

  RxBool isSearchCategoryOpen = false.obs;
  RxString selectedSearchType = "Customer Name".obs;
  var sortColumn = "".obs;
  var sortOrder = 0.obs;

  void toggleSearchCategory() {
    isSearchCategoryOpen.value = !isSearchCategoryOpen.value;
    if (isSearchCategoryOpen.value) {
      isFilterOpen.value = false;
    }
  }

  void toggleSort(String columnName) {
    if (sortColumn.value == columnName) {
      sortOrder.value = (sortOrder.value + 1) % 3;
      if (sortOrder.value == 0) sortColumn.value = "";
    } else {
      sortColumn.value = columnName;
      sortOrder.value = 1;
    }
  }

  //  MEMORY DISPOSAL ENGINE

  @override
  void onClose() {
    // Add Screen Controllers Clear
    givenNameController.dispose();
    surnameController.dispose();
    dobController.dispose();
    contactController.dispose();
    userNameController.dispose();
    passwordController.dispose();
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
    phoneController.dispose();
    ageController.dispose();
    searchController.dispose();
    searchController2.dispose();

    for (var ctrl in documentNameControllers) {
      ctrl.dispose();
    }

    // Edit Screen Controllers Clear
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
    phoneController2.dispose();

    for (var ctrl in documentNameControllers2) {
      ctrl.dispose();
    }

    calendarOverlay?.dispose();
    super.onClose();
  }
}