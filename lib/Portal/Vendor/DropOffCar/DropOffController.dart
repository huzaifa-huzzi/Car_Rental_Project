import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/CalendarDropOffManagingScreen.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/AddDropOff/Widget/ResponsiveDropOffTimer.dart';
import 'package:car_rental_project/Resources/Colors.dart' show AppColors;
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:signature/signature.dart';

class DamagePoint {
  final double dx;
  final double dy;
  final int typeId;
  final Color color;

  DamagePoint({required this.dx, required this.dy, required this.typeId, required this.color});
}

class ImageHolder {
  final String? path;
  final Uint8List? bytes;
  final String? name;

  ImageHolder({this.path, this.bytes, this.name});
}


class DropOffController extends GetxController{
  var isSearchCategoryOpen = false.obs;
  var selectedSearchType = "Customer Name".obs;

       /// Pagination Bar
  final RxInt currentPage3 = 1.obs;
  final RxInt pageSize3 = 10.obs;
  final RxInt selectedView3 = 0.obs;

  RxList<Map<String, dynamic>> carList3 = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    generateDummyData();
    odoControllerStepTwo.text = "12457678";
    fuelLevelControllerStepTwo.text = "Full (100%)";
    exteriorCleanlinessControllerStepTwo.text = "Excellent";
    interiorCleanlinessControllerStepTwo.text = "Excellent";

    bondAmountControllerStepTwo.text = "2600 \$";
    paidBondControllerStepTwo.text = "600 \$";
    dueBondAmountControllerStepTwo.text = "2000 \$";

    odoControllerStepTwoAdd.text = "12457678";
    fuelLevelControllerStepTwoAdd.text = "Full (100%)";
    exteriorCleanlinessControllerStepTwoAdd.text = "Excellent";
    interiorCleanlinessControllerStepTwoAdd.text = "Excellent";

    bondAmountControllerStepTwoAdd.text = "2600 \$";
    paidBondControllerStepTwoAdd.text = "600 \$";
    dueBondAmountControllerStepTwoAdd.text = "2000 \$";

     // DropOff Signatures
    dropOffOwnerSigPadController.addListener(() {
      if (dropOffOwnerSigPadController.isNotEmpty) {
        isDropOffOwnerDrawingActive.value = true;
      }
    });

    dropOffHirerSigPadController.addListener(() {
      if (dropOffHirerSigPadController.isNotEmpty) {
        isDropOffHirerDrawingActive.value = true;
      }
    });

    damagePoints2.assignAll([
      DamagePoint(dx: 0.2, dy: 0.3, typeId: 1, color: AppColors.oneBackground),
      DamagePoint(dx: 0.5, dy: 0.5, typeId: 2, color: AppColors.twoBackground),
      DamagePoint(dx: 0.8, dy: 0.7, typeId: 3, color: AppColors.threeBackground),
    ]);
    termsController.addListener(() => update());
  }

  int get totalPages {
    if (carList3.isEmpty) return 1;
    return (carList3.length / pageSize3.value).ceil();
  }

  List<Map<String, dynamic>> get displayedCarList {
    int start = (currentPage3.value - 1) * pageSize3.value;
    int end = start + pageSize3.value;

    if (start >= carList3.length) return [];
    return carList3.sublist(
        start, end > carList3.length ? carList3.length : end);
  }

  void goToPreviousPage() {
    if (currentPage3.value > 1) currentPage3.value--;
  }

  void goToNextPage() {
    if (currentPage3.value < totalPages) currentPage3.value++;
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage3.value = page;
  }

  void setPageSize(int newSize) {
    pageSize3.value = newSize;
    currentPage3.value = 1;
  }

  /// Table View Screen Data
  var hoveredRowIndex = (-1).obs;

  void generateDummyData() {
    carList3.clear();
    for (int i = 0; i < 25; i++) {
      carList3.add({
        "customerName": "Jack Morrison",
        "customerEmail": "jackMorrison@rhyta.com",
        "vin": "JTNBA3HK003001234",
        "reg": "1234567890",
        "carRent": "Toyota Corolla (2017)",
        "damage": i % 4 == 0,
        "dropoffDate": "Aug 2, 2026",
        "status": "Completed",
      });
    }
  }
  /// Detail View Screen
  var isDamageInspectionOpen = false.obs;
  final weeklyRentControllerStepTwo = TextEditingController();
  final rentBondAmountControllerStepTwo  = TextEditingController();
  final rentDueAmountControllerStepTwo  = TextEditingController();


  final bondAmountControllerStepTwo  = TextEditingController();
  final paidBondControllerStepTwo  = TextEditingController();
  final dueBondAmountControllerStepTwo  = TextEditingController();
  final dueBondReturnedControllerStepTwo  = TextEditingController();

  final odoControllerStepTwo  = TextEditingController();
  final fuelLevelControllerStepTwo  = TextEditingController();
  final interiorCleanlinessControllerStepTwo  = TextEditingController();
  final exteriorCleanlinessControllerStepTwo  = TextEditingController();
  final additionalCommentsControllerStepTwo  = TextEditingController();
  final additionalCommentsControllerDropOff  = TextEditingController();
  final odoControllerDropOff  = TextEditingController();
  final fuelLevelControllerDropOff  = TextEditingController();
  final interiorCleanlinessControllerDropOff  = TextEditingController();
  final exteriorCleanlinessControllerDropOff  = TextEditingController();


  var isPersonalUseStepTwo  = true.obs;
  var isManualPaymentStepTwo  = true.obs;
  final startDateControllerStepTwo  = TextEditingController();
  final startTimeControllerStepTwo  = TextEditingController();
  final endDateControllerStepTwo  = TextEditingController();
  final endTimeControllerStepTwo  = TextEditingController();
  final ownerNameController = TextEditingController(text: "Softsnip");
  final hirerNameController = TextEditingController(text: "Softsnip");

  var selectedDamageType2 = 1.obs;
  var damagePoints2 = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes2 = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];


  /// selected tab index
  final RxInt selectedIndex = 0.obs;
  final isTermsAgreed2 = false.obs;

  /// tabs list
  final List<String> tabs = [
    "Customer and Contract",
    "Vehicle Condition and Photos",
    "Term & Condition and Sign",
  ];

  void changeTab(int index) {
    selectedIndex.value = index;
  }


  final String pickupFrontImg = ImageString.frontPickImage;
  final String pickupBackImg = ImageString.backPickImage;
  final String pickupLeftImg = ImageString.leftPickImage;
  final String pickupRightImg = ImageString.rightPickImage;

  // Additional Images
  final List<String> pickupAdditionalImagesDropOff = [
    ImageString.frontPickImage,
    ImageString.backPickImage,
    ImageString.leftPickImage,
    ImageString.rightPickImage,
    ImageString.frontPickImage,
  ];




  /// Add Dropoff Car
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = "".obs;
  var isDamageInspectionOpen2 = false.obs;
  final RxString selectedSearchType2 = "Customer Name".obs;
  final RxInt resultCount = 3.obs;
  final RxBool isLoading = false.obs;
  final ScrollController horizontalScrollController = ScrollController();

  void onSearchChanged(String val) {
    searchQuery.value = val;
    if (val.isNotEmpty) {
      fetchResults();
    }
  }
  Future<void> fetchResults() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    resultCount.value = 3;
    isLoading.value = false;
  }

  final LayerLink dropOffDateLink = LayerLink();
  final LayerLink dropOffTimeLink = LayerLink();
  OverlayEntry? timeOverlay;


  OverlayEntry? calendarOverlay;

  void toggleCalendar(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      double width,
      ) {
    removeCalendar();

    calendarOverlay =
        _createCalendarOverlay(context, link, targetController, width);

    Overlay.of(context).insert(calendarOverlay!);
  }

  void removeCalendar() {
    calendarOverlay?.remove();
    calendarOverlay = null;
  }


  OverlayEntry _createCalendarOverlay(
      BuildContext context,
      LayerLink link,
      TextEditingController targetController,
      double fieldWidth,
      ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double popupWidth = screenWidth < 500 ? 260 : 280;
    bool isMobile = screenWidth < 600;

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
            targetAnchor: isMobile ? Alignment.bottomRight : Alignment.bottomLeft,
            followerAnchor: isMobile ? Alignment.topRight : Alignment.topLeft,
            offset: const Offset(0, 8),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              child: CustomCalendarDropOff(
                width: popupWidth,
                onCancel: removeCalendar,
                onDateSelected: (date) {
                  targetController.text = "${date.day}/${date.month}/${date.year}";
                  removeCalendar();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  var selectedHour = 11.obs;
  var selectedMinute = 30.obs;
  var isAM = true.obs;

  void updateHour(int hour) => selectedHour.value = hour;
  void updateMinute(int min) => selectedMinute.value = min;
  void togglePeriod(bool am) => isAM.value = am;


  String get formattedTime {
    String period = isAM.value ? "am" : "pm";
    return "${selectedHour.value}:${selectedMinute.value.toString().padLeft(2, '0')}$period";
  }

  void reset() {
    selectedHour.value = 11;
    selectedMinute.value = 30;
    isAM.value = true;
  }


  void toggleTimePicker(BuildContext context, LayerLink link, TextEditingController controller, double fieldWidth) {
    if (timeOverlay != null) {
      timeOverlay?.remove();
      timeOverlay = null;
      return;
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double overlayWidth = screenWidth < 350 ? screenWidth * 0.85 : 280;

    timeOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                timeOverlay?.remove();
                timeOverlay = null;
              },
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            offset: Offset(screenWidth < 350 ? -(overlayWidth * 0.2) : 0, 8),
            child: Material(
              elevation: 15,
              color: Colors.transparent,
              child: ResponsiveDropOffTimer(
                width: overlayWidth,
                onCancel: () {
                  timeOverlay?.remove();
                  timeOverlay = null;
                },
                onTimeSelected: (val) {
                  controller.text = val;
                  timeOverlay?.remove();
                  timeOverlay = null;
                },
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(timeOverlay!);
  }

  void removePopups() {
    calendarOverlay?.remove();
    calendarOverlay = null;
    timeOverlay?.remove();
    timeOverlay = null;
  }

  var isDamageInspectionOpenAdd = false.obs;
  final weeklyRentControllerStepTwoAdd = TextEditingController();
  final rentBondAmountControllerStepTwoAdd  = TextEditingController();
  final rentDueAmountControllerStepTwoAdd  = TextEditingController();


  final bondAmountControllerStepTwoAdd  = TextEditingController();
  final paidBondControllerStepTwoAdd  = TextEditingController();
  final dueBondAmountControllerStepTwoAdd  = TextEditingController();
  final dueBondReturnedControllerStepTwoAdd  = TextEditingController();

  final odoControllerStepTwoAdd  = TextEditingController();
  final fuelLevelControllerStepTwoAdd  = TextEditingController();
  final interiorCleanlinessControllerStepTwoAdd  = TextEditingController();
  final exteriorCleanlinessControllerStepTwoAdd  = TextEditingController();
  final additionalCommentsControllerStepTwoAdd  = TextEditingController();
  final additionalCommentsControllerDropOffAdd  = TextEditingController();
  final odoControllerDropOffAdd  = TextEditingController();
  final fuelLevelControllerDropOffAdd  = TextEditingController();
  final interiorCleanlinessControllerDropOffAdd  = TextEditingController();
  final exteriorCleanlinessControllerDropOffAdd  = TextEditingController();


  var isPersonalUseStepTwoAdd  = true.obs;
  var isManualPaymentStepTwoAdd  = true.obs;
  final startDateControllerStepTwoAdd  = TextEditingController();
  final startTimeControllerStepTwoAdd  = TextEditingController();
  final endDateControllerStepTwoAdd  = TextEditingController();
  final endTimeControllerStepTwoAdd  = TextEditingController();
  final ownerNameControllerAdd = TextEditingController(text: "Softsnip");
  final hirerNameControllerAdd = TextEditingController(text: "Softsnip");
  final dropOffFormKey = GlobalKey<FormState>();

  var dropOffError = "".obs;

  bool validateDropOffStep1() {
    dropOffError.value = "";

    if (endDateControllerStepTwoAdd.text.trim().isEmpty ||
        endTimeControllerStepTwoAdd.text.trim().isEmpty) {
      showError("Please select Drop-off Date and Time");
      return false;
    }
    if (dueBondReturnedControllerStepTwoAdd.text.trim().isEmpty) {
      showError("Bond Returned amount is required");
      return false;
    }
    return true;
  }

  bool validateDropOffStep2() {
    dropOffError.value = "";
    if (odoControllerDropOffAdd.text.trim().isEmpty) {
      showError("Odometer reading is required");
      return false;
    }

    if (fuelLevelControllerDropOffAdd.text.trim().isEmpty) {
      showError("Fuel level is required");
      return false;
    }

    return true;
  }

  void showError(String msg) {
    dropOffError.value = msg;
    Get.snackbar(
      "Required Info",
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }



  var selectedDamageType3 = 1.obs;
  var damagePoints3 = <DamagePoint>[].obs;


  final List<Map<String, dynamic>> damageTypes3 = [
    {'id': 1, 'label': 'Scratch', 'color': AppColors.oneBackground},
    {'id': 2, 'label': 'Dent', 'color': AppColors.twoBackground},
    {'id': 3, 'label': 'Chip', 'color': AppColors.threeBackground},
    {'id': 4, 'label': 'Scuff', 'color': AppColors.fourBackground},
    {'id': 5, 'label': 'Other', 'color': AppColors.fiveBackground},
  ];


  var frontImage = Rxn<ImageHolder>();
  var backImage = Rxn<ImageHolder>();
  var leftImage = Rxn<ImageHolder>();
  var rightImage = Rxn<ImageHolder>();
  final List<String> pickupAdditionalImages = [
    ImageString.frontPickImage,
    ImageString.backPickImage,
    ImageString.leftPickImage,
    ImageString.rightPickImage,
  ];

  var additionalImages = <ImageHolder>[].obs;
  var hoverStates = <String, bool>{}.obs;

  Future<void> pickImageNew(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: type == 'additional',
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      withData: true,
    );

    if (result != null) {
      if (type == 'additional') {
        for (var file in result.files) {
          if (additionalImages.length < 6) {
            additionalImages.add(ImageHolder(bytes: file.bytes, name: file.name, path: kIsWeb ? null : file.path));
          }
        }
      } else {
        var file = result.files.first;
        var holder = ImageHolder(bytes: file.bytes, name: file.name, path: kIsWeb ? null : file.path);

        if (type == 'front') {
          frontImage.value = holder;
        } else if (type == 'back') backImage.value = holder;
        else if (type == 'left') leftImage.value = holder;
        else if (type == 'right') rightImage.value = holder;
      }
    }
  }
  void removeImageNew(String type, {int? index}) {
    if (type == 'additional' && index != null) {
      additionalImages.removeAt(index);
    } else {
      if (type == 'front') {
        frontImage.value = null;
      } else if (type == 'back') backImage.value = null;
      else if (type == 'left') leftImage.value = null;
      else if (type == 'right') rightImage.value = null;
    }
  }
  var isStep2Submitted = false.obs;

  bool validateStepTwoPhotos() {
    if (frontImage.value == null ||
        backImage.value == null ||
        leftImage.value == null ||
        rightImage.value == null) {

      showError2("Mandatory images are missing. Please upload Front, Back, Left, and Right views.");
      return false;
    }
    return true;
  }

  bool validateDamageInspection() {
    if (isDamageInspectionOpen2.value) {
      if (damagePoints3.isEmpty) {
        showError2("Please mark the damage points on the car diagram or select 'No'.");
        return false;
      }
    }
    return true;
  }

  void showError2(String msg) {
    dropOffError.value = msg;
    Get.snackbar(
      "Required Info",
      msg,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryColor,
      colorText: Colors.white,
      icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
    );
  }


  /// Step Three Widget
  final isTermsAgreed = false.obs;
  var isOwnerSigned = true.obs;

  final dropOffOwnerNameFieldController = TextEditingController();
  var isDropOffOwnerDrawingActive = false.obs;
  var isDropOffOwnerSignatureConfirmed = false.obs;
  final dropOffOwnerSigPadController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );

  final dropOffHirerNameFieldController = TextEditingController();
  var isDropOffHirerDrawingActive = false.obs;
  var isDropOffHirerSignatureConfirmed = false.obs;
  final dropOffHirerSigPadController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black
  );


  RxBool get isDrawingStarted => isOwnerSigned.value
      ? isDropOffOwnerDrawingActive
      : isDropOffHirerDrawingActive;

  RxBool get isConfirmed => isOwnerSigned.value
      ? isDropOffOwnerSignatureConfirmed
      : isDropOffHirerSignatureConfirmed;

  TextEditingController get activeNameController => isOwnerSigned.value
      ? dropOffOwnerNameFieldController
      : dropOffHirerNameFieldController;

  SignatureController get activeSigController => isOwnerSigned.value
      ? dropOffOwnerSigPadController
      : dropOffHirerSigPadController;

  void clearSignature() {
    activeSigController.clear();
    isDrawingStarted.value = false;
    isConfirmed.value = false;
  }

  void confirmCurrentSignature() {
    isStep3Submitted.value = true;

    bool isNameValid = activeNameController.text.trim().isNotEmpty;
    bool isSigNotEmpty = activeSigController.isNotEmpty;

    if (isNameValid  && isSigNotEmpty) {
      isConfirmed.value = true;
      Get.snackbar("Success", "Signature confirmed!", backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      String error = "";
      if (!isNameValid) {
        error = "Name is required.";
      } else if (!isSigNotEmpty) error = "Please draw your signature.";

      Get.snackbar("Required", error, snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColors.primaryColor, colorText: Colors.white);
    }
  }

  final isStep3Submitted = false.obs;

  final dropOffOwnerEmailController = TextEditingController();
  final dropOffHirerEmailController = TextEditingController();

  TextEditingController get activeEmailController => isOwnerSigned.value
      ? dropOffOwnerEmailController
      : dropOffHirerEmailController;




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


  ///  DropOff T&C
  var DropOffSortColumn = "".obs;
  var DropOffSortOrder = 0.obs;

  void togglePickupSort(String columnName) {
    if (DropOffSortColumn.value == columnName) {
      DropOffSortOrder.value = (DropOffSortOrder.value + 1) % 3;
      if (DropOffSortOrder.value == 0) DropOffSortColumn.value = "";
    } else {
      DropOffSortColumn.value = columnName;
      DropOffSortOrder.value = 1;
    }
  }

  var termsList = <Map<String, String>>[
    {'version': 'V5', 'date': '5/03/2026', 'time': '12:30pm', 'status': 'Active'},
    {'version': 'V4', 'date': '5/03/2026', 'time': '9:30am', 'status': 'Inactive'},
    {'version': 'V3', 'date': '4/03/2026', 'time': '5:30pm', 'status': 'Inactive'},
    {'version': 'V2', 'date': '4/03/2026', 'time': '4:30pm', 'status': 'Inactive'},
    {'version': 'V1', 'date': '3/03/2026', 'time': '4:30pm', 'status': 'Inactive'},
  ].obs;

  final Map<String, LayerLink> links = {};

  var activeLoadingIndex = (-1).obs;

  LayerLink getLayerLink(String version) {
    return links.putIfAbsent(version, () => LayerLink());
  }

  void activateVersion(int index) {
    activeLoadingIndex.value = index;

    Future.delayed(const Duration(seconds: 3), () {
      for (var item in termsList) {
        item['status'] = 'Inactive';
      }
      termsList[index]['status'] = 'Active';
      termsList.refresh();
      activeLoadingIndex.value = -1;
    });
  }

  /// Add DropOff T&C
  final quill.QuillController termsController = quill.QuillController.basic();
  var selectedSize = ''.obs;
  var isSizeOpen = false.obs;
  final LayerLink saveButtonLink = LayerLink();

  void toggleStyle(quill.Attribute attribute) {
    final currentAttributes = termsController.getSelectionStyle().attributes;
    if (attribute.key == quill.Attribute.header.key) {
      bool isSameHeader = currentAttributes.containsKey(attribute.key) &&
          currentAttributes[attribute.key]?.value == attribute.value;

      if (isSameHeader) {
        termsController.formatSelection(quill.Attribute.clone(quill.Attribute.header, null));
      } else {
        termsController.formatSelection(attribute);
      }
    } else {
      bool isActive = currentAttributes.containsKey(attribute.key);
      termsController.formatSelection(isActive ? quill.Attribute.clone(attribute, null) : attribute);
    }
    update();
  }

  bool isStyleActive(quill.Attribute attr) {
    final attrs = termsController.getSelectionStyle().attributes;
    if (attrs.containsKey(attr.key)) {
      return attrs[attr.key]?.value == attr.value;
    }
    return false;
  }

  void changeFontSize(String size) {
    selectedSize.value = size;
    termsController.formatSelection(quill.Attribute.fromKeyValue('size', size));
    update();
  }

  @override
  void onClose() {
    termsController.dispose();
     weeklyRentControllerStepTwo.dispose();
     rentBondAmountControllerStepTwo.dispose();
     rentDueAmountControllerStepTwo.dispose();

    bondAmountControllerStepTwo.dispose();
    paidBondControllerStepTwo.dispose();
     dueBondAmountControllerStepTwo.dispose();
     dueBondReturnedControllerStepTwo.dispose();

     odoControllerStepTwo.dispose();
     fuelLevelControllerStepTwo.dispose();
     interiorCleanlinessControllerStepTwo.dispose();
     exteriorCleanlinessControllerStepTwo.dispose();
     additionalCommentsControllerStepTwo.dispose();
     odoControllerDropOff.dispose();
     fuelLevelControllerDropOff.dispose();
     interiorCleanlinessControllerDropOff.dispose();
     exteriorCleanlinessControllerDropOff.dispose();

     startDateControllerStepTwo.dispose();
     startTimeControllerStepTwo.dispose();
     endDateControllerStepTwo.dispose();
     endTimeControllerStepTwo.dispose();

     weeklyRentControllerStepTwoAdd.dispose();
     rentBondAmountControllerStepTwoAdd.dispose();
     rentDueAmountControllerStepTwoAdd.dispose();

     bondAmountControllerStepTwoAdd.dispose();
     paidBondControllerStepTwoAdd.dispose();
     dueBondAmountControllerStepTwoAdd.dispose();
     dueBondReturnedControllerStepTwoAdd.dispose();

     odoControllerStepTwoAdd.dispose();
     fuelLevelControllerStepTwoAdd.dispose();
     interiorCleanlinessControllerStepTwoAdd.dispose();
     exteriorCleanlinessControllerStepTwoAdd.dispose();
     additionalCommentsControllerStepTwoAdd.dispose();
     odoControllerDropOffAdd.dispose();
     fuelLevelControllerDropOffAdd.dispose();
     interiorCleanlinessControllerDropOffAdd.dispose();
     exteriorCleanlinessControllerDropOffAdd.dispose();

     startDateControllerStepTwoAdd.dispose();
     startTimeControllerStepTwoAdd.dispose();
     endDateControllerStepTwoAdd.dispose();
     endTimeControllerStepTwoAdd.dispose();


     searchController.dispose();
     horizontalScrollController.dispose();

    super.onClose();
  }





}