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
        width:1100,
        margin: EdgeInsets.all(AppSizes.padding(context)),
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppSizes.borderRadius(context),
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CAR DETAILS
              Text(TextString.addScreenTitle, style: TTextTheme.h7Style(context)),
              SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
              Text(TextString.addScreenDescription, style: TTextTheme.titleThree(context)),
              SizedBox(height: AppSizes.verticalPadding(context)/2),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
              SizedBox(height: AppSizes.verticalPadding(context)),


              ///GRID FORM
              _buildSectionTitle(context, "Car Identification"),
              const SizedBox(height: 15),
              _buildResponsiveGrid(context, [
                _buildSearchCarDropdown(context, "Car Make", controller.selectedBrand, id: 'search_car'),
                _buildSearchCarDropdown(context, "Car Model", controller.selectedModel, id: 'Model'),
                _buildTextField(context, "Car Registration Number", controller.regController, hint: "Write Registration Number..."),
                _buildTextField(context, "VIN Number", controller.vinController, hint: "Write VIN Number...."),
              ]),

              const SizedBox(height: 25),
              const Divider(thickness: 0.5),
              const SizedBox(height: 25),

              /// SECTION 2: CAR SPECIFICATION
              _buildSectionTitle(context, "Car Specification"),
              const SizedBox(height: 15),
              _buildResponsiveGrid(context, [
                _buildSearchCarDropdown(context, "Car Body Type", controller.selectedBodyType, id: 'body'),
                _buildSearchCarDropdown(context, "Car Transmission", controller.selectedTransmission, id: 'trans'),
                _buildTextField(context, "Car Seats", controller.seatsController, hint: "Write Car Seats..."),
                _buildTextField(context, "Car Engine Size", controller.engineController, hint: "Write Engine Size..."),
                _buildTextField(context, "Car Color", controller.colorController, hint: "Write Color name OR Code..."),
                _buildSearchCarDropdown(context, "Car Fuel Type", controller.selectedFuel, id: 'fuel'),
                _buildTextField(context, "Car Value", controller.valueController, prefix: "\$ ", hint: "Car Value...."),
                _buildTextField(context, "Weekly Rent (AUD)", controller.weeklyRentController, prefix: "\$ "),
                _buildStatusDropdown(
                  context,
                  "Status",
                  controller.statuses,
                  controller.selectedStatus,
                  id: 'status',
                ),
              ]),


              SizedBox(height: AppSizes.verticalPadding(context)),
              const Divider(thickness: 0.5),
              const SizedBox(height: 25),

              /// IMAGE UPLOAD
              Text(TextString.uploadImageTitle, style: TTextTheme.btnSix(context)),
              SizedBox(height: AppSizes.verticalPadding(context)),
              _imageBox(context),
              SizedBox(height: AppSizes.verticalPadding(context)),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),


              /// DESCRIPTION
              SizedBox(height: AppSizes.verticalPadding(context)),
              Text(TextString.descriptionTitle, style: TTextTheme.btnSix(context)),
              SizedBox(height: AppSizes.verticalPadding(context) * 0.5),

              Container(
                padding: EdgeInsets.all(AppSizes.padding(context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  color: AppColors.secondaryColor,
                ),
                child: TextField(
                  cursorColor: AppColors.blackColor,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: TextString.descriptionTextFieldText,
                    hintStyle: TTextTheme.pOne(context),
                    border: InputBorder.none,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.verticalPadding(context)),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              /// DOCUMENTS SECTION
              _documentsSection(context),
              SizedBox(height: AppSizes.verticalPadding(context)),

              ///BUTTON SECTION
              _buttonSection(context, isMobile),
            ],
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
  Widget _buildTextField(BuildContext context, String label, TextEditingController controller,
      {String? prefix, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
        Focus(
          onFocusChange: (hasFocus) {
            (context as Element).markNeedsBuild();
          },
          child: Builder(
            builder: (context) {
              final bool isFocused = Focus.of(context).hasFocus;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  boxShadow: isFocused
                      ? [
                    BoxShadow(
                      color: AppColors.fieldsBackground,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                      : [],
                ),
                child: TextField(
                  controller: controller,
                  cursorColor: AppColors.blackColor,
                  keyboardType:  TextInputType.number ,
                  style: TTextTheme.insidetextfieldWrittenText(context),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.secondaryColor,
                    hintText: hint ?? "Enter $label",
                    hintStyle: TTextTheme.titleFour(context),
                    prefixText: prefix,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchCarDropdown(BuildContext context, String label, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown3.value == id;
      List<String> items = controller.getFilteredItems(id);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth),
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
                  if (id == 'search_car') {
                    controller.selectedModel.value = "";
                  }

                  controller.openedDropdown3.value = "";
                  controller.searchCarText.value = "";
                }
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selected.value.isEmpty ? "Search $label..." : selected.value,
                        style: TTextTheme.pOne(context),
                      ),
                    ),
                    Image.asset(isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon, height: 18),
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
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 14,
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item,
                            style: TTextTheme.medium14(context),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ];
              },
            );
          }),
        ],
      );
    });
  }

  // Status Dropdown
  Widget _buildStatusDropdown(BuildContext context, String label, List<String> items, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth),
              offset: const Offset(0, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              color: AppColors.secondaryColor,
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (val) {
                selected.value = val;
                controller.openedDropdown2.value = "";
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(child: Align(alignment: Alignment.centerLeft, child: _getStatusChip(selected.value,context))),
                    const SizedBox(width: 8),
                    Image.asset(isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon, height: 18),
                  ],
                ),
              ),
              itemBuilder: (context) => items.asMap().entries.map((entry) {
                bool isLast = entry.key == items.length - 1;
                return PopupMenuItem<String>(
                  value: entry.value,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Align(alignment: Alignment.centerLeft, child: _getStatusChip(entry.value,context)),
                      ),
                      if (!isLast) Divider(height: 1, color: AppColors.quadrantalTextColor),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
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
      statusColor = AppColors.sideBoxesColor;
      textColor = AppColors.secondTextColor;
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





  //  IMAGE UPLOAD BOX Widget
  Widget _imageBox(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickImage(),
      child: Obx(() {
        return DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(AppSizes.borderRadius(context)),
          dashPattern: [8, 6],
          color: AppColors.tertiaryTextColor,
          strokeWidth: 1,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 180),
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
                      child:  Image.asset(IconString.cameraIcon, color: AppColors.primaryColor,width: 18,),
                    ),
                     SizedBox(width: 5,),
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
      final String hintText = controller.defaultDocumentNames[index];


      ImageProvider? imageProvider;
      if (isImage) {
        if (kIsWeb && docValue.bytes != null) {
          imageProvider = MemoryImage(docValue.bytes!);
        } else if (!kIsWeb && docValue.path != null) {
          imageProvider = FileImage(File(docValue.path!));
        }
      }

      return GestureDetector(
        onTap: isUploaded ? null : () => controller.pickDocument(index),
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
                      onTap: () => controller.removeDocumentSlot(index),
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
    const double webButtonWidth = 150.0;
    const double webButtonHeight = 45.0;
    final double spacing = AppSizes.padding(context);

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
              onTap: () {},
            ),
          ),
          SizedBox(height: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButton(
              text: "Save Vehicle",
              icon: Image.asset(
                IconString.saveVehicleIcon,
              ),
              onTap: () {},
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Spacer(),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: CustomPrimaryButton(
              text: 'Cancel',
              backgroundColor: Colors.white,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () {},
            ),
          ),
          SizedBox(width: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButton(
              text: "Save Vehicle",
              icon: Image.asset(
                IconString.saveVehicleIcon,
              ),
              onTap: () {},
            ),
          ),

        ],
      );
    }
  }

}