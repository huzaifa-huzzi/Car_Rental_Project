import 'dart:io';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/CarInventoryController.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/ButtonWidget.dart';
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/customPrimaryButton.dart';
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

    return Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// CAR DETAILS
            Text(TextString.addScreenTitle, style: TTextTheme.h7Style(context)),
            SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
            Text(TextString.addScreenDescription, style: TTextTheme.titleThree(context)),
            SizedBox(height: AppSizes.verticalPadding(context)),
            Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
            SizedBox(height: AppSizes.verticalPadding(context)),


            ///GRID FORM
            LayoutBuilder(
              builder: (context, constraints) {
                final double totalWidth = constraints.maxWidth;
                final double spacing = AppSizes.padding(context);
                double itemWidth;
                int columns;


                if (totalWidth >= 900) {
                  columns = 3;
                }
                else if (totalWidth >= 550) {
                  columns = 3;
                }
                else {
                  columns = 2;
                }


                if (columns == 1) {
                  itemWidth = totalWidth;
                } else {
                  final double totalSpacing = spacing * (columns - 1);
                  itemWidth = (totalWidth - totalSpacing) / columns;
                }

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(width: itemWidth, child: _buildDropdown(context, "Car Brand", ["Toyota", "Honda", "BMW"], controller.selectedBrand, id: 'car Brand')),
                    SizedBox(width: itemWidth, child: _buildDropdown(context, "Car Model", ["Corolla", "Civic", "X5"], controller.selectedModel,id: 'car Model')),
                    SizedBox(width: itemWidth, child: _buildDropdown(context, "Car Model Year", ["2020", "2021", "2022"], controller.selectedYear,id: 'Year')),
                    SizedBox(width: itemWidth, child: _buildDropdown(context, "Car Body Type", ["Sedan", "SUV", "Truck"], controller.selectedBodyType,id: 'Body type')),
                    SizedBox(width: itemWidth, child: _buildDropdown(context, "Car Transmission", ["Automatic", "Manual"], controller.selectedTransmission,id: 'Transmission')),
                    SizedBox(width: itemWidth, child: _buildTextField(context, "Car Seats", controller.seatsController)),
                    SizedBox(width: itemWidth, child: _buildTextField(context, "Car Engine Size", controller.engineController)),
                    SizedBox(width: itemWidth, child: _buildTextField(context, "Car Color", controller.colorController)),
                    SizedBox(width: itemWidth, child: _buildTextField(context, "Weekly Rent (AUD)", controller.weeklyRentController, prefix: "\$ ")),
                    SizedBox(width: itemWidth, child: _buildTextField(context, "Car Registration Number", controller.regController)),
                    SizedBox(width: itemWidth, child: _buildTextField(context, "Car Value", controller.valueController, prefix: "\$")),
                  ],
                );
              },
            ),


            SizedBox(height: AppSizes.verticalPadding(context)),

            /// IMAGE UPLOAD
            Text("Upload Car Images", style: TTextTheme.titleTwo(context)),
            SizedBox(height: AppSizes.verticalPadding(context)),
            _imageBox(context),
            SizedBox(height: AppSizes.verticalPadding(context)),
            Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),


            /// DESCRIPTION
            SizedBox(height: AppSizes.verticalPadding(context)),
            Text(TextString.descriptionTitle, style: TTextTheme.titleTwo(context)),
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
    );
  }


  /// ---------- Extra Widgets  --------///

  // _buildDropdown Widget
  Widget _buildDropdown(
      BuildContext context,
      String label,
      List<String> items,
      RxString selected, {
        required String id,
      }) {

    return Obx(() {
      bool isOpen = controller.openedDropdown.value == id;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
          GestureDetector(
            onTap: () {
              if (controller.openedDropdown.value == id) {
                controller.openedDropdown.value = "";
              } else {
                controller.openedDropdown.value = id;
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: AppColors.secondaryColor,
                  value: selected.value.isEmpty ? null : selected.value,
                  hint: Text("$label", style: TTextTheme.titleFour(context)),
                  icon: Image.asset(
                    isOpen
                        ? IconString.upsideDropdownIcon
                        : IconString.dropdownIcon,
                    height: 18,
                  ),
                  selectedItemBuilder: (context) {
                    return items.map((item) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(item, style: TTextTheme.titleTwo(context)),
                      );
                    }).toList();
                  },
                  items: items.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: TTextTheme.titleTwo(context)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selected.value = value!;
                    controller.openedDropdown.value = "";
                  },
                ),
              ),
            ),
          ),
        ],
      );
    });
  }


//  TextField Widgets
  Widget _buildTextField(BuildContext context, String label, TextEditingController controller,
      {String? prefix}) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
        TextField(
          controller: controller,
          cursorColor: AppColors.blackColor,
          keyboardType: prefix != null ? TextInputType.number : TextInputType.text,
          style: TTextTheme.insidetextfieldWrittenText(context),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondaryColor,
            hintText: "Enter $label",
            hintStyle: TTextTheme.titleFour(context),
            prefixText: prefix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.iconsBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:  Image.asset(IconString.uploadIcon, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 10),
                Text("Click to upload Images", style: TTextTheme.btnOne(context)),
                Text("SVG, PNG, JPG", style: TTextTheme.documnetIsnideSmallText2(context)),
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
                        border: Border.all(color: AppColors.primaryColor, width: 2),
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: -8,
                      right: -8,
                      child: GestureDetector(
                        onTap: () => controller.removeImage(index),
                        child: CircleAvatar(
                          radius: 12,
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
        Text("Document Name", style: TTextTheme.titleTwo(context)),
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
              hintText: "Write your document name",
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

    bool _isImageFile(String fileName) {
      final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      final lowerCaseName = fileName.toLowerCase();
      return imageExtensions.any((ext) => lowerCaseName.endsWith(ext));
    }
    return Obx(() {
      final docValue = selectedDoc.value;
      final bool isUploaded = docValue != null;
      final bool isImage = isUploaded && _isImageFile(docValue!.name);
      final String hintText = controller.defaultDocumentNames[index];


      ImageProvider? imageProvider;
      if (isImage) {
        if (kIsWeb && docValue!.bytes != null) {
          imageProvider = MemoryImage(docValue.bytes!);
        } else if (!kIsWeb && docValue!.path != null) {
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
                      Text("SVG,PNG,JPG", style:TTextTheme.documnetIsnideSmallText2(context)),
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
                        docValue!.name,
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
                        radius: 12,
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
    if (controller.selectedDocuments.length >= controller.maxDocuments) {
      return SizedBox.shrink();
    }

    final isMobile = AppSizes.isMobile(context);


    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.iconsBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              IconString.addIcon,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Add Document",
            style: TTextTheme.documnetIsnideSmallText(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );


    return GestureDetector(
      onTap: () => controller.addDocumentSlot(),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(AppSizes.borderRadius(context)),
        dashPattern: [8, 6],
        color: AppColors.tertiaryTextColor,
        strokeWidth: 1,
        child: Container(
          width: double.infinity,
          constraints: isMobile ? BoxConstraints(minHeight: 180) : null,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          ),

          child: isMobile
              ? AspectRatio(
            aspectRatio: 1.8,
            child: content,
          )
              : content,
        ),
      ),
    );
  }



//-----DOCUMENTS SECTION
  Widget _documentsSection(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

    Widget heading = Text(
      "Upload Document (Tax Token Paper,Insurance paper,etx MAX 6)",
      style: TTextTheme.titleTwo(context),
    );

    return Obx(() {
      final documentCount = controller.selectedDocuments.length;
      List<Widget> documentWidgets = [];

      for (int i = 0; i < documentCount; i++) {
        Widget docSlot = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _documentNameField(context, i, controller.documentNameControllers[i]),
            SizedBox(height: spacing * 0.5),
            _documentBox(context, i, controller.selectedDocuments[i]),
          ],
        );
        documentWidgets.add(docSlot);
      }
      documentWidgets.add(_addDocumentBox(context));
      final finalDocumentWidgets = documentWidgets.where((widget) => widget is! SizedBox).toList();


      if (isMobile) {
        List<Widget> mobileStack = [
          heading,
          SizedBox(height: spacing * 0.7),
        ];

        for (int i = 0; i < finalDocumentWidgets.length; i++) {
          mobileStack.add(finalDocumentWidgets[i]);

          if (i < finalDocumentWidgets.length - 1) {
            mobileStack.add(SizedBox(height: spacing * 2));
          }
        }


        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: mobileStack,
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading,
            SizedBox(height: spacing * 0.7),

            LayoutBuilder(
                builder: (context, constraints) {
                  int docColumnCount;
                  if (constraints.maxWidth < 600) {
                    docColumnCount = 2;
                  } else {
                    docColumnCount = 3;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: docColumnCount,
                      crossAxisSpacing: spacing,
                      mainAxisSpacing: spacing,
                      childAspectRatio: 0.98,
                    ),
                    itemCount: finalDocumentWidgets.length,
                    itemBuilder: (context, index) {
                      return finalDocumentWidgets[index];
                    },
                  );
                }
            ),
          ],
        );
      }
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