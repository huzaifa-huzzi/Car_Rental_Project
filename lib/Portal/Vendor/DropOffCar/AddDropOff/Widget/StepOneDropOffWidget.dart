import 'package:car_rental_project/Portal/Vendor/DropOffCar/DropOffController.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/CustomButtonDropOff.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/Portal/Vendor/DropOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class AddDropOffDetailWidget extends StatelessWidget {
  final controller = Get.find<DropOffController>();
  AddDropOffDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);
    double padding = 24.0;
    final controller = Get.put(DropOffController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Form(
          key:controller.dropOffFormKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Header
              HeaderWebDropOffWidget(
                mainTitle: 'Add DropOff Car',
                showBack: true,
                showSmallTitle: true,
                smallTitle: 'DropOff Car / Add DropOff Car',
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
                            Text(TextString.titleViewPickStepTwoDropOffAdd2, style: TTextTheme.h6Style(context)),
                            const SizedBox(height: 6),
                            Text(TextString.titleViewSubtitleStepTwoDropOffAdd3, style: TTextTheme.titleThree(context)),
                            const SizedBox(height: 7),
                            _buildStepBadges(context),
                            const SizedBox(height: 25),
                            _buildSection(context, title: TextString.titleViewCustomerStepTwoDropOffAdd, icon: IconString.customerNameIcon, child: _buildDetailedCustomerCard(context, isMobile)),
                            const SizedBox(height: 25),
                            _buildSection(context, title: TextString.titleViewCarStepTwoDropOffAdd, icon: IconString.pickupCarIcon, child: _buildDetailedCarCard(context, isMobile)),
                            const SizedBox(height: 25),
                            Flex(
                              direction: isMobile ? Axis.vertical : Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isMobile
                                    ? _buildSection(context, title: TextString.titleRentPurposeStepTwoDropOffAdd, icon: IconString.rentPurposeIcon, child: _toggleStatusTag(context, TextString.subtitleRentPurposeStepTwoDropOffAdd, controller.isPersonalUseStepTwoAdd))
                                    : Expanded(child: _buildSection(context, title: TextString.titleRentPurposeStepTwoDropOffAdd, icon: IconString.rentPurposeIcon, child: _toggleStatusTag(context, TextString.subtitleRentPurposeStepTwoDropOffAdd, controller.isPersonalUseStepTwoAdd))),
                                if (!isMobile) const SizedBox(width: 25) else const SizedBox(height: 25),
                                isMobile
                                    ? _buildSection(context, title: TextString.titlePaymentMethodStepTwoDropOffAdd, icon: IconString.paymentMethodIcon, child: _toggleStatusTag(context, TextString.subtitlePaymentMethodStepTwoDropOffAdd, controller.isManualPaymentStepTwoAdd))
                                    : Expanded(child: _buildSection(context, title: TextString.titlePaymentMethodStepTwoDropOffAdd, icon: IconString.paymentMethodIcon, child: _toggleStatusTag(context, TextString.subtitlePaymentMethodStepTwoDropOffAdd, controller.isManualPaymentStepTwoAdd))),
                              ],
                            ),
                            const SizedBox(height: 25),
                            _buildSection(context,
                                title: TextString.titleViewRentAmountStepTwoDropOffAdd,
                                icon: IconString.rentMoneyIcon,
                                child: _buildInfoGrid(context, [
                                  {"label": "Weekly Rent", "controller": controller.weeklyRentControllerStepTwoAdd, "hint": "2600 \$", "isReadOnly": true},
                                  {"label": "Daily Rent", "controller": controller.rentDueAmountControllerStepTwoAdd, "hint": "2600 \$", "isReadOnly": true},
                                ], isMobile)),
                            const SizedBox(height: 25),
                            _buildSection(
                              context,
                              title: TextString.titleBondPaymentStepTwo,
                              icon: IconString.bondPaymentIcon,
                              child: _buildBondGrid(context, [
                                {"label": "Bond Amount", "controller": controller.bondAmountControllerStepTwoAdd, "hint": "2600 \$", "isReadOnly": true},
                                {"label": "Paid Bond", "controller": controller.paidBondControllerStepTwoAdd, "hint": "600 \$", "isReadOnly": true},
                                {"label": "Bond Returned", "controller": controller.dueBondReturnedControllerStepTwoAdd, "hint": "2000 \$", "isSpecial": true},
                              ], isMobile),
                            ),

                            const SizedBox(height: 20),
                            Text(TextString.titleCarReportStepTwoDropOffInspectionAdd, style: TTextTheme.h6Style(context)),
                            const SizedBox(height: 20),
                            _buildSection(context, title: TextString.titleCarReportStepTwoDropOffAdd, icon: IconString.carReportIcon, child: _buildCarReportComparison(context, isMobile)),
                            const SizedBox(height: 25),
                            _buildSection(context, title: TextString.titlePickupNoteStepTwoDropOFf2Add, icon: IconString.pickupNote, child: _buildDropoffNoteComparison(context, isMobile)),
                            const SizedBox(height: 35),
                            _buildSection(context, title: TextString.titleRentTimeStepTwoDropOffAdd, icon: IconString.rentTimeIcon, child: _buildRentTimeSection(context, isMobile)),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buttonSection(context, isMobile),

              const SizedBox(height: 140),
            ],
          ),
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

  // Badges
  Widget _buildStepBadges(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepItem("1", "Step 1", true, context),
          _buildStepLine(true),
          _buildStepItem("2", "Step 2", false, context, isCurrent: true),
          _buildStepLine(true),
          _buildStepItem("3", "Step 3", false, context, isCurrent: true),
        ],
      ),
    );
  }
  Widget _buildStepItem(String stepNum, String label, bool isCompleted, BuildContext context, {bool isCurrent = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.primaryColor : Colors.white,
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : isCurrent
                ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TTextTheme.stepsText(context).copyWith(
            color: isCompleted ? AppColors.primaryColor : AppColors.textColor,
          ),
        ),
      ],
    );
  }
  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 11.0),
        child: Container(
          height: 1.5,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  //  Note Fields
  Widget _buildCommentField(BuildContext context, String label, TextEditingController controller, String hint, {bool isReadOnly = false}) {
    return FormField<String>(
      validator: (value) {
        if (!isReadOnly) {
          if (controller.text.trim().isEmpty) {
            return 'Required';
          }
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TTextTheme.dropdowninsideText(context)),
            const SizedBox(height: 8),
            Focus(
              onFocusChange: (hasFocus) {
                if (!isReadOnly) {
                  if (context is Element && context.mounted) {
                    (context as Element).markNeedsBuild();
                  }
                }
              },
              child: Builder(
                builder: (context) {
                  final bool hasFocus = Focus.of(context).hasFocus;

                  return Container(
                    constraints: const BoxConstraints(minHeight: 120),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                      border: state.hasError
                          ? Border.all(color: AppColors.primaryColor)
                          : null,
                      boxShadow: (!isReadOnly && hasFocus)
                          ? [
                        BoxShadow(
                          color: AppColors.fieldsBackground,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 1,
                        )
                      ]
                          : [],
                    ),
                    child: TextField(
                      readOnly: isReadOnly,
                      cursorColor: AppColors.blackColor,
                      controller: controller,
                      maxLines: 5,
                      style: TTextTheme.pOne(context),
                      onChanged: (val) => state.didChange(val),
                      decoration: InputDecoration(
                        hintText: hint,
                        border: InputBorder.none,
                        hintStyle: TTextTheme.pOne(context),
                        isDense: true,
                        errorText: null,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.errorText!,
                  style: TTextTheme.ErrorStyle(context)
                ),
              ),
          ],
        );
      },
    );
  }
  Widget _buildDropoffNoteComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 30) / 2;

      return Wrap(
        spacing: 30,
        runSpacing: 20,
        children: [
          /// 1. PICKUP NOTES
          SizedBox(
            width: columnWidth,
            child: _buildCommentField(
              context,
              TextString.titlePickupNoteStepTwoDropOffAdd,
              controller.additionalCommentsControllerStepTwoAdd,
              TextString.subtitleViewPickupStepTwoDropOffAdd,
              isReadOnly: true,
            ),
          ),

          /// 2. DROPOFF NOTES
          SizedBox(
            width: columnWidth,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfPickupsWidget,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildCommentField(
                context,
                TextString.titlePickupNoteStepTwoDropOFf2Add,
                controller.additionalCommentsControllerDropOffAdd,
                TextString.subtitleViewPickupStepTwoDropOff,
                isReadOnly: false,
              ),
            ),
          ),
        ],
      );
    });
  }

    // Bond Grids
  Widget _buildBondGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile ? (availableWidth - 100) : (availableWidth / 5.5);
        bool isSpecial = item['isSpecial'] == true;

        return FormField<String>(
          validator: (value) {
            if (isSpecial && item['controller'].text.trim().isEmpty) {
              return 'Required';
            }
            return null;
          },
          builder: (FormFieldState<String> state) {
            return SizedBox(
              width: itemWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['label']!, style: TTextTheme.dropdowninsideText(context)),
                  const SizedBox(height: 8),

                  Focus(
                    onFocusChange: (hasFocus) {
                      if (isSpecial && context is Element && context.mounted) {
                        (context as Element).markNeedsBuild();
                      }
                    },
                    child: Builder(
                      builder: (focusContext) {
                        final bool hasFocus = Focus.of(focusContext).hasFocus;
                        Widget innerField = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(6),
                                border: state.hasError
                                    ? Border.all(color: AppColors.primaryColor)
                                    : null,
                                boxShadow: (isSpecial && hasFocus) ? [
                                  BoxShadow(
                                    color: AppColors.fieldsBackground,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 1,
                                  )
                                ] : [],
                              ),
                              child: TextField(
                                cursorColor: AppColors.blackColor,
                                keyboardType: TextInputType.number,
                                controller: item['controller'],
                                readOnly: !isSpecial,
                                onChanged: (val) => state.didChange(val),
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
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 6, left: 4),
                                child: Text(
                                  state.errorText!,
                                  style: TTextTheme.ErrorStyle(context),
                                ),
                              ),
                          ],
                        );
                        return isSpecial
                            ? Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundOfPickupsWidget,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: innerField,
                        )
                            : innerField;
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }


  // Rent time Section
  Widget _buildRentTimeSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      return isMobile
          ? _buildMobileRentTime(context)
          : _buildWebRentTime(context, constraints.maxWidth);
    });
  }
  Widget _buildWebRentTime(BuildContext context, double maxWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// 1. PICKUP SECTION
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReadOnlyTimePair(context, TextString.subtitleAgreementTimeStepTwoPickupDropOffAdd, "02/12/2025", "12:12 PM",),
              const SizedBox(height: 15),
              _buildReadOnlyTimePair(context, TextString.subtitleAgreementEndTimeStepTwoPickupDropOffAdd, "02/12/2025", "12:12 PM",),
            ],
          ),
        ),

        /// 2. ARROW
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Row(
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
                          Container(height: 1.5, color: AppColors.iconsBackgroundColor),
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
        ),

        /// 3. DROPOFF SECTION
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfPickupsWidget,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextString.subtitleAgreementEndTimeStepTwoDropOff2Add, style: TTextTheme.dropdowninsideText(context)),
                const SizedBox(height: 12),

                CompositedTransformTarget(
                  link: controller.dropOffDateLink,
                  child: _editableTimeField(
                    controller.endDateControllerStepTwoAdd,
                    "DD/MM/YYYY",
                    context,
                    isReadOnly: false,
                    iconType: "date",
                    onTap: () => controller.toggleCalendar(context, controller.dropOffDateLink, controller.endDateControllerStepTwoAdd, 220),
                  ),
                ),

                const SizedBox(height: 12),

                CompositedTransformTarget(
                  link: controller.dropOffTimeLink,
                  child: _editableTimeField(
                    controller.endTimeControllerStepTwoAdd,
                    "Time:",
                    context,
                    iconType: "time",
                    isReadOnly: false,
                    onTap: () => controller.toggleTimePicker(context, controller.dropOffTimeLink, controller.endTimeControllerStepTwoAdd, 220),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildMobileRentTime(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width * 0.9;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Pickup Section
        Column(
          children: [
            _buildReadOnlyTimePair(context, TextString.subtitleAgreementTimeStepTwoPickupDropOffAdd, "02/12/2025", "12:12 PM"),
            const SizedBox(height: 15),
            _buildReadOnlyTimePair(context, TextString.subtitleAgreementEndTimeStepTwoPickupDropOffAdd, "02/12/2025", "12:12 PM"),
          ],
        ),

        const SizedBox(height: 24),

        /// Dropoff Section
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.subtitleAgreementEndTimeStepTwoDropOff2Add, style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),

              CompositedTransformTarget(
                link: controller.dropOffDateLink,
                child: _editableTimeField(
                  controller.endDateControllerStepTwoAdd,
                  "DD/MM/YYYY",
                  context,
                  isReadOnly: false,
                  iconType: "date",
                  onTap: () => controller.toggleCalendar(context, controller.dropOffDateLink, controller.endDateControllerStepTwoAdd, fieldWidth),
                ),
              ),

              const SizedBox(height: 12),

              CompositedTransformTarget(
                link: controller.dropOffTimeLink,
                child: _editableTimeField(
                  controller.endTimeControllerStepTwoAdd,
                  "Time:",
                  context,
                  iconType: "time",
                  isReadOnly: false,
                  onTap: () => controller.toggleTimePicker(context, controller.dropOffTimeLink, controller.endTimeControllerStepTwoAdd, fieldWidth),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildReadOnlyTimePair(BuildContext context, String label, String date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(TextEditingController(text: date), date, context,
            isReadOnly: true,
            iconType: "none"
        ),
        const SizedBox(height: 8),
        _editableTimeField(TextEditingController(text: time), time, context,
            isReadOnly: true,
            iconType: "none"
        ),
      ],
    );
  }
  Widget _editableTimeField(
      TextEditingController textController,
      String hint,
      BuildContext context, {
        required bool isReadOnly,
        String iconType = "none",
        VoidCallback? onTap
      }) {
    return FormField<String>(
      validator: (value) {
        if (!isReadOnly) {
          if (textController.text.isEmpty ||
              textController.text == "DD/MM/YYYY" ||
              textController.text == "Time:") {
            return 'Required';
          }
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                if (onTap != null) {
                  onTap();
                  await Future.delayed(const Duration(milliseconds: 100));
                  state.didChange(textController.text);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: state.hasError
                          ? AppColors.primaryColor
                          : AppColors.tertiaryTextColor.withOpacity(0.3)
                  ),
                ),
                child: AbsorbPointer(
                  absorbing: true,
                  child: TextFormField(
                    controller: textController,
                    style: TTextTheme.insidetextfieldWrittenText(context),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      border: InputBorder.none,
                      isDense: true,
                      suffixIcon: iconType == "none" ? null : _getIcon(iconType),
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                    ),
                  ),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.errorText!,
                  style: TTextTheme.ErrorStyle(context)
                ),
              ),
          ],
        );
      },
    );
  }
  Widget _getIcon(String type) {
    if (type == "date") {
      return Image.asset(IconString.calendarIcon);
    } else {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.keyboard_arrow_up, size: 16, color: Colors.blueGrey),
          SizedBox(height: 2,),
          Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.blueGrey),
        ],
      );
    }
  }


  // Car Report Section
  Widget _buildCarReportComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gap = 16;
        int columns = isMobile ? 1 : 4;
        double horizontalPadding = isMobile ? 0 : 32;
        double availableWidth = constraints.maxWidth - horizontalPadding;

        double itemWidth = (availableWidth - (gap * (columns - 1))) / columns;

        return Column(
          children: [
            Wrap(
              spacing: gap,
              runSpacing: 20,
              children: [
                _buildReadOnlyFieldSized(
                  TextString.subtitlePickupOdoStepTwoDropOffAdd,
                  controller.odoControllerStepTwoAdd.text,
                  context,
                  width: itemWidth,
                ),
                _buildReadOnlyFieldSized(
                  TextString.subtitlePickFuelLevelStepTwoDropOffAdd,
                  controller.fuelLevelControllerStepTwoAdd.text,
                  context,
                  width: itemWidth,
                  hasIcon: true,
                ),
                _buildReadOnlyFieldSized(
                  "Pickup Interior Cleanliness",
                  controller.interiorCleanlinessControllerStepTwoAdd.text,
                  context,
                  width: itemWidth,
                  hasIcon: true,
                ),
                _buildReadOnlyFieldSized(
                  TextString.subtitleExteriorCleanlinessStepTwoDropOffAdd,
                  controller.exteriorCleanlinessControllerStepTwoAdd.text,
                  context,
                  width: itemWidth,
                  hasIcon: true,
                ),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfPickupsWidget,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: gap,
                runSpacing: 20,
                children: [
                  _buildMiniInputField(
                    TextString.subtitleDropOffOdoStepTwoDropOffAdd,
                    "12457678",
                    itemWidth,
                    controller.odoControllerDropOffAdd,
                    context,
                  ),
                  _buildReportDropdown(
                    TextString.subtitleDropOffFuelLevelStepTwoDropOffAdd,
                    ["Full (100%)", "High (75%)", "Half (50%)", "Low (25%)", "Empty (0%)"],
                    itemWidth,
                    controller.fuelLevelControllerDropOffAdd,
                    context,
                  ),
                  _buildReportDropdown(
                    TextString.subtitleInteriorCleanlinessStepTwoDropOff2Add,
                    ["Excellent", "Good", "Average", "Dirty"],
                    itemWidth,
                    controller.interiorCleanlinessControllerDropOffAdd,
                    context,
                  ),
                  _buildReportDropdown(
                    TextString.subtitleExteriorCleanlinessStepTwoDropOff2Add,
                    ["Excellent", "Good", "Average", "Dirty"],
                    itemWidth,
                    controller.exteriorCleanlinessControllerDropOffAdd,
                    context,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildReadOnlyFieldSized(
      String label,
      String value,
      BuildContext context, {
        required double width,
        bool hasIcon = false,
      }) {
    return SizedBox(
      width: width,
      child: _buildReadOnlyField(label, value, context, hasIcon: hasIcon),
    );
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
                const Icon(Icons.check_circle_outline, size: 16, color:AppColors.textColor),
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

  // Main Section Building
  Widget _buildSection(BuildContext context, {
    required String title,
    required String icon,
    required Widget child,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.tertiaryTextColor,width: 0.7)
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
                          Text(TextString.titleCustomerImageStepTwoDropOffAdd, style: TTextTheme.titleOne(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(TextString.titleDriverStepTwoDropOffAdd, style: TTextTheme.btnTwo(context)),
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
                _infoBlock(IconString.smsIcon, TextString.titleEmailStepTwoDropOffAdd, "Contact@SoftSnip.com.au", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.callIcon, TextString.titleContactStepTwoDropOffAdd, "+12 3456 7890", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.location, TextString.titleAddressStepTwoDropOffAdd, "Toronto, California, 1234", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.nidIcon, TextString.titleNidStepTwoDropOffAdd, "123 456 789", context),
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
              Text(TextString.titleCustomerImageStepTwoDropOffAdd, style: TTextTheme.titleOne(context)),
              Text(TextString.titleDriverStepTwoDropOffAdd, style: TTextTheme.btnTwo(context)),
            ],
          ),
        ],
      ),

      /// INFO BLOCKS
      const SizedBox(width: 20),
      _infoBlock(IconString.smsIcon, TextString.titleEmailStepTwoDropOffAdd, "Contact@SoftSnip.com.au", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.callIcon,  TextString.titleContactStepTwoDropOffAdd, "+12 3456 7890", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.location, TextString.titleAddressStepTwoDropOffAdd, "Toronto, California, 1234", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.nidIcon, TextString.titleNidStepTwoDropOffAdd, "123 456 789", context),
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
        border: Border.all(color: Colors.white, width: 0.5),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border:Border.all(color: AppColors.tertiaryTextColor,width: 0.7),
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
                            Text(TextString.titleCarImageStepTwoDropOffAdd, style: TTextTheme.titleSix(context), overflow: TextOverflow.ellipsis),
                            Text(TextString.titleCarImage2StepTwoDropOffAdd, style: TTextTheme.h3Style(context), overflow: TextOverflow.ellipsis),
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
                  _infoRowTag(label: TextString.titleRegistrationStepTwoDropOffAdd, value: "1234567890", context: context),
                  const SizedBox(width: 10),
                  _infoRowTag(
                    label:TextString.titleVinStepTwoDropOffAdd,
                    value: "JTNBA3HK003001234",
                    labelColor: AppColors.backgroundOfVin,
                    context: context,
                  ),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label:TextString.titleTransmissionStepTwoDropOffAdd, value: "Auto", imagePath: IconString.transmissionIcon),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleCapacityStepTwoDropOffAdd, value: "2 seats", imagePath: IconString.capacityIcon),
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
              Text(TextString.titleCarImageStepTwoDropOffAdd, style: TTextTheme.titleFour(context)),
              Text(TextString.titleCarImage2StepTwoDropOffAdd, style: TTextTheme.h3Style(context)),

              if (!enableScroll) ...[
                const SizedBox(height: 12),
                _infoRowTag(label: TextString.titleRegistrationStepTwoDropOffAdd, value: "1234567890", context: context),
                const SizedBox(height: 8),
                _infoRowTag(
                  label:TextString.titleVinStepTwoDropOffAdd,
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
            _infoRowTag(label: TextString.titleRegistrationStepTwoDropOffAdd, value: "1234567890", context: context),
            const SizedBox(width: 10),
            _infoRowTag(
              label: TextString.titleVinStepTwoDropOffAdd,
              value: "JTNBA3HK003001234",
              labelColor: AppColors.backgroundOfVin,
              context: context,
            ),
          ],
        ),

      _buildSpecColumn(context, label: TextString.titleTransmissionStepTwoDropOffAdd, value: "Automatic", imagePath: IconString.transmissionIcon),
      _buildSpecColumn(context, label: TextString.titleCapacityStepTwoDropOffAdd, value: "2 seats", imagePath: IconString.capacityIcon),

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
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            stateVariable.value ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 16,
            color: AppColors.blackColor,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: TTextTheme.titleRadios(context),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ));
  }


  // Input Fields
  Widget _buildMiniInputField(
      String label,
      String hint,
      double width,
      TextEditingController txtController,
      BuildContext context,
      {bool isReadOnly = false}
      ) {
    return SizedBox(
      width: width,
      child: FormField<String>(
        // 🔥 Validation logic yahan shift ho gayi
        validator: (value) {
          if (!isReadOnly) {
            if (txtController.text.trim().isEmpty) {
              return 'Required';
            }
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  label,
                  style: TTextTheme.titleTwo(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis
              ),
              const SizedBox(height: 8),

              // Input Box
              Focus(
                onFocusChange: (hasFocus) {
                  if (!isReadOnly) {
                    if (context is Element && context.mounted) {
                      (context as Element).markNeedsBuild();
                    }
                  }
                },
                child: Builder(
                  builder: (focusContext) {
                    final bool hasFocus = Focus.of(focusContext).hasFocus;

                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(6),
                        // Agar error hai to border red dikhana hai to line niche add karein
                        border: state.hasError ? Border.all(color: Colors.red.withOpacity(0.5), width: 1) : null,
                        boxShadow: (!isReadOnly && hasFocus) ? [
                          BoxShadow(
                            color: AppColors.fieldsBackground,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            spreadRadius: 1,
                          )
                        ] : [],
                      ),
                      child: TextField( // TextFormField ki jagah TextField kyunki validation FormField handle kar raha hai
                        readOnly: isReadOnly,
                        cursorColor: AppColors.blackColor,
                        controller: txtController,
                        textAlignVertical: TextAlignVertical.center,
                        style: TTextTheme.insidetextfieldWrittenText(context),
                        keyboardType: TextInputType.number,
                        onChanged: (val) => state.didChange(val), // 🔥 Error reset karne ke liye
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          border: InputBorder.none,
                          isDense: true,
                          // Default error hide kar di
                          errorText: null,
                          errorStyle: const TextStyle(height: 0),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 🔥 Yeh hai aapka "Required" text jo field se bahar niche aayega
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildReportDropdown(
      String label,
      List<String> items,
      double width,
      TextEditingController txtController,
      BuildContext context,
      ) {
    if (txtController.text.isEmpty && items.isNotEmpty) {
      txtController.text = items.first;
    }

    return SizedBox(
      width: width,
      child: FormField<String>(
        initialValue: txtController.text,
        validator: (value) {
          if (txtController.text.isEmpty) {
            return 'Please select';
          }
          return null;
        },
        builder: (FormFieldState<String> state) {
          return Column(
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
                offset: const Offset(0, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: Colors.white,
                constraints: BoxConstraints(minWidth: width, maxWidth: width),
                onSelected: (val) {
                  txtController.text = val;
                  state.didChange(val);
                },
                itemBuilder: (context) {
                  return items.map((item) {
                    bool isSelected = txtController.text == item;
                    return PopupMenuItem<String>(
                      value: item,
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              border: Border.all(color: AppColors.primaryColor, width: 2),
                            ),
                            child: isSelected ? const Icon(Icons.done, size: 14, color: Colors.white) : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(item, style: TTextTheme.titleTwo(context))),
                        ],
                      ),
                    );
                  }).toList();
                },
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: state.hasError ? Border.all(color: AppColors.primaryColor, width: 1) : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: txtController,
                          builder: (context, value, _) {
                            return Text(
                              txtController.text,
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
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: Text(state.errorText!, style: TTextTheme.ErrorStyle(context)),
                ),
            ],
          );
        },
      ),
    );
  }


  //  Action Buttons Widgets
  Widget _buttonSection(BuildContext context, bool isMobile) {
    const double webButtonWidth = 150.0;
    const double webButtonHeight = 45.0;
    final double spacing = AppSizes.padding(context);
    final controller = Get.put(DropOffController());
    void handleContinue() {
      if (controller.dropOffFormKey.currentState!.validate()) {
        if (controller.validateDropOffStep1() && controller.validateDropOffStep2()) {
          context.push('/stepTwoDropoff', extra: {"hideMobileAppBar": true});

        }
      } else {
        controller.showError("Please fill all the required fields marked in red.");
      }
    }

    if (isMobile) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: webButtonHeight,
              child: CustomButtonDropOff(
                text: 'Cancel',
                backgroundColor: Colors.transparent,
                textColor: AppColors.textColor,
                borderColor: AppColors.quadrantalTextColor,
                onTap: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: spacing),
            SizedBox(
              height: webButtonHeight,
              child: PrimaryBthDropOff(
                text: "Continue",
                icon: Image.asset(IconString.continueIcon),
                onTap: handleContinue,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: webButtonWidth,
              height: webButtonHeight,
              child: CustomButtonDropOff(
                text: 'Cancel',
                backgroundColor: Colors.transparent,
                textColor: AppColors.textColor,
                borderColor: AppColors.quadrantalTextColor,
                onTap: () => Navigator.pop(context),
              ),
            ),
            SizedBox(width: spacing),
            SizedBox(
              width: webButtonWidth,
              height: webButtonHeight,
              child: PrimaryBthDropOff(
                text: "Continue",
                icon: Image.asset(IconString.continueIcon),
                onTap: handleContinue,
              ),
            ),
          ],
        ),
      );
    }
  }


}