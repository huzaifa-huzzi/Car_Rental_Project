import 'dart:io';
import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/AddButtonOfCustomers.dart';
import 'package:car_rental_project/Customers/ReusableWidgetOfCustomers/CustomerPrimaryBtn.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';

class AddCustomerWidget extends StatelessWidget {
  AddCustomerWidget({super.key});

  final CustomerController controller = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

    return Center(
      child: Container(
        width: 800,
        margin: EdgeInsets.all(AppSizes.padding(context)),
        padding: EdgeInsets.all(AppSizes.padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// CUSTOMER HEADER
              Text(TextString.addCustomerTitle, style: TTextTheme.h7Style(context)),
              SizedBox(height: AppSizes.verticalPadding(context) * 0.3),
              Text(TextString.addCustomerSubtitle, style: TTextTheme.titleThree(context)),
              SizedBox(height: spacing/2),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
              SizedBox(height: spacing),

              /// PROFILE IMAGE UPLOAD
              Align(
                alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                child: _buildProfilePhotoPicker(context),
              ),
              SizedBox(height: spacing * 1.5),

              /// BASIC INFO GRID FORM
              _buildResponsiveGrid(context, [
                _buildTextField(context, "Customer Given Name", controller.givenNameController),
                _buildTextField(context, "Customer Surname", controller.surnameController),
                _buildTextField(context, "Date of Birth", controller.dobController, hint: "DD/MM/YYYY"),
                _buildTextField(context, "Customer Contact Number", controller.contactController),
                _buildTextField(context, "Customer Email", controller.emailController),
                _buildTextField(context, "Customer Address", controller.addressController),
              ]),

              SizedBox(height: spacing),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              /// CUSTOMER NOTE
              SizedBox(height: spacing),
              Text(TextString.addCustomerNote, style: TTextTheme.btnSix(context)),
              SizedBox(height: 8),
              _buildLargeTextField(context, TextString.addCustomerNoteSubtitle, controller.noteController),

              SizedBox(height: spacing),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              /// LICENSE DETAILS
              SizedBox(height: spacing),
              Text(TextString.addCustomerLicenseTitle, style: TTextTheme.btnSix(context)),
              SizedBox(height: spacing),
              _buildResponsiveGrid(context, [
                _buildTextField(context, "Driver License Number", controller.licenseNumberController),
                _buildTextField(context, "License Expiry Date", controller.licenseExpiryController),
                _buildTextField(context, "Card Number", controller.licenseCardNumberController),
              ]),

              SizedBox(height: spacing),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              /// DOCUMENTS UPLOAD
              SizedBox(height: spacing),
              Text(TextString.addCustomerUploadDocument, style: TTextTheme.btnSix(context)),
              SizedBox(height: spacing),
              _documentsSection(context),

              SizedBox(height: spacing),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),

              /// CARD DETAILS
              Text(TextString.addCustomerCarDetails, style: TTextTheme.btnSix(context)),
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

              /// BUTTON
              _buttonSection(context, isMobile),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------- Extra Widgets (Helpers) --------///

  // Profile Photo Picker Widget
  Widget _buildProfilePhotoPicker(BuildContext context,) {
    return Obx(() {
      final hasImg = controller.profileImage.value != null;
      return GestureDetector(
        onTap: () => controller.pickProfileImage(),
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.iconsBackgroundColor, width: 1),
          ),
          child: hasImg
              ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: kIsWeb
                ? Image.memory(controller.profileImage.value!.bytes!, fit: BoxFit.cover)
                : Image.file(File(controller.profileImage.value!.path!), fit: BoxFit.cover),
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
              Text(TextString.addCustomerPhotoText, style: TTextTheme.documnetIsnideSmallText(context)),
              Text(TextString.uploadSubtitle, style: TTextTheme.documnetIsnideSmallText2(context)),
            ],
          ),
        ),
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

  // Standard TextField
  Widget _buildTextField(BuildContext context, String label, TextEditingController ctrl, {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          cursorColor: AppColors.blackColor,
          style: TTextTheme.titleTwo(context),
          decoration: InputDecoration(
            hintText: hint ?? "Write $label...",
            hintStyle: TTextTheme.titleFour(context),
            filled: true,
            fillColor: AppColors.secondaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Customer TextField Widget
  Widget _buildLargeTextField(BuildContext context, String hint, TextEditingController ctrl) {
    return TextField(
      cursorColor: AppColors.blackColor,
      controller: ctrl,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TTextTheme.titleFour(context),
        filled: true,
        fillColor: AppColors.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //  Documents Section Widgets
  Widget _documentsSection(BuildContext context) {
    final isMobile = AppSizes.isMobile(context);
    final double spacing = AppSizes.padding(context);

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
              const SizedBox(height: 10),
              _documentBox(context, i, controller.selectedDocuments[i]),
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
        Text(TextString.addCustomerPersonalDocumentText, style: TTextTheme.titleTwo(context)),
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
    bool _isImageFile(String fileName) {
      final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
      final lowerCaseName = fileName.toLowerCase();
      return imageExtensions.any((ext) => lowerCaseName.endsWith(ext));
    }

    return Obx(() {
      final docValue = selectedDoc.value;
      final bool isUploaded = docValue != null;
      final bool isImage = isUploaded && _isImageFile(docValue!.name);
      final String hintText = "Document ${index + 1}";

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
                        docValue!.name,
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
                      onTap: () => controller.removeDocumentSlot(index),
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

  // Card Selection Section
  Widget _buildCardSelectionRow(BuildContext context) {
    return Obx(() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(controller.totalCardsAdd2.value, (index) => GestureDetector(
            onTap: () => controller.selectedCardIndex.value = index,
            child: _cardTab(context, "Card ${index + 1}", controller.selectedCardIndex.value == index),
          )),

          if (controller.totalCardsAdd2.value < 5)
            GestureDetector(
              onTap: () => controller.addNewCardSlot(),
              child: Container(
                width: 36,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondTextColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(IconString.addIcon, color: AppColors.quadrantalTextColor),
                ),
              ),
            ),
        ],
      ),
    ));
  }

  // Card Tab Widget
  Widget _cardTab(BuildContext context, String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 120,
      padding: const EdgeInsets.all(12),
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
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
              IconString.cardIcon,
              color: isSelected ? AppColors.cardsHovering : AppColors.quadrantalTextColor
          ),
          const SizedBox(height: 8),
          Text(
              label,
              style: TTextTheme.btnOne(context).copyWith(
                  color: isSelected ? AppColors.cardsHovering : AppColors.secondTextColor
              )
          ),
        ],
      ),
    );
  }

  //  Card Form Widget
  Widget _buildCardForm(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShadowTextField(context,TextString.addCustomerCardNumber , controller.ccNumberController, hint: "1234 1234 1234 1234", isCreditCard: true),
            const SizedBox(height: 16),
            _buildShadowTextField(context,TextString.addCustomerCardHolerName , controller.ccHolderController, hint: "Softsnip"),
            const SizedBox(height: 16),

            LayoutBuilder(builder: (context, constraints) {
              double itemWidth = constraints.maxWidth < 350 ? constraints.maxWidth : (constraints.maxWidth - 16) / 2;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(width: itemWidth, child: _buildShadowTextField(context,TextString.addCustomerCardExpiry , controller.ccExpiryController, hint: "MM / YY", isCompact: true)),
                  SizedBox(width: itemWidth, child: _buildShadowTextField(context,TextString.addCustomerCvc , controller.ccCvcController, hint: "CVC", isCompact: true)),
                ],
              );
            }),

            const SizedBox(height: 16),
            _buildShadowTextField(context, TextString.addCustomerCountry, controller.ccCountryController, hint: "United States"),
          ],
        ),
      ),
    );
  }

  //   Shadow TextField Widget
  Widget _buildShadowTextField(BuildContext context, String label, TextEditingController ctrl, {String? hint, bool isCreditCard = false, bool isCompact = false}) {
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
                      spreadRadius: 3,
                      offset: const Offset(0, 3),
                    )
                  ] : [],
                ),
                child: TextField(
                  controller: ctrl,
                  cursorColor: Colors.black,
                  style: const TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle:  TTextTheme.btnOne(context),
                    filled: true,
                    fillColor: Colors.white,
                    hoverColor: Colors.transparent,

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

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColors.fieldsBackground),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color:AppColors.fieldsBackground),
                    ),

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

  //  Action Buttons Widgets
  Widget _buttonSection(BuildContext context, bool isMobile) {
    final double spacing = AppSizes.padding(context);
    final buttonWidth = isMobile ? double.infinity : 180.0;

    List<Widget> buttons = [
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: CustomerPrimaryBtn(
          text: TextString.addCustomerCancel,
          backgroundColor: Colors.white,
          textColor: AppColors.textColor,
          borderColor: AppColors.quadrantalTextColor,
          onTap: () {},
        ),
      ),
      if (!isMobile) SizedBox(width: spacing),
      if (isMobile) SizedBox(height: spacing),
      SizedBox(
        width: buttonWidth,
        height: 45,
        child: AddButtonOfCustomer(
          text: TextString.addCustomerSaveButton,
          icon: Image.asset(
            IconString.saveVehicleIcon,
          ),
          onTap: () {
          },
        ),
      ),
    ];

    return isMobile
        ? Column(children: buttons)
        : Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }
}