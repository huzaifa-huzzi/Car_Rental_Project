import 'dart:io';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/customPrimaryButton.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddCarFormWidget extends StatelessWidget {
  AddCarFormWidget({super.key});


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
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: CarInventoryController.carInventoryKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// CAR DETAILS HEADER
                Text(TextString.addScreenTitle, style: TTextTheme.h7Style(context)),
                SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
                Text(TextString.addScreenDescription, style: TTextTheme.titleThree(context)),
                SizedBox(height: AppSizes.verticalPadding(context) / 2),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                SizedBox(height: AppSizes.verticalPadding(context)),

                /// SECTION 1: CAR IDENTIFICATION
                _buildSectionTitle(context, "Car Identification"),
                const SizedBox(height: 15),
                _buildResponsiveGrid(context, [
                  _buildSearchCarDropdown(context, "Car Make", controller.selectedBrand, id: 'search_car'),
                  _buildSearchCarDropdown(context, "Car Model", controller.selectedModel, id: 'Model'),
                  _buildYearField(
                      context,
                      "Car Year",
                      controller.selectedCarYear,
                      id: "year"
                  ),
                  _buildTextField(context, "Car Registration Number", controller.regController,
                      maxLength: 10,
                      hint: "Write Registration Number...",
                      validator: (v) => controller.validateRegistration(v)),
                  _buildTextField(
                    context,
                    "VIN Number",
                    hint: "Write VIN Number...",
                    controller.vinController,
                    maxLength: 17, 
                    validator: (v) => controller.validateVIN(v), 
                  ),
                ]),

                const SizedBox(height: 25),
                const Divider(thickness: 0.5),
                const SizedBox(height: 25),

                /// SECTION 2: CAR SPECIFICATION
                _buildSectionTitle(context, "Car Specification"),
                const SizedBox(height: 15),
                _buildResponsiveGrid(context, [
                  _buildSearchCarDropdown(context, "Car Body Type", controller.selectedBodyType, id: 'body'),
                  _buildSearchCarDropdown2(context, "Car Transmission", controller.selectedTransmission, id: 'trans'),
                  _buildSearchCarDropdown2(context, "Car Seats", controller.selectedSeats, id: 'seats'),
                  _buildSearchCarDropdown2(context, "Car Engine Size", controller.selectedEngine, id: 'engine'),
                  _buildSearchCarDropdown(context, "Car Color", controller.selectedColor, id: 'color'),
                  _buildSearchCarDropdown2(context, "Car Fuel Type", controller.selectedFuel, id: 'fuel'),

                  _buildTextField(context, "Car Value", controller.valueController,
                      prefix: "\$ ", hint: "Car Value....",
                      keyboardType: TextInputType.number,
                      validator: (v) => controller.validateNumeric(v, "Car Value")),

                  _buildTextField(context, "Weekly Rent (AUD)", controller.weeklyRentController,
                      prefix: "\$ ",
                      hint: "Weekly Rent....",
                      keyboardType: TextInputType.number,
                      validator: (v) => controller.validateNumeric(v, "Weekly Rent")),

                  _buildStatusDropdown(
                    context,
                    "Status",
                    ["Available", "UnAvailable"],
                    controller.selectedStatus,
                    id: 'status',
                  ),
                ]),

                SizedBox(height: AppSizes.verticalPadding(context)),
                const Divider(thickness: 0.5),
                const SizedBox(height: 25),

                /// SECTION 3: IMAGE UPLOAD
                Text(TextString.uploadImageTitle, style: TTextTheme.btnSix(context)),
                SizedBox(height: AppSizes.verticalPadding(context)),
                _imageBox(context),
                SizedBox(height: AppSizes.verticalPadding(context)),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                /// SECTION 4: DESCRIPTION
                SizedBox(height: AppSizes.verticalPadding(context)),
                Text(TextString.descriptionTitle, style: TTextTheme.btnSix(context)),
                SizedBox(height: AppSizes.verticalPadding(context) * 0.5),

                Container(
                  padding: EdgeInsets.all(AppSizes.padding(context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                    color: AppColors.secondaryColor,
                  ),
                  child: TextFormField(
                    controller: controller.descriptionController,
                    cursorColor: AppColors.blackColor,
                    maxLines: 6,
                    style: TTextTheme.insidetextfieldWrittenText(context),
                    validator: (value) => controller.validateRequired(value, "Description"),
                    decoration: InputDecoration(
                      hintText: TextString.descriptionTextFieldText,
                      hintStyle: TTextTheme.pOne(context),
                      border: InputBorder.none,
                      errorStyle: TTextTheme.ErrorStyle(context),
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.verticalPadding(context)),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                /// SECTION 5: DOCUMENTS SECTION
                const SizedBox(height: 20),
                _documentsSection(context),
                SizedBox(height: AppSizes.verticalPadding(context)),

                /// BUTTON SECTION
                _buttonSection(context, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// ---------- Extra Widgets  --------///


  //  Section Title Widget
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TTextTheme.btnSix(context),
    );
  }

  // Responsive Grid Helper Widget
  Widget _buildResponsiveGrid(BuildContext context, List<Widget> children) {
    return LayoutBuilder(builder: (context, constraints) {
      double spacing = AppSizes.padding(context);

      int columns;
      if (AppSizes.isMobile(context)) {
        columns = 1;
      } else if (constraints.maxWidth > 900) {
        columns = 3;
      } else {
        columns = 2;
      }

      double itemWidth =
          (constraints.maxWidth - (spacing * (columns - 1))) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: 18,
        children: children
            .map((child) => SizedBox(width: itemWidth, child: child))
            .toList(),
      );
    });
  }

  // TextField Widget
  Widget _buildTextField(
      BuildContext context,
      String label,
      TextEditingController controller, {
        String? prefix,
        String? hint,
        int? maxLength,
        TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          style: TTextTheme.insidetextfieldWrittenText(context),
          inputFormatters: [
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondaryColor,
            hintText: hint,
            hintStyle: TTextTheme.pOne(context),
            prefixText: prefix,
            errorStyle: TTextTheme.ErrorStyle(context),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 1)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 1)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.2)
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

   //Dropdowns
  Widget _buildSearchCarDropdown(BuildContext context, String label, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown3.value == id;
      List<String> items = controller.getFilteredItems(id);
      String errorMsg = controller.dropdownErrors[id] ?? "";
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
                controller.searchCarText.value = "";
              },
              onSelected: (val) {
                if (val != "SEARCH_FIELD") {
                  selected.value = val;
                  controller.dropdownErrors[id] = "";

                  if (id == 'search_car') {
                    controller.selectedModel.value = "";
                    controller.dropdownErrors['Model'] = "";
                  }

                  controller.openedDropdown3.value = "";
                  controller.searchCarText.value = "";
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
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: TextField(
                        cursorColor: AppColors.blackColor,
                        onChanged: (val) => controller.searchCarText.value = val,
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
              child: Text(
                errorMsg,
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }
  Widget _buildSearchCarDropdown2(BuildContext context, String label, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown3.value == id;
      List<String> items = controller.getFilteredItems(id);
      String errorMsg = controller.dropdownErrors[id] ?? "";
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
                controller.searchCarText.value = "";
              },
              onSelected: (val) {
                selected.value = val;
                controller.dropdownErrors[id] = "";
                controller.openedDropdown3.value = "";
                controller.searchCarText.value = "";
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
                        selected.value.isEmpty ? "Select $label..." : selected.value,
                        style: TTextTheme.pOne(context)
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
                return items.map((item) {
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
                        Text(item, style: TTextTheme.medium14(context)),
                      ],
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
                errorMsg,
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }

  // Status Dropdown
  Widget _buildStatusDropdown(BuildContext context, String label, List<String> items, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      String errorMsg = controller.dropdownErrors[id] ?? "";
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
                maxHeight: 250,
              ),
              offset: const Offset(0, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (val) {
                selected.value = val;
                controller.openedDropdown2.value = "";
                controller.dropdownErrors[id] = "";
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _getStatusChip(selected.value, context),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon,
                      height: 18,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) => items.map((item) {
                bool isSelected = selected.value == item;
                return PopupMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryColor, width: 2),
                          color: isSelected ? AppColors.primaryColor : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.done, size: 12, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      _getStatusChip(item, context),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 4),
              child: Text(
                errorMsg,
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
    Color textColor = AppColors.blackColor;

    if (status.isEmpty) {
      return Text("Select Status", style: TTextTheme.pOne(context));
    }

    String displayStatus = status;
    String checkStatus = displayStatus.toLowerCase().trim();

    if (checkStatus == "available") {
      statusColor = AppColors.availableBackgroundColor;
      textColor = Colors.white;
    } else if (checkStatus.contains("un")) {
      statusColor = AppColors.oneBackground;
      textColor = Colors.white;
      displayStatus = "Un Available";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        displayStatus,
        style: TTextTheme.titleseven(context).copyWith(
          color: textColor,
        ),
      ),
    );
  }

  //  IMAGE UPLOAD BOX Widget
  Widget _imageBox(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.pickImage();
        controller.dropdownErrors['images'] = "";
      },
      child: Obx(() {
        bool hasError = controller.dropdownErrors['images']?.isNotEmpty ?? false;

        return DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(AppSizes.borderRadius(context)),
          dashPattern: const [8, 6],
          color: hasError ? AppColors.primaryColor : AppColors.tertiaryTextColor,
          strokeWidth: hasError ? 2 : 1,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 180),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
            ),
            child: controller.selectedImages.isEmpty
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
                      child:  Image.asset(IconString.cameraIcon, color: AppColors.primaryColor, width: 18,),
                    ),
                    const SizedBox(width: 5,),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.iconsBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child:  Image.asset(IconString.uploadIcon, color: AppColors.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(TextString.uploadTitle, style: TTextTheme.btnOne(context)),
                Text(TextString.uploadSubtitle, style: TTextTheme.documnetIsnideSmallText2(context)),
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text("At least one image is required", style: TTextTheme.ErrorStyle(context)),
                  ),
              ],
            )
                : Wrap(
              spacing: 12,
              runSpacing: 12,
              children: controller.selectedImages.asMap().entries.map((entry) {
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
                  clipBehavior: Clip.none,
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
                    Positioned(
                      top: -8,
                      right: -8,
                      child: GestureDetector(
                        onTap: () => controller.removeImage(index),
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Image.asset(IconString.deleteIcon, color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  //  DOCUMENT NAME FIELD Widget
  Widget _documentNameField(BuildContext context, int index, TextEditingController textController) {
    return Obx(() {
      bool hasError = controller.dropdownErrors["doc_$index"]?.isNotEmpty ?? false;

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
              border: Border.all(color: (hasError && textController.text.isEmpty) ? AppColors.primaryColor : Colors.transparent),
            ),
            child: TextField(
              cursorColor: AppColors.blackColor,
              style: TTextTheme.insidetextfieldWrittenText(context),
              controller: textController,
              onChanged: (v) {
                if(v.isNotEmpty) controller.dropdownErrors["doc_$index"] = "";
              },
              decoration: InputDecoration(
                hintText: TextString.documentSubtitle,
                border: InputBorder.none,
                hintStyle: TTextTheme.titleFour(context),
              ),
            ),
          ),
        ],
      );
    });
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
      final String hintText = controller.defaultDocumentNames[index];
      bool hasError = controller.dropdownErrors["doc_$index"]?.isNotEmpty ?? false;

      ImageProvider? imageProvider;
      if (isImage) {
        if (kIsWeb && docValue.bytes != null) {
          imageProvider = MemoryImage(docValue.bytes!);
        } else if (!kIsWeb && docValue.path != null) {
          imageProvider = FileImage(File(docValue.path!));
        }
      }

      return GestureDetector(
        onTap: isUploaded ? null : () {
          controller.pickDocument(index);
          controller.dropdownErrors["doc_$index"] = "";
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(AppSizes.borderRadius(context)),
          dashPattern: const [8, 6],
          color: (hasError && !isUploaded) ? AppColors.primaryColor : (isUploaded ? AppColors.primaryColor : AppColors.tertiaryTextColor),
          strokeWidth: (isUploaded || hasError) ? 2 : 1,
          child: Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              image: isImage && imageProvider != null
                  ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
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
                      Text(TextString.uploadSubtitle, style: TTextTheme.documnetIsnideSmallText2(context)),
                    ],
                  )
                      : isImage
                      ? Container()
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.insert_drive_file, size: 40, color: AppColors.primaryColor),
                      const SizedBox(height: 8),
                      Text(
                        docValue.name,
                        textAlign: TextAlign.center,
                        style: TTextTheme.titleinputTextField(context),
                      ),
                    ],
                  ),
                ),
                if (isUploaded)
                  Positioned(
                    top: -8,
                    right: -8,
                    child: GestureDetector(
                      onTap: () {
                        controller.removeDocumentSlot(index);
                        controller.dropdownErrors.remove("doc_$index");
                      },
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


//-----ADD document box widget
  Widget _addDocumentBox(BuildContext context) {
    final spacing = AppSizes.padding(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0,
          child: Column(
            children: [
              Text(TextString.documentName, style: TTextTheme.titleTwo(context)),
              SizedBox(height:4),
              const SizedBox(height: 45),
            ],
          ),
        ),
        SizedBox(height: spacing * 0.5),
        GestureDetector(
          onTap: () => controller.addDocumentSlot(),
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(AppSizes.borderRadius(context)),
            dashPattern: const [8, 6],
            color: AppColors.tertiaryTextColor,
            strokeWidth: 1,
            child: Container(
              height: 250,
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



//-----DOCUMENTS SECTION
  Widget _documentsSection(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

    Widget heading = Text(
      TextString.uploadMax6,
      style: TTextTheme.btnSix(context),
    );

    return Obx(() {
      final documentCount = controller.selectedDocuments.length;
      List<Widget> documentWidgets = [];

      for (int i = 0; i < documentCount; i++) {
        documentWidgets.add(
          Column(
            key: ValueKey("doc_slot_$i"),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _documentNameField(context, i, controller.documentNameControllers[i]),
              SizedBox(height: 8),
              _documentBox(context, i, controller.selectedDocuments[i]),
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
    final double spacing = AppSizes.padding(context);

    void onSavePressed() {
      bool canShowDialog = controller.saveInventory(context);

      if (canShowDialog) {
        showSavingDialog(context);
      } else {
        Get.snackbar(
          "Validation Failed",
          "VIN must be 17 and Registration 8-10 characters.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }

    return isMobile
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCancelBtn(),
        SizedBox(height: spacing),
        _buildSaveBtn(onSavePressed),
      ],
    )
        : Row(
      children: [
        const Spacer(),
        _buildCancelBtn(),
        SizedBox(width: spacing),
        _buildSaveBtn(onSavePressed),
      ],
    );
  }
  Widget _buildCancelBtn() => SizedBox(width: 150, height: 45, child: CustomPrimaryButton(text: 'Cancel', onTap: () => Get.back()));
  Widget _buildSaveBtn(VoidCallback onTap) => SizedBox(width: 150, height: 45, child: AddButton(text: "Save Vehicle", icon: Image.asset(IconString.saveVehicleIcon), onTap: onTap));

   // Year Field
  Widget _buildYearField(
      BuildContext context,
      String label,
      RxString selected,
      {required String id}
      ) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      var items = controller.getFilteredItems(id);
      String errorMsg = controller.dropdownErrors[id] ?? "";
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
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () {
                controller.openedDropdown2.value = "";
                controller.searchCarText.value = "";
              },
              onSelected: (val) {
                if (val != "SEARCH_FIELD") {
                  selected.value = val;
                  if (controller.dropdownErrors.containsKey(id)) {
                    controller.dropdownErrors[id] = "";
                  }

                  controller.openedDropdown2.value = "";
                  controller.searchCarText.value = "";
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
                        selected.value.isEmpty ? "Select $label" : selected.value,
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
                        border: Border.all(color: AppColors.primaryColor.withOpacity(0.4)),
                      ),
                      child: TextField(
                        cursorColor: AppColors.blackColor,
                        autofocus: true,
                        onChanged: (val) {
                          controller.searchCarText.value = val;
                        },
                        style: TTextTheme.titleinputTextField(context),
                        decoration: InputDecoration(
                          hintText: "Search Year",
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
                  if (items.isEmpty)
                    const PopupMenuItem(
                      enabled: false,
                      child: Center(child: Text("No years found")),
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

    // Dialog
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

}