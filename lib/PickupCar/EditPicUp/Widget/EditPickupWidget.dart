import 'dart:io';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/PickupDeletePopup.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPickupWidget extends StatelessWidget {

  final controller = Get.find<PickupCarController>();

  EditPickupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 15 : 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///  PAGE TITLE
            _buildPageHeader(context, isMobile),
            const SizedBox(height: 25),

            ///  CUSTOMER NAME SECTION
            _buildSection(context,
                title: TextString.titleViewEditCustomer,
                icon: IconString.customerNameIcon,
                child: _buildDetailedCustomerCard(context, isMobile)),
            const SizedBox(height: 25),

            ///  CAR DETAILS SECTION
            _buildSection(context,
                title: TextString.titleViewEditCar,
                icon: IconString.pickupCarIcon,
                child: _buildDetailedCarCard(context, isMobile)),
            const SizedBox(height: 25),

            ///  RENT PURPOSE Section
            _buildSection(context,
              title: TextString.titleRentPurpose,
              icon: IconString.rentPurposeIcon,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isVerySmall = constraints.maxWidth < 400;

                  return Obx(() {
                    return isVerySmall
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRadioOption(context,TextString.subtitleRentEditPurpose, controller.isPersonalEditUse.value, () {
                          controller.isPersonalEditUse.value = true;
                        }),
                        const SizedBox(height: 15),
                        _buildRadioOption(context, TextString.subtitleRentEditCommercial, !controller.isPersonalEditUse.value, () {
                          controller.isPersonalEditUse.value = false;
                        }),
                      ],
                    )
                        : Row(
                      children: [
                        _buildRadioOption(context,TextString.subtitleRentEditPurpose, controller.isPersonalEditUse.value, () {
                          controller.isPersonalEditUse.value = true;
                        }),
                        const SizedBox(width: 40),
                        _buildRadioOption(context,TextString.subtitleRentEditCommercial , !controller.isPersonalEditUse.value, () {
                          controller.isPersonalEditUse.value = false;
                        }),
                      ],
                    );
                  });
                },
              ),
            ),
            const SizedBox(height: 25),

            ///  PAYMENT METHOD Section
            _buildSection(context,
              title: TextString.titlePaymentEditMethod,
              icon: IconString.paymentMethodIcon,
              child: Obx(() => Wrap(
                spacing: 40,
                runSpacing: 15,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  _buildRadioOption(
                      context,
                      TextString.subtitlePaymentEditMethod,
                      controller.isManualEditPayment.value == true,
                          () {
                        controller.isManualEditPayment.value = true;
                      }
                  ),

                  _buildRadioOption(
                      context,
                      TextString.subtitlePaymentEditAutoMethod,
                      controller.isManualEditPayment.value == false,
                          () {
                        controller.isManualEditPayment.value = false;
                      }
                  ),
                ],
              )),
            ),
            const SizedBox(height: 25),

            ///  RENT AMOUNT SECTION
            _buildSection(context,
                title: TextString.titleViewEditRentAmount,
                icon: IconString.rentMoneyIcon,
                child: _buildInfoGrid(context, [
                  {"label": TextString.subtitleWeeklyEditRent, "controller": controller.weeklyRentEditController2, "hint": "2600 \$"},
                  {"label": TextString.subtitleDailyEditRent, "controller": controller.dailyRentEditController2, "hint": "2600 \$"},
                ], isMobile)),
            const SizedBox(height: 25),

            ///  BOND PAYMENT SECTION
            _buildSection(context,
                title: TextString.titleBondEditPayment,
                icon: IconString.bondPaymentIcon,
                child: _buildInfoGrid(context, [
                  {"label": TextString.subtitleBondEditAmount , "controller": controller.bondAmountEditController2, "hint": "2600 \$"},
                  {"label":  TextString.subtitlePaidEditBond , "controller": controller.paidBondEditController2, "hint": "600 \$"},
                  {"label": TextString.subtitleLeftEditBond, "controller": controller.bondAmountEditController2, "hint": "2000 \$"},
                ], isMobile)),
            const SizedBox(height: 25),

            ///  CAR REPORT SECTION
            _buildSection(
              context,
              title: TextString.titleCarReport,
              icon: IconString.carReportIcon,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = MediaQuery.of(context).size.width;

                  double itemWidth;
                  if (screenWidth < 600) {
                    itemWidth = constraints.maxWidth;
                  } else if (screenWidth < 1100) {
                    itemWidth = (constraints.maxWidth - 20) / 2;
                  } else {
                    itemWidth = (constraints.maxWidth - 45) / 4;
                  }

                  return Wrap(
                    spacing: 15,
                    runSpacing: 20,
                    children: [
                      _buildMiniInputField(TextString.subtitlePickupEditOdo, "12457678", itemWidth, controller.odoEditController, context),

                      _buildReportDropdown(
                          TextString.subtitlePickFuelEditLevel,
                          ["Full (100%)", "High (75%)", "Half (50%)", "Low (25%)", "Empty (0%)"],
                          itemWidth,
                          controller.fuelLevelEditController,
                          context
                      ),

                      _buildReportDropdown(
                          TextString.subtitleInteriorEditCleanliness,
                          ["Excellent", "Good", "Average", "Dirty"],
                          itemWidth,
                          controller.interiorCleanlinessEditController,
                          context
                      ),

                      _buildReportDropdown(
                          TextString.subtitleExteriorEditCleanliness,
                          ["Excellent", "Good", "Average", "Dirty"],
                          itemWidth,
                          controller.exteriorCleanlinessEditController,
                          context
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 25),

            ///  DAMAGE INSPECTION
            _buildSection(
              context,
              title: TextString.titleDamageInspection,
              icon: IconString.damageInspection,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return _buildDamageInspectionCard(context, constraints.maxWidth);
                },
              ),
            ),
            const SizedBox(height: 25),

            ///  PICKUP NOTE
            _buildSection(
              context,
              title: TextString.titlePickupEditNote,
              icon: IconString.pickupNote,
              child: _buildCommentField(
                  context,
                  TextString.subtitlePickupEditComments,
                  controller.additionalCommentsEditController,
                  TextString.subtitleViewEditPickup
              ),
            ),
            const SizedBox(height: 25),

            ///  CAR PICTURE SECTION
            _buildSection(context,
                title: TextString.titleCarEditPicture,
                icon: IconString.carPictureIconPickup,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.subtitleCarEditPicture, style: TTextTheme.dropdowninsideText(context)),
                    const SizedBox(height: 10),
                    _imageBox(context),
                  ],
                )),
            const SizedBox(height: 25),

            ///  RENT TIME
            _buildSection(context,
                title: TextString.titleRentTime,
                icon: IconString.rentTimeIcon,
                showBadge: true,
                child: _buildRentTimeSection(context, isMobile)),
            const SizedBox(height: 25),

            ///  SIGNATURE SECTION
            _buildSection(context,
                title: TextString.titleSignature,
                icon: IconString.signatureIcon,
                child: _buildSignatureSection(context, isMobile)),

            const SizedBox(height: 40),

            ///  Buttons
            _buttonSection(context, isMobile),


            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  /// -------- Extra Widgets -------- ///
  // Grids of the TextFields
  Widget _buildInfoGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile
            ? (availableWidth - 60)
            : (availableWidth / 4.5);

        return SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['label']!,
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  cursorColor: AppColors.blackColor,
                  controller: item['controller'],
                  textAlignVertical: TextAlignVertical.center,
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
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, hintStyle: TTextTheme.titleFour(context)),
          ),
        ),
      ],
    );
  }

  // Damage Inspection
  Widget _buildDamageInspectionCard(BuildContext context, double cardWidth) {
    bool isMobile = AppSizes.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 15,
          runSpacing: 15,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildToggleWidget(context),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.damageEditPoint.map((type) {
                  bool isSelected = controller.selectedDamageEditType.value == type['id'];
                  return GestureDetector(
                    onTap: () {
                      if (controller.isDamageInspectionEditOpen.value) {
                        controller.selectedDamageEditType.value = type['id'];
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.secondaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(radius: 10, backgroundColor: type['color'],
                              child: Text(type['id'].toString(), style:TTextTheme.btnNumbering(context))),
                          const SizedBox(width: 4),
                          Text(type['label'], style: TTextTheme.titleSix(context)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Obx(() {
          double width = cardWidth > 500 ? 500 : cardWidth;
          double height = width * 0.75;

          return IgnorePointer(
            ignoring: !controller.isDamageInspectionEditOpen.value,
            child: Opacity(
              opacity: controller.isDamageInspectionEditOpen.value ? 1.0 : 0.4,
              child: Align(
                alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                child: GestureDetector(

                  onTapDown: (details) {
                    double dx = details.localPosition.dx / width;
                    double dy = details.localPosition.dy / height;

                    int existingIndex = controller.damageEditPoints.indexWhere((p) =>
                    (p.dx - dx).abs() < 0.05 && (p.dy - dy).abs() < 0.05
                    );

                    if (existingIndex != -1) {
                      controller.damageEditPoints.removeAt(existingIndex);
                    } else {
                      var selectedType = controller.damageEditPoint.firstWhere(
                              (t) => t['id'] == controller.selectedDamageEditType.value);

                      controller.damageEditPoints.add(DamagePoint(
                        dx: dx,
                        dy: dy,
                        typeId: selectedType['id'],
                        color: selectedType['color'],
                      ));
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                          ImageString.carDamageInspectionImage,
                          width: width,
                          height: height,
                          fit: BoxFit.contain
                      ),
                      ...controller.damageEditPoints.map((point) => Positioned(
                        left: (point.dx * width) - 10,
                        top: (point.dy * height) - 10,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: point.color,
                          child: Text(
                              point.typeId.toString(),
                              style: TTextTheme.btnNumbering(context),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }
  Widget _buildToggleWidget(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => controller.isDamageInspectionEditOpen.value = !controller.isDamageInspectionEditOpen.value,
      child: Container(
        width: 70,
        height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: controller.isDamageInspectionEditOpen.value ? AppColors.primaryColor : AppColors.quadrantalTextColor,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: controller.isDamageInspectionEditOpen.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              ),
            ),
            Align(
              alignment: controller.isDamageInspectionEditOpen.value ? const Alignment(-0.6, 0) : const Alignment(0.6, 0),
              child: Text(
                controller.isDamageInspectionEditOpen.value ? "Yes" : "No",
                style:TTextTheme.btnWhiteColor(context),
              ),
            ),
          ],
        ),
      ),
    ));
  }


  // Start Header
  Widget _buildPageHeader(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TITLE SECTION
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    IconString.editIcon2,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),

                  Flexible(
                    child: Text(
                     TextString.titleViewEditPick,
                      style: TTextTheme.h6Style(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              Text(
                TextString.titleViewEditSubtitle,
                style: TTextTheme.titleThree(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        /// BUTTONS SECTION
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddPickUpButton(
              text: isMobile ? "" : "Edit",
              iconPath: IconString.editIcon,
              iconColor: AppColors.primaryColor,
              width: isMobile ? 38 : 110,
              height: 38,
              textColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
              onTap: () {},
            ),
            const SizedBox(width: 6),

            AddPickUpButton(
              text: isMobile ? "" : "Delete",
              iconPath: IconString.deleteIcon,
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 38 : 110,
              height: 38,
              textColor: AppColors.secondTextColor,
              borderColor: AppColors.sideBoxesColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ResponsiveDeletePickupDialog(
                      onCancel: () => Navigator.pop(context),
                      onConfirm: () => Navigator.pop(context),
                    );
                  },
                );
              },
            ),
          ],
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
          Text("Agreement Start Time",
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.startDateEditController2, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.startTimeEditController2, "12:12 PM",context),

          const SizedBox(height: 24),

          Text("Agreement End Time",
              style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 8),
          _editableTimeField(controller.endDateEditController2, "02/12/2025",context),
          const SizedBox(height: 8),
          _editableTimeField(controller.endTimeEditController2, "12:12 PM",context),
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
              Text("Agreement Start Time",
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.startDateEditController2, "02/12/2025",context)),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.startTimeEditController2, "12:12 PM",context)),
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
              Text("Agreement End Time",
                  style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.endDateEditController2, "02/12/2025",context)),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.endTimeEditController2, "12:12 PM",context)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editableTimeField(TextEditingController textController, String hint,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: textController,
        style: TTextTheme.insidetextfieldWrittenText(context),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TTextTheme.insidetextfieldWrittenText(context),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
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
              child: _signatureCard(TextString.subtitleOwnerEditSignature, controller.ownerNameEditController),
            ),
            SizedBox(
              width: cardWidth,
              child: _signatureCard(TextString.subtitleHirerEditSignature, controller.hirerNameEditController),
            ),
          ],
        );
      },
    );
  }

  Widget _signatureCard(String title, TextEditingController name2Controller) {
    return LayoutBuilder(
      builder: (context, innerConstraints) {
        bool forceVertical = innerConstraints.maxWidth < 300;

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.primaryColor,width: 0.2),
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
                  ///  Full Name Section
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Column(
                            children: [
                              TextFormField(
                                cursorColor: AppColors.blackColor,
                                controller: name2Controller,
                                style: TTextTheme.h2Style(context),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text(TextString.subtitleEditFullName, style: TTextTheme.titleFullName(context)),
                      ],
                    ),
                  ),

                  if (forceVertical) const SizedBox(height: 15) else const SizedBox(width: 10),

                  ///  Signature Section
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Column(
                            crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Text(
                                name2Controller.text.isEmpty ? "Sign" : name2Controller.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cursive',
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                            ],
                          ),
                        ),
                        Text(TextString.subtitleEditSign, style: TTextTheme.titleFullName(context)),
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
    return GestureDetector(
      onTap: () => controller.pickImage3(),
      child: Obx(() {
        return DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(AppSizes.borderRadius(context)),
          dashPattern: const [8, 6],
          color: AppColors.tertiaryTextColor,
          strokeWidth: 1,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 180),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.borderRadius(context)),
            ),
            child: controller.pickupCarImages3.isEmpty
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
                Text(TextString.titleEditImage, style: TTextTheme.btnOne(context)),
                Text(TextString.subtitleEditImage, style: TTextTheme.documnetIsnideSmallText2(context)),
              ],
            )
                : Wrap(
              spacing: 15,
              runSpacing: 15,
              children: controller.pickupCarImages3.asMap().entries.map((entry) {
                int index = entry.key;
                final imageHolder = entry.value;

                ImageProvider imageProvider;
                if (kIsWeb) {
                  imageProvider = (imageHolder.bytes != null)
                      ? MemoryImage(imageHolder.bytes!)
                      : const AssetImage("assets/images/placeholder.png") as ImageProvider;
                } else {
                  imageProvider = (imageHolder.path != null)
                      ? FileImage(File(imageHolder.path!))
                      : const AssetImage("assets/images/placeholder.png") as ImageProvider;
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
                        onTap: () {
                          controller.removeImage3(index);
                        },
                        child: CircleAvatar(
                          radius: 13,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            IconString.deleteIcon,
                            color: AppColors.primaryColor,
                            width: 14,
                          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                    _buildProfileImage(35, 45),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(TextString.titleCustomerEditImage, style: TTextTheme.titleOne(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(TextString.titleEditDriver, style: TTextTheme.btnTwo(context)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(width: 70, child: AddButtonOfPickup(text: "View", onTap: () {})),
            ],
          ),
          SizedBox(height: 15),
          /// Scrollable Info for Mobile
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics:  BouncingScrollPhysics(),
            child: Row(
              children: [
                _infoBlock(IconString.smsIcon, TextString.titleEditEmail, "Contact@SoftSnip.com.au", context),
                const SizedBox(width: 15),
                _infoBlock(IconString.callIcon, TextString.titleEditContact, "+12 3456 7890", context),
                const SizedBox(width: 15),
                _infoBlock(IconString.location, TextString.titleEditAddress, "Toronto, California, 1234", context),
                const SizedBox(width: 15),
                _infoBlock(IconString.nidIcon, TextString.titleEditNid, "123 456 789", context),
                const SizedBox(width: 15),
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
              Text(TextString.titleCustomerEditImage, style: TTextTheme.titleOne(context)),
              Text(TextString.titleEditDriver, style: TTextTheme.btnTwo(context)),
            ],
          ),
        ],
      ),

      /// INFO BLOCKS
      const SizedBox(width: 20),
      _infoBlock(IconString.smsIcon,TextString.titleEditEmail, "Contact@SoftSnip.com.au", context),
      const SizedBox(width: 20),
      _infoBlock(IconString.callIcon, TextString.titleEditContact, "+12 3456 7890", context),
      const SizedBox(width: 20),
      _infoBlock(IconString.location, TextString.titleEditAddress, "Toronto, California, 1234", context),
      const SizedBox(width: 20),
      _infoBlock(IconString.nidIcon, TextString.titleEditNid, "123 456 789", context),
      const SizedBox(width: 20),

      /// VIEW BUTTON
      AddButtonOfPickup(text: "View", width: 100, onTap: () {}),
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
                            Text(TextString.titleCarEditImage, style: TTextTheme.titleSix(context), overflow: TextOverflow.ellipsis),
                            Text(TextString.titleCarEditImage2 , style: TTextTheme.h3Style(context), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AddButtonOfPickup(text: "View", width: 65, onTap: () {}),
              ],
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _infoRowTag(label: TextString.titleEditRegistration, value: "1234567890", context: context),
                  const SizedBox(width: 10),
                  _infoRowTag(
                    label: TextString.titleEditVin,
                    value: "JTNBA3HK003001234",
                    labelColor: AppColors.backgroundOfVin,
                    context: context,
                  ),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleEditRegistration, value: "Auto", imagePath: IconString.transmissionIcon),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleEditCapacity, value: "2 seats", imagePath: IconString.capacityIcon),
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

            bool enableScroll = maxWidth < 700;

            Widget content = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildCarContent(context, enableScroll),
            );


            return enableScroll
                ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 900),
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
            height: enableScroll ? 80 : 130,
            alignment: Alignment.center,
            child: Image.asset(
              ImageString.astonPic,
              width: 135,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(TextString.titleCarEditImage , style: TTextTheme.titleFour(context)),
              Text(TextString.titleCarEditImage2, style: TTextTheme.h3Style(context)),

              if (!enableScroll) ...[
                const SizedBox(height: 12),
                _infoRowTag(label: TextString.titleEditRegistration, value: "1234567890", context: context),
                const SizedBox(height: 8),
                _infoRowTag(
                  label: TextString.titleEditVin,
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
            _infoRowTag(label: TextString.titleEditRegistration, value: "1234567890", context: context),
            const SizedBox(width: 10),
            _infoRowTag(
              label: TextString.titleEditVin,
              value: "JTNBA3HK003001234",
              labelColor: AppColors.backgroundOfVin,
              context: context,
            ),
          ],
        ),

      _buildSpecColumn(context, label: TextString.titleEditTransmission, value: "Automatic", imagePath: IconString.transmissionIcon),
      _buildSpecColumn(context, label:TextString.titleEditCapacity , value: "2 seats", imagePath: IconString.capacityIcon),

      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceColumn(context),
          const SizedBox(width: 25),
          AddButtonOfPickup(text: "View", width: 100, onTap: () {}),
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
        Text(TextString.titleEditPrice, style:  TTextTheme.titleFour(context)),
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


  // Radio Buttons
  Widget _buildRadioOption(BuildContext context, String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 20,
            color: AppColors.blackColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TTextTheme.titleRadios(context),
          ),
        ],
      ),
    );
  }

  // Dropdowns
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

  // Buttons Widget
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
            child: AddPickUpButton(
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
            child: AddButtonOfPickup(
              text: "Confirm",
              onTap: () {
              },
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
            child: AddPickUpButton(
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
            child: AddButtonOfPickup(
              text: "Confirm",
              onTap: () {
              },
            ),
          ),

        ],
      );
    }
  }
}