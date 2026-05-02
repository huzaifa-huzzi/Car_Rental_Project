import 'dart:io';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/AlertDialogs.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/customPrimaryButton.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Editing%20Car/Widgets/customTextField.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';


class EditCarWidget extends StatelessWidget {
  EditCarWidget({super.key});

  final CarInventoryController controller = Get.find<CarInventoryController>();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);

    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(AppSizes.padding(context)),
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Image.asset(
                      IconString.editIcon2,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TextString.addEditCarScreenTitle,
                          style: TTextTheme.h7Style(context),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          TextString.addEditCarDescription,
                          style: TTextTheme.titleThree(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// EDIT BUTTON
                  CustomPrimaryButton(
                    text: MediaQuery.of(context).size.width < 900 ? "" : "Edit",
                    iconPath: IconString.editIcon,
                    width: MediaQuery.of(context).size.width < 900 ? 40 : 110,
                    height: 38,
                    textColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    onTap: () => print("Edit Tapped"),
                  ),

                  const SizedBox(width: 8),

                  /// DELETE BUTTON
                  CustomPrimaryButton(
                    text: MediaQuery.of(context).size.width < 900 ? "" : "Delete",
                    iconPath: IconString.deleteIcon,
                    iconColor: AppColors.secondTextColor,
                    width: MediaQuery.of(context).size.width < 900 ? 40 : 110,
                    height: 38,
                    textColor: AppColors.secondTextColor,
                    borderColor: AppColors.sideBoxesColor,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => ResponsiveDeleteDialog(
                          onCancel: () {
                            context.pop();
                          },
                          onConfirm: () {
                            context.pop();
                          },
                        ),
                      );

                    },
                  ),
                ],
              ),
              SizedBox(height: AppSizes.verticalPadding(context) / 2),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
              SizedBox(height: AppSizes.verticalPadding(context)),

              /// SECTION 1: CAR IDENTIFICATION
              _buildSectionTitle(context, "Car Identification"),
              const SizedBox(height: 15),
              _buildResponsiveGrid(context, [
                _buildDropdown(context, "Car Make", controller.getFilteredItems2('make2'), controller.selectedBrand2, id: 'make2'),

                _buildDropdown(context, "Car Model", controller.getFilteredItems2('model2'), controller.selectedModel2, id: 'model2'),
                _buildYearField(
                  context,
                  "Car Year",
                  controller.selectedYear2,
                  id: "year2",
                ),
                _buildTextField(context, "Car Registration Number", controller.reg2Controller, hint: "ABC-12345"),
                _buildTextField(context, "VIN Number", controller.vin2Controller, hint: "17-digit VIN number"),
              ]),

              const SizedBox(height: 25),
              const Divider(thickness: 0.5),

              /// SECTION 2: CAR SPECIFICATION
              const SizedBox(height: 25),
              _buildSectionTitle(context, "Car Specification"),
              const SizedBox(height: 15),
              _buildResponsiveGrid(context, [
                _buildDropdown(context, "Car Body Type", controller.getFilteredItems2('body2'), controller.selectedBodyType2, id: 'body2'),
                _buildDropdown(context, "Car Transmission", controller.getFilteredItems2('trans2'), controller.selectedTransmission2, id: 'trans2'),
                _buildDropdown(context, "Car Seats", controller.getFilteredItems2('seats2'), controller.selectedSeats2, id: 'seats2'),
                _buildDropdown(context, "Car Engine Size", controller.getFilteredItems2('engine2'), controller.selectedEngine2, id: 'engine2'),
                _buildDropdown(context, "Car Color", controller.getFilteredItems2('color2'), controller.selectedColor2, id: 'color2'),

                _buildDropdown(context, "Car Fuel Type", controller.getFilteredItems2('fuel2'), controller.selectedFuel2, id: 'fuel2'),

                _buildTextField(context, "Car Value", controller.value2Controller, prefix: "\$ ", hint: "30,000"),
                _buildTextField(context, "Weekly Rent (AUD)", controller.weekly2RentController, prefix: "\$ ", hint: "120"),

                _buildStatusDropdown(context, "Status", controller.getFilteredItems2('status2'), controller.selectedStatus2, id: 'status2'),
              ]),
              SizedBox(height: AppSizes.verticalPadding(context)),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
              SizedBox(height: AppSizes.verticalPadding(context)),
              /// IMAGE UPLOAD
              Text("Upload Car Images", style: TTextTheme.btnSix(context)),
              SizedBox(height: AppSizes.verticalPadding(context) * 0.5),
              _imageBox(context),

              SizedBox(height: AppSizes.verticalPadding(context)),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              /// DESCRIPTION
              SizedBox(height: AppSizes.verticalPadding(context)),
              Text(TextString.addEditDescriptionTitle, style: TTextTheme.btnSix(context)),
              SizedBox(height: AppSizes.verticalPadding(context) * 0.5),

              Obx(() {
                bool hasError = controller.textFieldErrors.containsKey('Description');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppSizes.padding(context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                        color: AppColors.secondaryColor,
                        border: Border.all(color: hasError ? AppColors.primaryColor : Colors.transparent, width: 1.5),
                      ),
                      child: TextField(
                        controller: controller.description2Controller,
                        onChanged: (v) => controller.textFieldErrors.remove('Description'),
                        cursorColor: AppColors.blackColor,
                        maxLines: 6,
                        style: TTextTheme.titleFour(context),
                        decoration: InputDecoration(
                          hintText: TextString.addEditDescriptionTextFieldText,
                          hintStyle: TTextTheme.pOne(context),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (hasError)
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 5),
                        child: Text("Description is required", style: TTextTheme.ErrorStyle(context)),
                      ),
                  ],
                );
              }),

              SizedBox(height: AppSizes.verticalPadding(context)),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              _documentsSection(context),

              SizedBox(height: AppSizes.verticalPadding(context)),
              _buttonSection(context, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- Extra Widgets  --------///
  //Dropdown widget
  Widget _buildDropdown(
      BuildContext context,
      String label,
      List<String> items,
      RxString selected, {
        required String id,
      }) {
    return Obx(() {
      bool isOpen2 = controller.openedDropdown2.value == id;
      bool hasError = controller.dropdownErrors.containsKey(id);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                maxHeight: 300,
              ),
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              elevation: 8,
              tooltip: '',
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (value) {
                selected.value = value;
                controller.openedDropdown2.value = "";
                controller.dropdownErrors.remove(id);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: hasError ? AppColors.primaryColor : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selected.value.isEmpty ? "Select $label" : selected.value,
                        style: selected.value.isEmpty
                            ? TTextTheme.pOne(context).copyWith(color: Colors.grey)
                            : TTextTheme.dropdowninsideText(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Image.asset(
                      isOpen2 ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                      height: 18,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) {
                return items.map((value) {
                  bool isSelected = selected.value == value;

                  return PopupMenuItem<String>(
                    value: value,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? const Center(
                              child: Icon(Icons.done, color: Colors.white, size: 14),
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              value,
                              style: TTextTheme.medium14(context).copyWith(
                                color: isSelected ? AppColors.primaryColor : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList();
              },
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                controller.dropdownErrors[id] ?? "Required",
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }


  Widget _buildYearField(
      BuildContext context,
      String label,
      RxString selected,
      {
        required String id,
      }) {
    return Obx(() {
      bool isEditScreen = id.endsWith("2");
      List<String> items = isEditScreen
          ? controller.getFilteredItems2(id)
          : controller.getFilteredItems(id);

      RxString searchText = isEditScreen
          ? controller.searchCarText2
          : controller.searchCarText;

      bool isOpen = controller.openedDropdown3.value == id;
      String errorMsg = controller.dropdownErrors[id] ?? controller.dropdownErrors2[id] ?? "";
      bool hasError = errorMsg.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                maxHeight: 400,
              ),
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              onOpened: () => controller.openedDropdown3.value = id,
              onCanceled: () {
                controller.openedDropdown3.value = "";
                searchText.value = "";
              },
              onSelected: (val) {
                if (val != "SEARCH_FIELD") {
                  selected.value = val;
                  if (controller.dropdownErrors.containsKey(id)) controller.dropdownErrors[id] = "";
                  if (controller.dropdownErrors2.containsKey(id)) controller.dropdownErrors2[id] = "";

                  controller.openedDropdown3.value = "";
                  searchText.value = "";
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: hasError ? AppColors.primaryColor : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selected.value.isEmpty ? "Search $label..." : selected.value,
                        style: TTextTheme.pOne(context).copyWith(
                          color: selected.value.isEmpty ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                    Image.asset(
                      isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                      height: 18,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    enabled: false,
                    value: "SEARCH_FIELD",
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                      ),
                      child: TextField(
                        cursorColor: AppColors.blackColor,
                        onChanged: (val) => searchText.value = val,
                        style: TTextTheme.titleinputTextField(context),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TTextTheme.bodyRegular14Search(context),
                          prefixIcon: Icon(Icons.search, color: AppColors.primaryColor, size: 18),
                          filled: true,
                          fillColor: AppColors.backgroundOfScreenColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        ),
                      ),
                    ),
                  ),
                  ...items.map((item) {
                    bool isSelected = selected.value == item;
                    return PopupMenuItem<String>(
                      value: item,
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            child: isSelected
                                ? const Center(child: Icon(Icons.done, color: Colors.white, size: 14))
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(item, style: TTextTheme.medium14(context)),
                        ],
                      ),
                    );
                  }),
                ];
              },
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(errorMsg, style: TTextTheme.ErrorStyle(context)),
            ),
        ],
      );
    });
  }

   // TextField Widget
  Widget _buildTextField(BuildContext context, String label,
      TextEditingController textController, {String? prefix, String? hint}) {

    return CustomTextField(
      parentContext: context,
      label: label,
      textController: textController,
      invController: Get.find<CarInventoryController>(),
      prefix: prefix,
      hint: hint,
    );
  }

  // upload image Widget
  Widget _imageBox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.pickImage2();
        controller.imageError.value = "";
      },
      child: Obx(() {
        bool hasError = controller.imageError.value.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(AppSizes.borderRadius(context)),
              dashPattern: const [8, 6],
              color: hasError ? AppColors.primaryColor : AppColors.tertiaryTextColor,
              strokeWidth: hasError ? 1.5 : 1,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 180),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                ),
                child: controller.selectedImages2.isEmpty
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.iconsBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(IconString.cameraIcon, color: AppColors.primaryColor, width: 18),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.iconsBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(IconString.uploadIcon, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(TextString.uploadTitle, style: TTextTheme.btnOne(context)),
                    Text(TextString.uploadSubtitle, style: TTextTheme.documnetIsnideSmallText2(context)),
                  ],
                )
                    : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: controller.selectedImages2.asMap().entries.map((entry) {
                    int index = entry.key;
                    final imageHolder = entry.value;

                    ImageProvider imageProvider;
                    if (kIsWeb) {
                      imageProvider = (imageHolder.bytes != null)
                          ? MemoryImage(imageHolder.bytes!)
                          : const AssetImage("assets/placeholder.png") as ImageProvider;
                    } else {
                      imageProvider = (imageHolder.path != null)
                          ? FileImage(File(imageHolder.path!))
                          : const AssetImage("assets/placeholder.png") as ImageProvider;
                    }

                    return Stack(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryColor, width: 0.7),
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ],

                    );
                  }).toList(),
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  controller.imageError.value,
                  style: TTextTheme.ErrorStyle(context),
                ),
              ),
          ],
        );
      }),
    );
  }


  //  Section Title Widget
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: TTextTheme.titleSix(context));
  }

//  Responsive Grid Widget
  Widget _buildResponsiveGrid(BuildContext context, List<Widget> children) {
    return LayoutBuilder(builder: (context, constraints) {
      double spacing = AppSizes.padding(context);
      int columns = constraints.maxWidth > 600 ? 3 : 2;
      double itemWidth = (constraints.maxWidth - (spacing * (columns - 1))) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: 18,
        children: children.map((child) => SizedBox(width: itemWidth, child: child)).toList(),
      );
    });
  }

//  Responsive Status Dropdown
  Widget _buildStatusDropdown(BuildContext context, String label, List<String> items, RxString selected, {required String id}) {
    final List<String> statusItems = ["Available", "Unavailable"];

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      bool hasError = controller.dropdownErrors2.containsKey(id);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                maxHeight: 200,
              ),
              offset: const Offset(0, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              elevation: 8,
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (val) {
                selected.value = val;
                controller.openedDropdown2.value = "";
                controller.dropdownErrors2.remove(id);
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: hasError ? AppColors.primaryColor : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: _getStatusChip(selected.value.isEmpty ? "Available" : selected.value, context)
                        )
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                        isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                        height: 18
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) => statusItems.map((value) {
                bool isSelected = (selected.value.isEmpty && value == "Available") || selected.value == value;

                return PopupMenuItem<String>(
                  value: value,
                  padding: EdgeInsets.zero,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Center(child: Icon(Icons.done, color: Colors.white, size: 14))
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: _getStatusChip(value, context)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(
                "Status is required",
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }

// Status Chip Widget
  Widget _getStatusChip(String status, BuildContext context) {
    Color statusColor = Colors.transparent;
    Color textColor = Colors.black;
    String displayStatus = status.isEmpty ? "Available" : status;
    String checkStatus = displayStatus.toLowerCase();

    if (checkStatus == "available") {
      statusColor = AppColors.availableBackgroundColor;
      textColor = Colors.white;
    } else if (checkStatus == "maintenance") {
      statusColor = AppColors.maintenanceBackgroundColor;
      textColor = AppColors.textColor;
    } else if (checkStatus == "unavailable") {
      statusColor = AppColors.oneBackground;
      textColor = Colors.white;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: statusColor == Colors.transparent
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                displayStatus,
                style: TTextTheme.titleseven(context).copyWith(
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  DOCUMENT NAME FIELD Widget
  Widget _documentNameField(BuildContext context, int index, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.documentName, style: TTextTheme.titleTwo(context)),
        SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context)),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          ),
          child: TextField(
            cursorColor: AppColors.blackColor,
            style:  TTextTheme.insidetextfieldWrittenText(context),
            controller: controller,
            decoration: InputDecoration(
              hintText: TextString.documentSubtitle,
              border: InputBorder.none,
              hintStyle: TTextTheme.titleFour(context),
            ),
          ),
        ),
      ],
    );
  }


//  DOCUMENT BOX Widget
  Widget _documentBox(BuildContext context, int index, Rx<DocumentHolder?> selectedDoc) {

    bool isImageFile(String fileName) {
      final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      final lowerCaseName = fileName.toLowerCase();
      return imageExtensions.any((ext) => lowerCaseName.endsWith(ext));
    }
    return Obx(() {
      final docValue = selectedDoc.value;
      final bool isUploaded = docValue != null;
      final bool isImage = isUploaded && isImageFile(docValue.name);
      final String hintText = controller.defaultDocumentNames2[index];


      ImageProvider? imageProvider;
      if (isImage) {
        if (kIsWeb && docValue.bytes != null) {
          imageProvider = MemoryImage(docValue.bytes!);
        } else if (!kIsWeb && docValue.path != null) {
          imageProvider = FileImage(File(docValue.path!));
        }
      }

      return GestureDetector(
        onTap: isUploaded ? null : () => controller.pickDocument2(index),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(AppSizes.borderRadius(context)),
          dashPattern: [8, 6],
          color: isUploaded ? AppColors.primaryColor : AppColors.tertiaryTextColor,
          strokeWidth: isUploaded ? 2 : 1,
          child: Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isUploaded ? Colors.white : Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              image: isImage && imageProvider != null
                  ? DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: !isUploaded
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.iconsBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(IconString.uploadIcon, color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 10),
                      Text(hintText, style: TTextTheme.documnetIsnideSmallText(context)),
                      Text(TextString.uploadSubtitle, style:TTextTheme.documnetIsnideSmallText2(context)),
                    ],
                  )
                      : isImage
                      ? Container()
                      : Column(
                    //  DOCUMENT STATE (Non-Image)
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_drive_file, size: 40, color: AppColors.primaryColor),
                      SizedBox(height: 8),
                      Text(
                        docValue.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),

                if (isUploaded)
                  Positioned(
                    top: -8,
                    right: -8,
                    child: GestureDetector(
                      onTap: () => controller.removeDocumentSlot2(index),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Image.asset(IconString.deleteIcon, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }




// Add document box widget
  Widget _addDocumentBox(BuildContext context) {
    final spacing = AppSizes.padding(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0,
          child: Column(
            children: [
              Text(TextString.uploadTitle, style: TTextTheme.titleTwo(context)),
              SizedBox(height:4),
              const SizedBox(height: 45),
            ],
          ),
        ),
        SizedBox(height: spacing * 0.5),
        GestureDetector(
          onTap: () => controller.addDocumentSlot2(),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(AppSizes.borderRadius(context)),
            dashPattern: const [8, 6],
            color: AppColors.tertiaryTextColor,
            strokeWidth: 1,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.iconsBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(IconString.addIcon, color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 6),
                    Text(TextString.addDocument, style: TTextTheme.documnetIsnideSmallText(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



// Documents SECTION
  Widget _documentsSection(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

    Widget heading = Text(
      TextString.uploadMax6,
      style: TTextTheme.btnSix(context),
    );

    return Obx(() {
      final documentCount = controller.selectedDocuments2.length;
      List<Widget> documentWidgets = [];

      for (int i = 0; i < documentCount; i++) {
        documentWidgets.add(
          Column(
            key: ValueKey("doc_slot_$i"),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _documentNameField(context, i, controller.documentNameControllers2[i]),
              SizedBox(height: 8),
              _documentBox(context, i, controller.selectedDocuments2[i]),
            ],
          ),
        );
      }

      if (documentCount < controller.maxDocuments) {
        documentWidgets.add(_addDocumentBox(context));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading,
          const SizedBox(height: 30),
          LayoutBuilder(
            builder: (context, constraints) {
              final double totalWidth = constraints.maxWidth;

              int columns = isMobile ? 1 : (totalWidth < 650 ? 2 : 3);

              final double itemWidth = (totalWidth - (spacing * (columns - 1))) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: 13,
                children: documentWidgets.map((widget) {
                  return SizedBox(
                    width: itemWidth,
                    child: widget,
                  );
                }).toList(),
              );
            },
          ),
        ],
      );
    });
  }


  // Button Section
  Widget _buttonSection(BuildContext context, bool isMobile) {
    const double webButtonWidth = 150.0;
    const double webButtonHeight = 45.0;
    final double spacing = AppSizes.padding(context);
    void handleSave() {
      if (controller.validateForm()) {

        Get.snackbar(
          "Success",
          "Vehicle saved successfully!",
          backgroundColor: AppColors.completedColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        context.go('/carInventory');
      } else {
        Get.snackbar(
          "Validation Error",
          "Please fix the highlighted errors.",
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: webButtonHeight,
            child: CustomPrimaryButton(
              text: 'Cancel',
              backgroundColor: Colors.white,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () => context.pop(),
            ),
          ),
          SizedBox(height: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButton(
              text: "Save Vehicle",
              icon: Image.asset(IconString.saveVehicleIcon),
              onTap: handleSave,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          const Spacer(),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: CustomPrimaryButton(
              text: 'Cancel',
              backgroundColor: Colors.white,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () => context.pop(),
            ),
          ),
          SizedBox(width: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButton(
              text: "Save Vehicle",
              icon: Image.asset(IconString.saveVehicleIcon),
              onTap: handleSave,
            ),
          ),
        ],
      );
    }
  }

}