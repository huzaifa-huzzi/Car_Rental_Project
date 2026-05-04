import 'dart:io';
import 'package:car_rental_project/Portal/Vendor/Car%20Inventory/Car%20Directory/ReusableWidget/customPrimaryButton.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/AddButtonOfCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/AlertDialogCustomers.dart';
import 'package:car_rental_project/Portal/Vendor/Customers/ReusableWidgetOfCustomers/CustomerPrimaryBtn.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:go_router/go_router.dart';

class EditCustomerWidget extends StatelessWidget {
  EditCustomerWidget({super.key});

  final CustomerController controller = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

    return Center(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(AppSizes.padding(context)),
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: Form(
          key: CustomerController.editCustomerFormKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(spacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// CUSTOMER HEADER
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset(IconString.editIcon2, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(TextString.editTitle, style: TTextTheme.h7Style(context)),
                          const SizedBox(height: 4),
                          Text(TextString.editSubtitle, style: TTextTheme.titleThree(context)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomPrimaryButton(
                      text: MediaQuery.of(context).size.width < 900 ? "" : "Edit",
                      iconPath: IconString.editIcon,
                      width: MediaQuery.of(context).size.width < 900 ? 40 : 110,
                      height: 38,
                      textColor: AppColors.primaryColor,
                      borderColor: AppColors.primaryColor,
                      onTap: () => print("Edit Mode Enabled"),
                    ),
                    const SizedBox(width: 8),
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
                          builder: (_) => ResponsiveCustomerDialog(
                            onCancel: () => context.pop(),
                            onConfirm: () => context.pop(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.verticalPadding(context) / 2),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                SizedBox(height: AppSizes.verticalPadding(context)),

                /// PROFILE IMAGE UPLOAD
                Align(
                  alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                  child: _buildProfilePhotoPicker(context),
                ),
                SizedBox(height: spacing * 1.5),

                /// BASIC INFO GRID FORM
                _buildResponsiveGrid(context, [
                  _buildTextField(context, TextString.customerName, controller.givenNameController2,
                      validator: (v) => controller.validateRequired(v, "Given Name")),
                  _buildTextField(context, TextString.customerSurname, controller.surnameController2,
                      validator: (v) => controller.validateRequired(v, "Surname")),
                  CompositedTransformTarget(
                    link: controller.dobLink2,
                    child: _buildDOBField2(
                      context,
                      "Date of Birth",
                      controller.dobController2,
                      validator: (v) => controller.validateRequired(v, "Date of Birth"),
                      onTap: () => controller.toggleCalendar(context, controller.dobLink2, controller.dobController2),
                    ),
                  ),
                  _buildPhoneField(context, "Contact Number"),
                  _buildTextField(context, TextString.customerEmail, controller.emailController2,
                      validator: (v) => controller.validateEmail(v)),
                  _buildTextField(context, TextString.customerAddress, controller.addressController2,
                      validator: (v) => controller.validateRequired(v, "Address")),
                ]),

                SizedBox(height: spacing),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                /// CUSTOMER NOTE SECTION
                SizedBox(height: spacing),
                Text(TextString.customerNote, style: TTextTheme.btnSix(context)),
                SizedBox(height: 8),
                _buildLargeTextField(context, TextString.customerNoteSubtitle, controller.noteController2,
                    validator: (v) => controller.validateRequired(v, "Note")),

                SizedBox(height: spacing),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                /// LICENSE DETAILS SECTION
                SizedBox(height: spacing),
                Text(TextString.licenseTitle, style: TTextTheme.btnSix(context)),
                SizedBox(height: spacing),
                _buildResponsiveGrid(context, [
                  _buildTextField(context, "License Name", controller.licenseNameController2,
                      validator: (v) => controller.validateRequired(v, "License Name")),
                  _buildTextField(context, "Driver License Number", controller.licenseNumberController2,
                      validator: (v) => controller.validateRequired(v, "License Number")),
                  CompositedTransformTarget(
                    link: controller.expiryLink2,
                    child: _buildCalendarFieldGeneric(
                      context,
                      "License Expiry Date",
                      controller.licenseExpiryController2,
                      validator: (v) => controller.validateRequired(v, "Expiry Date"),
                      onTap: () => controller.toggleCalendar(context, controller.expiryLink2, controller.licenseExpiryController2),
                    ),
                  ),
                  _buildTextField(context, "Card Number", controller.licenseCardNumberController2,
                      validator: (v) => controller.validateRequired(v, "Card Number")),
                ]),

                SizedBox(height: spacing),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                /// DOCUMENTS UPLOAD SECTION
                SizedBox(height: spacing),
                Text(TextString.uploadDocumentTitle, style: TTextTheme.btnSix(context)),
                SizedBox(height: spacing),
                _documentsSection(context),

                SizedBox(height: spacing),
                Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

                /// CARD DETAILS SECTION
                Text(TextString.addCardDetailsTitle, style: TTextTheme.btnSix(context)),
                SizedBox(height: spacing),

                Center(
                  child: SizedBox(
                    width: 450,
                    child: _buildCardSelectionRow(context),
                  ),
                ),

                SizedBox(height: spacing),
                _buildCardForm(context),
                SizedBox(height: spacing * 2),
                _buttonSection(context, isMobile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------- Extra Widgets --------///

  Widget _buildProfilePhotoPicker(BuildContext context) {
    return Obx(() {
      final hasImg = controller.profileImage2.value != null;
      final bool hasError = controller.imageError2.value;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller.pickProfileImage2(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: hasError ? AppColors.primaryColor : AppColors.iconsBackgroundColor,
                  width: hasError ? 2 : 1,
                ),
              ),
              child: hasImg
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: kIsWeb
                    ? Image.memory(controller.profileImage2.value!.bytes!, fit: BoxFit.cover)
                    : Image.file(File(controller.profileImage2.value!.path!), fit: BoxFit.cover),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.iconsBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(IconString.uploadIcon, color: AppColors.primaryColor, width: 24),
                  ),
                  const SizedBox(height: 10),
                  Text(TextString.photoTitle, style: TTextTheme.documnetIsnideSmallText(context)),
                  Text(TextString.uploadSubtitle, style: TTextTheme.documnetIsnideSmallText2(context)),
                ],
              ),
            ),
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 4),
              child: Text(
                "Photo is required",
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }

  // Responsive Grid Widget
  Widget _buildResponsiveGrid(BuildContext context, List<Widget> children) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth < 500 ? 1 : 3;
      double spacing = 16.0;
      double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: children.map((child) => SizedBox(width: itemWidth, child: child)).toList(),
      );
    });
  }

  //  TextField Widget
  Widget _buildTextField(BuildContext context, String label, TextEditingController ctrl, {String? hint, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 6),
        Focus(
          onFocusChange: (hasFocus) {
            (context as Element).markNeedsBuild();
          },
          child: Builder(
            builder: (context) {
              final bool isFocused = Focus.of(context).hasFocus;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  boxShadow: isFocused
                      ? [
                    BoxShadow(
                      color: AppColors.fieldsBackground,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ]
                      : [],
                ),
                child: TextFormField(
                  controller: ctrl,
                  cursorColor: AppColors.blackColor,
                  style: TTextTheme.titleTwo(context),
                  validator: validator,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      CustomerController.editCustomerFormKey.currentState?.validate();
                    }
                  },

                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: hint ?? "Write $label...",
                    hintStyle: TTextTheme.titleFour(context),
                    filled: true,
                    fillColor: AppColors.secondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      borderSide: BorderSide.none,
                    ),
                    errorStyle: TTextTheme.ErrorStyle(context),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
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

 // Large TextField
  Widget _buildLargeTextField(BuildContext context, String hint, TextEditingController ctrl, {String? Function(String?)? validator}) {
    return Focus(
      onFocusChange: (hasFocus) {
        (context as Element).markNeedsBuild();
      },
      child: Builder(
        builder: (context) {
          final bool isFocused = Focus.of(context).hasFocus;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              boxShadow: isFocused
                  ? [
                BoxShadow(
                  color: AppColors.fieldsBackground,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ]
                  : [],
            ),
            child: TextFormField(
              controller: ctrl,
              cursorColor: AppColors.blackColor,
              maxLines: 5,
              validator: validator,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  CustomerController.editCustomerFormKey.currentState?.validate();
                }
              },

              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TTextTheme.titleFour(context),
                filled: true,
                fillColor: AppColors.secondaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  borderSide: BorderSide.none,
                ),
                errorStyle: TTextTheme.ErrorStyle(context),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          );
        },
      ),
    );
  }

  //  Documents Section Widgets
  Widget _documentsSection(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

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
              const SizedBox(height: 10),
              _documentBox(context, i, controller.selectedDocuments2[i]),
            ],
          ),
        );
      }

      if (documentCount < controller.maxDocuments) {
        documentWidgets.add(_addDocumentBox(context));
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final double totalWidth = constraints.maxWidth;
          int columns = isMobile ? 1 : (totalWidth < 650 ? 2 : 3);
          final double itemWidth = (totalWidth - (spacing * (columns - 1))) / columns;

          return Wrap(
            spacing: spacing,
            runSpacing: 25,
            children: documentWidgets.map((widget) {
              return SizedBox(width: itemWidth, child: widget);
            }).toList(),
          );
        },
      );
    });
  }

  Widget _documentNameField(BuildContext context, int index, TextEditingController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.documentTitleTextField, style: TTextTheme.titleTwo(context)),
        SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.padding(context)),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          ),
          child: TextField(
            cursorColor: AppColors.blackColor,
            style: TTextTheme.titleTwo(context),
            controller: ctrl,
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
      final String hintText = "Document ${index + 1}";

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
          dashPattern: const [8, 6],
          color: isUploaded ? AppColors.primaryColor : AppColors.tertiaryTextColor,
          strokeWidth: isUploaded ? 2 : 1,
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.iconsBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(IconString.uploadIcon, color: AppColors.primaryColor, width: 24),
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
                        style: const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                        child: Image.asset(IconString.deleteIcon, color: AppColors.primaryColor, width: 16),
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
              const SizedBox(height: 4),
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
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.iconsBackgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(IconString.addIcon, color: AppColors.primaryColor, width: 24),
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


   // DOB Field
  Widget _buildDOBField2(BuildContext context, String label, TextEditingController textController, {required VoidCallback onTap, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        TextFormField(
          controller: textController,
          readOnly: true,
          onTap: onTap,
          validator: validator,
          style: TTextTheme.pOne(context),
          decoration: InputDecoration(
            errorStyle: TTextTheme.ErrorStyle(context),
            hintText: "DD/MM/YYYY",
            hintStyle: TTextTheme.pOne(context),
            filled: true,
            fillColor: AppColors.secondaryColor,
            suffixIcon: Icon(Icons.event, color: AppColors.quadrantalTextColor, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(BuildContext context, String label) {
    final controller = Get.find<CustomerController>();
    final List<Country> countryList = CountryService().getAll();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller.phoneController2,
          keyboardType: TextInputType.phone,
          validator: (v) => controller.validateRequired(v, "Phone Number"),
          style: TTextTheme.insidetextfieldWrittenText(context),
          cursorColor: AppColors.blackColor,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.secondaryColor,
            hintText: "Enter number",
            hintStyle: TTextTheme.titleTwo(context),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonHideUnderline(
                    child: Obx(() => DropdownButton2<Country>(
                      isExpanded: false,
                      value: countryList.firstWhere(
                            (c) => c.name == controller.selectedCountryName2.value,
                        orElse: () => countryList.firstWhere((c) => c.name == "Australia"),
                      ),
                      selectedItemBuilder: (context) {
                        return countryList.map((Country country) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              _buildCircleFlag(country.countryCode),
                              const SizedBox(width: 10),
                              Text("+${country.phoneCode}",
                                  style: TTextTheme.bodyRegular14(context)
                                      .copyWith(color: AppColors.blackColor)),
                            ],
                          );
                        }).toList();
                      },
                      items: countryList.map((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Row(
                            children: [
                              _buildCircleFlag(country.countryCode),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(country.name,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              Text("+${country.phoneCode}",
                                  style: TTextTheme.titleinputTextField(context)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Country? value) {
                        if (value != null) {
                          controller.selectedCountryName2.value = value.name;
                          controller.selectedCode2.value = "+${value.phoneCode}";
                        }
                      },
                      buttonStyleData: const ButtonStyleData(
                        height: 48,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            size: 20, color: Colors.black54),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 350,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        offset: const Offset(0, -5),
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: controller.searchController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: _buildSearchField(
                            context, controller.searchController2),
                        searchMatchFn: (item, searchValue) {
                          return item.value!.name
                              .toLowerCase()
                              .contains(searchValue.toLowerCase()) ||
                              item.value!.phoneCode.contains(searchValue);
                        },
                      ),
                    )),
                  ),
                ],
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorStyle: const TextStyle(color: AppColors.primaryColor, fontSize: 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
  Widget _buildSearchField(BuildContext context, TextEditingController searchController) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: searchController,
        style: TTextTheme.textFieldWrittenText(context),
        decoration: InputDecoration(
          isDense: true,
          fillColor: AppColors.backgroundOfScreenColor,
          filled: true,
          hintText: 'Search',
          hintStyle: TTextTheme.titleTwo(context),
          prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.primaryColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  // Card Selection Section
  Widget _buildCardSelectionRow(BuildContext context) {
    return Obx(() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(controller.totalCards.value, (index) => GestureDetector(
            onTap: () => controller.selectedCardIndex2.value = index,
            child: _cardTab(context, "Card ${index + 1}", controller.selectedCardIndex2.value == index),
          )),

          if (controller.totalCards.value < 5)
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: GestureDetector(
                onTap: () => controller.addNewCard(),
                child: Container(
                    width: 45,
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondTextColor),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(Icons.add, color: AppColors.quadrantalTextColor, size: 24),
                    )
                ),
              ),
            ),
        ],
      ),
    ));
  }

  Widget _cardTab(BuildContext context, String label, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 12),
      width: 110,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? AppColors.cardsHovering : AppColors.secondTextColor,
          width: isSelected ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected ? [
          BoxShadow(
            color: AppColors.fieldsBackground,
            blurRadius: 2,
            offset: const Offset(0, 3),
          )
        ] : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
              IconString.cardIcon,
              width: 20,
              color: isSelected ? AppColors.cardsHovering : AppColors.secondTextColor
          ),
          const SizedBox(height: 6),
          Text(
              label,
              style: TTextTheme.btnOne(context).copyWith(
                  fontSize: 12,
                  color: isSelected ? AppColors.cardsHovering: AppColors.secondTextColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal
              )
          ),
        ],
      ),
    );
  }

  //  Card Form Widget
  Widget _buildCardForm(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isWeb ? 800 : 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWeb)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildShadowTextField(
                      context, "Card number", controller.ccNumberController2,
                      hint: "1234 1234 1234 1234",
                      isCreditCard: true,
                      validator: (v) => controller.validateRequired2(v, "Card number"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildShadowTextField(
                      context, "Card Holder Name", controller.ccHolderController2,
                      hint: "Softsnip",
                      validator: (v) => controller.validateRequired2(v, "Holder Name"),
                    ),
                  ),
                ],
              )
            else ...[
              _buildShadowTextField(
                context, "Card number", controller.ccNumberController2,
                hint: "1234 1234 1234 1234",
                isCreditCard: true,
                validator: (v) => controller.validateRequired2(v, "Card number"),
              ),
              const SizedBox(height: 16),
              _buildShadowTextField(
                context, "Card Holder Name", controller.ccHolderController2,
                hint: "Softsnip",
                validator: (v) => controller.validateRequired2(v, "Holder Name"),
              ),
            ],

            const SizedBox(height: 16),
            if (isWeb)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildShadowTextField(
                      context, "Expiry", controller.ccExpiryController2,
                      hint: "MM / YY",
                      validator: (v) => controller.validateRequired2(v, "Expiry"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildShadowTextField(
                      context, "CVC", controller.ccCvcController2,
                      hint: "CVC",
                      validator: (v) => controller.validateRequired2(v, "CVC"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildCountryPickerField(
                      context, "Country", controller.ccCountryController2,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    double itemWidth = (constraints.maxWidth - 16) / 2;
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: itemWidth,
                          child: _buildShadowTextField(
                            context, "Expiry", controller.ccExpiryController2,
                            hint: "MM / YY", isCompact: true,
                            validator: (v) => controller.validateRequired2(v, "Expiry"),
                          ),
                        ),
                        SizedBox(
                          width: itemWidth,
                          child: _buildShadowTextField(
                            context, "CVC", controller.ccCvcController2,
                            hint: "CVC", isCompact: true,
                            validator: (v) => controller.validateRequired2(v, "CVC"),
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                  _buildCountryPickerField(
                    context, "Country", controller.ccCountryController,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Shadow TextField Widget
  Widget _buildShadowTextField(BuildContext context, String label, TextEditingController ctrl,
      {String? hint, bool isCreditCard = false, bool isCompact = false, String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (hasFocus) {
            (context as Element).markNeedsBuild();
          },
          child: Builder(
            builder: (context) {
              final bool hasFocus = Focus.of(context).hasFocus;

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: hasFocus ? [
                    BoxShadow(
                      color: AppColors.fieldsBackground,
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    )
                  ] : [],
                ),
                child: TextFormField(
                  controller: ctrl,
                  cursorColor: Colors.black,
                  style: TTextTheme.titleinputTextField(context),
                  validator: validator,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      CustomerController.editCustomerFormKey.currentState?.validate();
                    }
                  },

                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TTextTheme.btnOne(context),
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.transparent,
                    errorStyle: TTextTheme.ErrorStyle(context),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.fieldsBackground),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.fieldsBackground),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
                    ),

                    suffixIcon: isCreditCard ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(IconString.visaIcon, width: 25),
                          const SizedBox(width: 2),
                          Image.asset(IconString.materCard2, width: 25),
                          const SizedBox(width: 2),
                          Image.asset(IconString.americanExpressIcon, width: 25),
                          const SizedBox(width: 2),
                          Image.asset(IconString.discoverCardIcon, width: 25),
                        ],
                      ),
                    ) : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Country Fields
  Widget _buildCountryPickerField(BuildContext context, String label, TextEditingController ctrl) {
    final List<Country> countryList = CountryService().getAll();
    final TextEditingController searchController = TextEditingController();
    if (ctrl.text.isEmpty) {
      ctrl.text = "Australia";
    }
    Country? selectedCountry;
    try {
      selectedCountry = countryList.firstWhere(
            (c) => c.name.toLowerCase() == ctrl.text.toLowerCase(),
        orElse: () => countryList.firstWhere((c) => c.name == "Australia"),
      );
    } catch (e) {
      selectedCountry = countryList.firstWhere((c) => c.name == "Australia");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        FormField<Country>(
          initialValue: selectedCountry,
          validator: (value) {
            if (ctrl.text.isEmpty) {
              return "Please select a country";
            }
            return null;
          },
          builder: (FormFieldState<Country> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<Country>(
                    isExpanded: true,
                    value: selectedCountry,
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.quadrantalTextColor, size: 24),
                      openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded, color: AppColors.quadrantalTextColor, size: 24),
                    ),
                    selectedItemBuilder: (context) {
                      return countryList.map((Country country) {
                        return Row(
                          children: [
                            _buildCircleFlag(country.countryCode),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                country.name,
                                style: TTextTheme.btnOne(context),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    },
                    items: countryList.map((Country country) {
                      return DropdownMenuItem<Country>(
                        value: country,
                        child: Row(
                          children: [
                            _buildCircleFlag(country.countryCode),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                country.name,
                                style: TTextTheme.bodyRegular14(context),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (Country? value) {
                      if (value != null) {
                        ctrl.text = value.name;
                        state.didChange(value);
                        controller.update();
                        if (context is Element) {
                          (context as Element).markNeedsBuild();
                        }
                      }
                    },

                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: state.hasError ? AppColors.primaryColor : AppColors.fieldsBackground,
                          width: state.hasError ? 1.5 : 1,
                        ),
                        color: Colors.white,
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, -5),
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: searchController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                        child: TextFormField(
                          cursorColor: AppColors.blackColor,
                          style: TTextTheme.insidetextfieldWrittenText(context),
                          controller: searchController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            fillColor: AppColors.backgroundOfScreenColor,
                            filled: true,
                            hintText: 'Search',
                            hintStyle: TTextTheme.titleTwo(context),
                            prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: AppColors.primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: AppColors.primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value!.name.toLowerCase().contains(searchValue.toLowerCase());
                      },
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 4),
                    child: Text(
                      state.errorText ?? "",
                      style: TTextTheme.ErrorStyle(context),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
  Widget _buildCircleFlag(String code) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipOval(
        child: Image.network(
          'https://flagcdn.com/w80/${code.toLowerCase()}.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.flag, size: 14),
        ),
      ),
    );
  }


  Widget _buildCalendarFieldGeneric(
      BuildContext context,
      String label,
      TextEditingController textController,
      {required VoidCallback onTap, String hint = "Select Date", String? Function(String?)? validator}
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        TextFormField(
          controller: textController,
          readOnly: true,
          onTap: onTap,
          validator: validator,
          style: TTextTheme.pOne(context),
          decoration: InputDecoration(
            errorStyle: TTextTheme.ErrorStyle(context),
            hintText: hint,
            hintStyle: TTextTheme.pOne(context),
            filled: true,
            fillColor: AppColors.secondaryColor,
            suffixIcon: Icon(Icons.event, color: AppColors.quadrantalTextColor, size: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          ),
        ),
      ],
    );
  }

  //  Action Buttons Widgets
  Widget _buttonSection(BuildContext context, bool isMobile) {
    final double spacing = AppSizes.padding(context);
    final buttonWidth = isMobile ? double.infinity : 180.0;

    List<Widget> buttons = [
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: CustomerPrimaryBtn(
          text: 'Cancel',
          backgroundColor: Colors.white,
          textColor: AppColors.textColor,
          borderColor: AppColors.quadrantalTextColor,
          onTap: () {
            Get.back();
          },
        ),
      ),

      if (!isMobile) SizedBox(width: spacing),
      if (isMobile) SizedBox(height: spacing),
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: AddButtonOfCustomer(
          text: "Save Customer",
          icon: Image.asset(
            IconString.saveVehicleIcon,
            width: 18,
          ),
          onTap: () {
            controller.updateCustomerData(context);
          },
        ),
      ),
    ];

    return isMobile
        ? Column(children: buttons.reversed.toList())
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }
}