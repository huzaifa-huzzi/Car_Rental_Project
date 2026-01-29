import 'dart:io';

import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/CustomButtonDropOff.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/DropOffDeletePopup.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DropOffDetails extends StatelessWidget {
  final controller = Get.find<DropOffController>();
   DropOffDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);
    double padding = 24.0;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Header (Wohi jo aapne diya)
            HeaderWebDropOffWidget(
              mainTitle: 'DropOff Car Detail', // Title update kar diya
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'DropOff / Add DropOff Car',
              showSearch: isWeb,
              showSettings: isWeb,
              showAddButton: false,
              showNotification: true,
              showProfile: true,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- HEADER TEXT ---
                          Text("DropOff Car Detail", style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 6),
                          Text("Enter the specification for the car return details",
                              style: TTextTheme.titleThree(context)),
                          const SizedBox(height: 25),

                          /// ==========================================
                          /// 1. NON-EDITABLE SECTION (GREY CONTAINER)
                          /// ==========================================
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(isMobile ? 15 : 30),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundOfScreenColor, // Grey Background
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSection(context,
                                    title: TextString.titleViewCustomerStepTwo,
                                    icon: IconString.customerNameIcon,
                                    child: _buildDetailedCustomerCard(context, isMobile)),
                                const SizedBox(height: 25),

                                _buildSection(context,
                                    title: TextString.titleViewCarStepTwo,
                                    icon: IconString.pickupCarIcon,
                                    child: _buildDetailedCarCard(context, isMobile)),
                                const SizedBox(height: 25),

                                /// RENT PURPOSE & PAYMENT METHOD
                                Flex(
                                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// RENT PURPOSE SECTION
                                    Expanded(
                                      flex: isMobile ? 0 : 1,
                                      child: _buildSection(
                                        context,
                                        title: TextString.titleRentPurposeStepTwo,
                                        icon: IconString.rentPurposeIcon,
                                        child: IgnorePointer(
                                          child: _toggleStatusTag(context, TextString.subtitleRentPurposeStepTwo, controller.isPersonalUseStepTwo),
                                        ),
                                      ),
                                    ),

                                    // Space between them only on Web
                                    if (!isMobile) const SizedBox(width: 25) else const SizedBox(height: 25),

                                    /// PAYMENT METHOD SECTION
                                    Expanded(
                                      flex: isMobile ? 0 : 1,
                                      child: _buildSection(
                                        context,
                                        title: TextString.titlePaymentMethod,
                                        icon: IconString.paymentMethodIcon,
                                        child: IgnorePointer(
                                          child: _toggleStatusTag(context, TextString.subtitlePaymentMethod, controller.isManualPaymentStepTwo),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),

                                _buildSection(context,
                                    title: TextString.titleViewRentAmountStepTwo,
                                    icon: IconString.rentMoneyIcon,
                                    child: _buildInfoGrid(context, [
                                      {"label": TextString.subtitleWeeklyRentStepTwo, "controller": controller.weeklyRentControllerStepTwo, "hint": "2600 \$"},
                                      {"label": TextString.subtitleDailyRentStepTwo, "controller": controller.rentDueAmountControllerStepTwo, "hint": "2600 \$"},
                                    ], isMobile, isEditable: false)), // Non-Editable
                                const SizedBox(height: 25),

                                _buildSection(
                                  context,
                                  title: TextString.titleBondPaymentStepTwo,
                                  icon: IconString.bondPaymentIcon,
                                  child: _buildBondGrid(context, [
                                    {"label": "Bond Amount", "controller": controller.bondAmountControllerStepTwo, "hint": "2600 \$"},
                                    {"label": "Paid Bond", "controller": controller.paidBondControllerStepTwo, "hint": "600 \$"},
                                    {"label": TextString.subtitleLeftBondStepTwo, "controller": controller.dueBondAmountControllerStepTwo, "hint": "2000 \$"},
                                    {"label": "Bond Returned", "controller": controller.dueBondReturnedControllerStepTwo, "hint": "2000 \$", "isSpecial": true}, // Highlighted field
                                  ], isMobile),
                                ), // Non-Editable
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// ==========================================
                          /// 2. EDITABLE SECTION (WHITE BACKGROUND)
                          /// ==========================================
                          Text("Inspection Report", style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 20),
                          // CAR REPORT (Return Details)
                          /// CAR REPORT SECTION (Comparison Mode)
                          _buildSection(
                            context,
                            title: "Car Report",
                            icon: IconString.carReportIcon,
                            child: _buildCarReportComparison(context, isMobile),
                          ),
                          const SizedBox(height: 25),

                          // DAMAGE INSPECTION (Return)
                          _buildSection(context,
                              title: "Return Damage Inspection",
                              icon: IconString.damageInspection,
                              child: _buildDamageInspectionCard(context, isMobile)), // Editable
                          const SizedBox(height: 35),

                          // CAR PICTURES (Return)
                          _buildSection(context,
                              title: "Return Car Pictures",
                              icon: IconString.carPictureIconPickup,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Upload car return pictures", style: TTextTheme.dropdowninsideText(context)),
                                  const SizedBox(height: 10),
                                  _imageBox(context),
                                ],
                              )),
                          const SizedBox(height: 35),

                          // RENT TIME (Return Time)
                          _buildSection(context,
                              title: "Return Time",
                              icon: IconString.rentTimeIcon,
                              child: _buildRentTimeSection(context, isMobile)),
                          const SizedBox(height: 35),

                          // SIGNATURES
                          _buildSection(context,
                              title: "Signatures",
                              icon: IconString.signatureIcon,
                              child: _buildSignatureSection(context, isMobile)),

                          const SizedBox(height: 40),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  /// -------- Extra Widgets -------- ///
  Widget _buildInfoGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile, {bool isEditable = true}) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile ? (availableWidth - 100) : (availableWidth / 5);

        return SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['label']!, style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  controller: item['controller'],
                  enabled: isEditable,
                  readOnly: !isEditable,
                  style: TTextTheme.insidetextfieldWrittenText(context),
                  decoration: InputDecoration(
                    hintText: item['hint'],
                    prefixIcon: item['hasIcon'] == true
                        ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 8),
                      child: Icon(Icons.check_circle_outline,
                          size: 18,
                          color: AppColors.textColor),
                    )
                        : null,
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 40,
                      minHeight: 0,
                    ),
                    hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // pickup Note Field
  Widget _buildCommentField(BuildContext context, String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            cursorColor: AppColors.blackColor,
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, hintStyle: TTextTheme.pOne(context)),
          ),
        ),
      ],
    );
  }

   // Bond Grid
  Widget _buildBondGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile ? (availableWidth - 100) : (availableWidth / 5.5);
        bool isSpecial = item['isSpecial'] == true;

        Widget fieldContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['label']!, style: TTextTheme.dropdowninsideText(context)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextFormField(
                controller: item['controller'],
                readOnly: true,
                style: TTextTheme.insidetextfieldWrittenText(context),
                decoration: InputDecoration(
                  hintText: item['hint'],
                  hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        );

        return SizedBox(
          width: itemWidth,
          child: isSpecial
              ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfPickupsWidget,
              borderRadius: BorderRadius.circular(10),
            ),
            child: fieldContent,
          )
              : fieldContent,
        );
      }).toList(),
    );
  }

  // Damage Inspection
  Widget _buildDamageInspectionCard(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.quadrantalTextColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 10,
            children: controller.damageTypes.map((type) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: type['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      type['id'].toString(),
                      style: TTextTheme.btnNumbering(context),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    type['label'],
                    style: TTextTheme.titleSix(context),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth > 600 ? 600 : constraints.maxWidth;

              return Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    ImageString.carDamageInspectionImage,
                    width: width,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Rent time Section
  Widget _buildRentTimeSection(BuildContext context, bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.subtitleAgreementTimeStepTwo,
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.startDateControllerStepTwo, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.startTimeControllerStepTwo, "12:12 PM",context),

          const SizedBox(height: 24),

          Text(TextString.subtitleAgreementEndTimeStepTwo,
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.endDateControllerStepTwo, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.endTimeControllerStepTwo, "12:12 PM",context),
        ],
      );
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.subtitleAgreementTimeStepTwo,
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.startDateControllerStepTwo, "02/12/2025",context)),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.startTimeControllerStepTwo, "12:12 PM",context)),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 180,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Container(height: 1.5, color: AppColors.iconsBackgroundColor)),
                  const SizedBox(width: 5),
                  const Icon(Icons.access_time, color: AppColors.primaryColor, size: 22),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 1.5, color:AppColors.iconsBackgroundColor),
                        const Positioned(
                          right: -5,
                          child: Icon(Icons.chevron_right, color: AppColors.iconsBackgroundColor, size: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.subtitleAgreementEndTimeStepTwo,
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.endDateControllerStepTwo, "02/12/2025",context)),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.endTimeControllerStepTwo, "12:12 PM",context)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editableTimeField(
      TextEditingController textController,
      String hint,
      BuildContext context,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: textController,
        readOnly: true,
        enableInteractiveSelection: false,
        showCursor: false,

        cursorColor: AppColors.blackColor,
        style: TTextTheme.insidetextfieldWrittenText(context),

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TTextTheme.insidetextfieldWrittenText(context),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildCarReportComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 40) / 2;

      return Wrap(
        spacing: 40,
        runSpacing: 25,
        children: [
          /// LEFT SIDE:
          Container(
            width: columnWidth,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _buildReadOnlyField("Pickup ODO", controller.odoControllerStepTwo.text, context),
                const SizedBox(height: 15),
                _buildReadOnlyField("Pickup Fuel Level", controller.fuelLevelControllerStepTwo.text, context, hasIcon: true),
                const SizedBox(height: 15),
                _buildReadOnlyField("Pickup Exterior Cleanliness", controller.exteriorCleanlinessControllerStepTwo.text, context, hasIcon: true),
                const SizedBox(height: 15),
                _buildReadOnlyField("Pickup Interior Cleanliness", controller.interiorCleanlinessControllerStepTwo.text, context, hasIcon: true),
              ],
            ),
          ),

          /// RIGHT SIDE DROPOFF
          Padding(
            padding: EdgeInsets.only(top: isMobile ? 0 : 15),
            child: SizedBox(
              width: columnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMiniInputField("Dropoff ODO", "12457678", columnWidth, controller.odoControllerDropOff, context),
                  const SizedBox(height: 18),
                  _buildReportDropdown(
                      "Dropoff Fuel Level",
                      ["Full (100%)", "High (75%)", "Half (50%)", "Low (25%)", "Empty (0%)"],
                      columnWidth,
                      controller.fuelLevelControllerDropOff,
                      context
                  ),
                  const SizedBox(height: 18),
                  _buildReportDropdown(
                      "Dropoff Exterior Cleanliness",
                      ["Excellent", "Good", "Average", "Dirty"],
                      columnWidth,
                      controller.exteriorCleanlinessControllerDropOff,
                      context
                  ),
                  const SizedBox(height: 18),
                  _buildReportDropdown(
                      "Dropoff Interior Cleanliness",
                      ["Excellent", "Good", "Average", "Dirty"],
                      columnWidth,
                      controller.interiorCleanlinessControllerDropOff,
                      context
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildReadOnlyField(String label, String value, BuildContext context, {bool hasIcon = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.titleTwo(context)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              if (hasIcon) ...[
                const Icon(Icons.check_circle_outline, size: 16, color: Colors.black),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  value.isEmpty ? "N/A" : value,
                  style: TTextTheme.insidetextfieldWrittenText(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Signature Section
  Widget _buildSignatureSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool stackVertical = constraints.maxWidth < 600;

        double cardWidth = stackVertical
            ? constraints.maxWidth
            : (constraints.maxWidth - 40) / 2;

        return Wrap(
          spacing: 40,
          runSpacing: 20,
          children: [
            SizedBox(
              width: cardWidth,
              child: _signatureCard(TextString.subtitleOwnerSignatureStepTwo, controller.ownerNameController),
            ),
            SizedBox(
              width: cardWidth,
              child: _signatureCard(TextString.subtitleHirerSignatureStepTwo, controller.hirerNameController),
            ),
          ],
        );
      },
    );
  }

  Widget _signatureCard(String title, TextEditingController nameController) {
    return LayoutBuilder(
      builder: (context, innerConstraints) {
        bool forceVertical = innerConstraints.maxWidth < 300;

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primaryColor, width: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TTextTheme.titleRadios(context)),
              const SizedBox(height: 20),

              Flex(
                direction: forceVertical ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100, minHeight: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 20),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text(TextString.subtitleFullNameStepTwo, style: TTextTheme.titleFullName(context)),
                      ],
                    ),
                  ),

                  if (forceVertical) const SizedBox(height: 15) else const SizedBox(width: 10),

                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100, minHeight: 30),
                          child: Column(
                            crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(height: 20),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text(TextString.subtitleSignStepTwo, style: TTextTheme.titleFullName(context)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Image Sections
  Widget _imageBox(BuildContext context) {
    bool isMobileView = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.tertiaryTextColor,
          width: 1.5,
        ),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final double itemWidth = isMobileView ? (constraints.maxWidth - 24) / 2 : 110;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(10, (index) {
            return Container(
              height: 100,
              width: itemWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.tertiaryTextColor, width: 1),
                image: DecorationImage(
                  image: AssetImage(ImageString.astonPic),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildSection(BuildContext context, {
    required String title,
    required String icon,
    required Widget child,
    bool showBadge = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(icon, width: 20, height: 20),
              const SizedBox(width: 10),

              Expanded(
                child: Text(
                    title,
                    style: TTextTheme.h6Style(context)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        child,
      ],
    );
  }

  // For Web
  Widget _buildDetailedCustomerCard(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildProfileImage(30, 40),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(TextString.titleCustomerImageStepTwo, style: TTextTheme.titleOne(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(TextString.titleDriverStepTwo, style: TTextTheme.btnTwo(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(width: 60, child: PrimaryBthDropOff(text: "View", onTap: () {})),
            ],
          ),
          SizedBox(height: 15),
          /// Scrollable Info for Mobile
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics:  BouncingScrollPhysics(),
            child: Row(
              children: [
                _infoBlock(IconString.smsIcon, TextString.titleEmailStepTwo, "Contact@SoftSnip.com.au", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.callIcon, TextString.titleContactStepTwo, "+12 3456 7890", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.location, TextString.titleAddressStepTwo, "Toronto, California, 1234", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.nidIcon, TextString.titleNidStepTwo, "123 456 789", context),
                const SizedBox(width: 12),
              ],
            ),
          ),
        ],
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          bool useScroll = constraints.maxWidth < 1000;

          Widget content = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildCustomerRowContent(context, false),
          );

          return useScroll
              ? SingleChildScrollView(scrollDirection: Axis.horizontal, child: content)
              : content;
        },
      ),
    );
  }

  // Customer Card for mobile
  List<Widget> _buildCustomerRowContent(BuildContext context, bool isMobile) {
    return [
      /// PROFILE
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProfileImage(50, 50),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.titleCustomerImageStepTwo, style: TTextTheme.titleOne(context)),
              Text(TextString.titleDriverStepTwo, style: TTextTheme.btnTwo(context)),
            ],
          ),
        ],
      ),

      /// INFO BLOCKS
      const SizedBox(width: 20),
      _infoBlock(IconString.smsIcon, TextString.titleEmailStepTwo, "Contact@SoftSnip.com.au", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.callIcon,  TextString.titleContactStepTwo, "+12 3456 7890", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.location, TextString.titleAddressStepTwo, "Toronto, California, 1234", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.nidIcon, TextString.titleNidStepTwo, "123 456 789", context),
      const SizedBox(width: 18),

      /// VIEW BUTTON
      PrimaryBthDropOff(text: "View", width: 90, onTap: () {}),
    ];
  }

  // profile image at the start
  Widget _buildProfileImage(double w, double h) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(ImageString.customerUser, width: w, height: h, fit: BoxFit.cover),
      ),
    );
  }


  // detail Card for web
  Widget _buildDetailedCarCard(BuildContext context, bool isMobile) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: isMobile ? 18 : 15),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isMobile
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Center(child: Image.asset(ImageString.astonPic, width: 100)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(TextString.titleCarImageStepTwo, style: TTextTheme.titleSix(context), overflow: TextOverflow.ellipsis),
                            Text(TextString.titleCarImage2StepTwo, style: TTextTheme.h3Style(context), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryBthDropOff(text: "View", width: 65, onTap: () {}),
              ],
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _infoRowTag(label: TextString.titleRegistrationStepTwo, value: "1234567890", context: context),
                  const SizedBox(width: 10),
                  _infoRowTag(
                    label:TextString.titleVinStepTwo,
                    value: "JTNBA3HK003001234",
                    labelColor: AppColors.backgroundOfVin,
                    context: context,
                  ),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label:TextString.titleTransmissionStepTwo, value: "Auto", imagePath: IconString.transmissionIcon),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleCapacityStepTwo, value: "2 seats", imagePath: IconString.capacityIcon),
                  const SizedBox(width: 25),
                  _buildPriceColumn(context),
                ],
              ),
            ),
          ],
        )
            :  LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            bool enableScroll = maxWidth < 750;

            Widget content = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildCarContent(context, enableScroll),
            );


            return enableScroll
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 970),
                child: content,
              ),
            )
                : content;
          },
        )

    );
  }

  // detail card for mobile
  List<Widget> _buildCarContent(BuildContext context, bool enableScroll) {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: enableScroll ? 70 : 130,
            alignment: Alignment.center,
            child: Image.asset(
              ImageString.astonPic,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(TextString.titleCarImageStepTwo, style: TTextTheme.titleFour(context)),
              Text(TextString.titleCarImage2StepTwo, style: TTextTheme.h3Style(context)),

              if (!enableScroll) ...[
                const SizedBox(height: 12),
                _infoRowTag(label: TextString.titleRegistrationStepTwo, value: "1234567890", context: context),
                const SizedBox(height: 8),
                _infoRowTag(
                  label:TextString.titleVinStepTwo,
                  value: "JTNBA3HK003001234",
                  labelColor: AppColors.backgroundOfVin,
                  context: context,
                ),
              ],
            ],
          ),
        ],
      ),

      if (enableScroll)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _infoRowTag(label: TextString.titleRegistrationStepTwo, value: "1234567890", context: context),
            const SizedBox(width: 10),
            _infoRowTag(
              label: TextString.titleVinStepTwo,
              value: "JTNBA3HK003001234",
              labelColor: AppColors.backgroundOfVin,
              context: context,
            ),
          ],
        ),

      _buildSpecColumn(context, label: TextString.titleTransmissionStepTwo, value: "Automatic", imagePath: IconString.transmissionIcon),
      _buildSpecColumn(context, label: TextString.titleCapacityStepTwo, value: "2 seats", imagePath: IconString.capacityIcon),

      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceColumn(context),
          const SizedBox(width: 25),
          PrimaryBthDropOff(text: "View", width: 100, onTap: () {}),
        ],
      ),
    ];
  }

  // price block of car
  Widget _buildPriceColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(TextString.titlePriceStepTwo, style:  TTextTheme.titleFour(context)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("\$130", style:TTextTheme.h5Style(context)),
            Text("/Weekly", style: TTextTheme.titleTwo(context)),
          ],
        ),
      ],
    );
  }


  Widget _buildSpecColumn(BuildContext context, {
    required String label,
    required String value,
    required String imagePath,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            imagePath,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TTextTheme.titleFour(context),
        ),
        Text(
          value,
          style: TTextTheme.titleSmallTexts(context),
        ),
      ],
    );
  }


  Widget _infoRowTag({
    required String label,
    required String value,
    Color labelColor = AppColors.textColor,
    required BuildContext context,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// LABEL BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: labelColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
          ),
          child: Text(
            label,
            style: TTextTheme.titleeight(context),
          ),
        ),

        /// VALUE BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Text(
            value,
            style: TTextTheme.titleseven(context),
          ),
        ),
      ],
    );
  }



  Widget _infoBlock(String imagePath, String label, String value, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// IMAGE CONTAINER
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            imagePath,
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8),

        /// TEXT SECTION
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TTextTheme.pFour(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                value,
                style: TTextTheme.pOne(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _toggleStatusTag(BuildContext context, String text, RxBool stateVariable) {
    return Obx(() => GestureDetector(
      onTap: () {
        stateVariable.value = !stateVariable.value;
      },
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              stateVariable.value ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 16,
              color: AppColors.blackColor,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TTextTheme.titleRadios(context),
            ),
          ],
        ),
      ),
    ));
  }


  // Input Fields
  Widget _buildMiniInputField(String label, String hint, double width, TextEditingController txtController, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              label,
              style: TTextTheme.titleTwo(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis
          ),
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              cursorColor: AppColors.blackColor,
              controller: txtController,
              textAlignVertical: TextAlignVertical.center,
              style: TTextTheme.insidetextfieldWrittenText(context),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildReportDropdown(String label, List<String> items, double width, TextEditingController txtController, BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TTextTheme.titleTwo(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          PopupMenuButton<String>(
            initialValue: null,
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: AppColors.secondaryColor,
            constraints: BoxConstraints(
              minWidth: width,
              maxWidth: width,
            ),
            onSelected: (val) {
              txtController.text = val;
              txtController.notifyListeners();
            },
            itemBuilder: (context) => items.asMap().entries.map((entry) {
              return _buildFilterPopupItem(
                  entry.value,
                  context,
                  isLast: entry.key == items.length - 1
              );
            }).toList(),
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: txtController,
                      builder: (context, value, _) {
                        return Text(
                          txtController.text.isEmpty ? items.first : txtController.text,
                          style: TTextTheme.dropdowninsideText(context),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ),
                  Image.asset(IconString.dropdownIcon, color: Colors.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  PopupMenuItem<String> _buildFilterPopupItem(String text, BuildContext context, {bool isLast = false}) {
    return PopupMenuItem<String>(
      value: text,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              text,
              style: TTextTheme.titleTwo(context),
            ),
          ),
          if (!isLast)
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppColors.quadrantalTextColor,
            ),
        ],
      ),
    );
  }




}


