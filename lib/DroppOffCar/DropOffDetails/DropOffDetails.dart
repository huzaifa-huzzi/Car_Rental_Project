import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/HeaderWebDropOffWidget.dart';
import 'package:car_rental_project/DroppOffCar/ReusableWidgetOfDropoff/PrimaryBtnDropOff.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


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

            // Header
            HeaderWebDropOffWidget(
              mainTitle: 'DropOff Car Detail',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'DropOff / DropOff Car Details',
              showSearch: isWeb,
              showSettings: isWeb,
              showAddButton: true,
              showNotification: true,
              showProfile: true,
              onAddPressed: (){
                context.push(
                  '/addDropOff',
                  extra: {"hideMobileAppBar": true},
                );
              },
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
                          Text(TextString.titleViewPickStepTwoDropOff, style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 6),
                          Text(TextString.titleViewSubtitleStepTwoDropOff,
                              style: TTextTheme.titleThree(context)),
                          const SizedBox(height: 25),

                          ///  NON-EDITABLE SECTION
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(isMobile ? 15 : 30),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundOfScreenColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Customer
                                _buildSection(context,
                                    title: TextString.titleViewCustomerStepTwoDropOff,
                                    icon: IconString.customerNameIcon,
                                    child: _buildDetailedCustomerCard(context, isMobile)),
                                const SizedBox(height: 25),
                                // Car
                                _buildSection(context,
                                    title: TextString.titleViewCarStepTwoDropOff,
                                    icon: IconString.pickupCarIcon,
                                    child: _buildDetailedCarCard(context, isMobile)),
                                const SizedBox(height: 25),

                                // RENT PURPOSE & PAYMENT METHOD
                                Flex(
                                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// RENT PURPOSE SECTION
                                    Expanded(
                                      flex: isMobile ? 0 : 1,
                                      child: _buildSection(
                                        context,
                                        title: TextString.titleRentPurposeStepTwoDropOff,
                                        icon: IconString.rentPurposeIcon,
                                        child: IgnorePointer(
                                          child: _toggleStatusTag(context, TextString.subtitleRentPurposeStepTwoDropOff, controller.isPersonalUseStepTwo),
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
                                        title: TextString.titlePaymentMethodStepTwoDropOff,
                                        icon: IconString.paymentMethodIcon,
                                        child: IgnorePointer(
                                          child: _toggleStatusTag(context, TextString.subtitlePaymentMethodStepTwoDropOff, controller.isManualPaymentStepTwo),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 25),

                                 // Rent
                                _buildSection(context,
                                    title: TextString.titleViewRentAmountStepTwoDropOff,
                                    icon: IconString.rentMoneyIcon,
                                    child: _buildInfoGrid(context, [
                                      {"label": TextString.subtitleWeeklyRentStepTwoDropOff, "controller": controller.weeklyRentControllerStepTwo, "hint": "2600 \$"},
                                      {"label": TextString.subtitleDailyRentStepTwoDropOff, "controller": controller.rentDueAmountControllerStepTwo, "hint": "2600 \$"},
                                    ], isMobile, isEditable: false)),
                                const SizedBox(height: 25),

                                // Bond
                                _buildSection(
                                  context,
                                  title: TextString.titleBondPaymentStepTwoDropOff,
                                  icon: IconString.bondPaymentIcon,
                                  child: _buildBondGrid(context, [
                                    {"label": "Bond Amount", "controller": controller.bondAmountControllerStepTwo, "hint": "2600 \$"},
                                    {"label": "Paid Bond", "controller": controller.paidBondControllerStepTwo, "hint": "600 \$"},
                                    {"label": TextString.subtitleLeftBondStepTwoDropOff, "controller": controller.dueBondAmountControllerStepTwo, "hint": "2000 \$"},
                                    {
                                      "label": "Bond Returned",
                                      "controller": controller.dueBondReturnedControllerStepTwo,
                                      "hint": "2000 \$",
                                    }

                                  ], isMobile),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          /// EDITABLE SECTION
                          Text(TextString.titleCarReportStepTwoDropOffInspection, style: TTextTheme.h6Style(context)),
                          const SizedBox(height: 20),
                          //CAR REPORT SECTION
                          _buildSection(
                            context,
                            title: TextString.titleCarReportStepTwoDropOff,
                            icon: IconString.carReportIcon,
                            child: _buildCarReportComparison(context, isMobile),
                          ),
                          const SizedBox(height: 25),

                          // DAMAGE INSPECTION
                          _buildSection(
                            context,
                            title: TextString.titleDamageInspectionStepTwoDropOff,
                            icon: IconString.damageInspection,
                            child: _buildDamageInspectionComparison(context, isMobile),
                          ),
                          const SizedBox(height: 35),
                          /// CAR PICTURES
                          _buildSection(
                            context,
                            title:TextString.titleCarPictureStepTwoDropOff,
                            icon: IconString.carPictureIconPickup,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //  Pickup Car Image
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.backgroundOfScreenColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(TextString.titleCarPictureStepTwoDropOffTwo, style: TTextTheme.dropdowninsideText(context)),
                                      const SizedBox(height: 12),
                                      _buildPickupImageBox(context),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 25),

                                //  Dropoff Car Images
                                Text(TextString.subtitleCarPictureStepTwoDropOff , style: TTextTheme.dropdowninsideText(context)),
                                const SizedBox(height: 10),
                                _buildPickupImageBox2(context),
                              ],
                            ),
                          ),
                          const SizedBox(height: 35),
                          /// DropOff Notes
                          _buildSection(
                            context,
                            title: TextString.titlePickupNoteStepTwoDropOFf2,
                            icon: IconString.pickupNote,
                            child: _buildDropoffNoteComparison(context, isMobile),
                          ),
                          const SizedBox(height: 35),

                          // RENT TIME
                          _buildSection(
                            context,
                            title: TextString.titleRentTimeStepTwoDropOff,
                            icon: IconString.rentTimeIcon,
                            child: _buildRentTimeSection(context, isMobile),
                          ),
                          const SizedBox(height: 35),

                          // SIGNATURES
                          _buildSection(context,
                              title:  TextString.titleSignatureStepTwoDropOff ,
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
  Widget _buildCommentField(BuildContext context, String label, TextEditingController controller, String hint, {bool isReadOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            readOnly: isReadOnly,
            cursorColor: AppColors.blackColor,
            controller: controller,
            maxLines: 5,
            style: TTextTheme.pOne(context),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: TTextTheme.pOne(context),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildDropoffNoteComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 30) / 2;

      return Wrap(
        spacing: 30,
        runSpacing: 20,
        children: [
          /// PICKUP NOTES
          Container(
            width: columnWidth,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: _buildCommentField(
              context,
              TextString.titlePickupNoteStepTwoDropOff,
              controller.additionalCommentsControllerStepTwo,
              TextString.subtitleViewPickupStepTwoDropOff,
              isReadOnly: true,
            ),
          ),

          ///  DROPOFF NOTES
          SizedBox(
            width: columnWidth,
            child: _buildCommentField(
              context,
              TextString.titlePickupNoteStepTwoDropOFf2 ,
              controller.additionalCommentsControllerDropOff,
              TextString.subtitleViewPickupStepTwoDropOff,
              isReadOnly: true,
            ),
          ),
        ],
      );
    });
  }

   // Bond Grid
  Widget _buildBondGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile) {
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        double itemWidth = isMobile ? (availableWidth - 100) : (availableWidth / 5.5);

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
                cursorColor: AppColors.blackColor,
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

        return  SizedBox(
          width: itemWidth,
          child: fieldContent,
        );
      }).toList(),
    );
  }

  // Damage Inspection Cards
  Widget _buildDamageInspectionComparison(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      double columnWidth = isMobile ? constraints.maxWidth : (constraints.maxWidth - 120) / 2;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Wrap(
            spacing: isMobile ? 0 : 25,
            runSpacing: 25,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              ///  PICKUP DAMAGE
              Container(
                width: columnWidth,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.backgroundOfScreenColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.titleDamageInspectionStepTwoDropOffPickup, style: TTextTheme.titleTwo(context)),
                    const SizedBox(height: 12),
                    _buildStaticLegendBox(context),
                    const SizedBox(height: 20),
                    _buildStaticCarDiagram(context, columnWidth - 30),
                  ],
                ),
              ),

              ///  DROPOFF DAMAGE
              SizedBox(
                width: columnWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( TextString.titleDamageInspectionStepTwoDropOff2, style: TTextTheme.titleTwo(context)),
                    const SizedBox(height: 12),
                    _buildInteractiveLegendBox(context),
                    const SizedBox(height: 20),
                    _buildInteractiveCarDiagram(context, columnWidth),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
  Widget _buildStaticLegendBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.secondaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: controller.damageTypes2.map((type) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 10, backgroundColor: type['color'],
              child: Text(type['id'].toString(), style: TTextTheme.btnNumbering(context)),
            ),
            const SizedBox(width: 5),
            Text(type['label'], style: TTextTheme.titleSix(context)),
          ],
        )).toList(),
      ),
    );
  }
  Widget _buildStaticCarDiagram(BuildContext context, double width) {
    double height = width * 0.75;
    return Center(
      child: Stack(
        children: [
          Image.asset(ImageString.carDamageInspectionImage, width: width, height: height, fit: BoxFit.contain),
          ...controller.damagePoints2.map((point) => Positioned(
            left: (point.dx * width) - 10,
            top: (point.dy * height) - 10,
            child: CircleAvatar(
              radius: 10, backgroundColor: point.color,
              child: Text(point.typeId.toString(), style: TTextTheme.btnNumbering(context)),
            ),
          )),
        ],
      ),
    );
  }
  Widget _buildInteractiveCarDiagram(BuildContext context, double width) {
    double height = width * 0.75;

    return Center(
      child: Stack(
        children: [
          Image.asset(
            ImageString.carDamageInspectionImage,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
          ...controller.damagePoints2.map((point) => Positioned(
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
    );
  }
  Widget _buildInteractiveLegendBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.secondaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 8,
        children: controller.damageTypes2.map((type) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: type['color'],
                child: Text(
                  type['id'].toString(),
                  style: TTextTheme.btnNumbering(context),
                ),
              ),
              const SizedBox(width: 5),
              Text(type['label'], style: TTextTheme.titleSix(context)),
            ],
          );
        }).toList(),
      ),
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
        /// PICKUP SECTION
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfScreenColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildReadOnlyTimePair(context, TextString.subtitleAgreementTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
                const SizedBox(height: 15),
                _buildReadOnlyTimePair(context,  TextString.subtitleAgreementEndTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
              ],
            ),
          ),
        ),

        ///  ARROW INDICATOR
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.subtitleAgreementEndTimeStepTwoDropOff2 , style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              _editableTimeField(controller.endDateControllerStepTwo, "02/12/2025", context, isReadOnly: true),
              const SizedBox(height: 8),
              _editableTimeField(controller.endTimeControllerStepTwo, "12:12 PM", context, isReadOnly: true),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildMobileRentTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Pickup Section
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfScreenColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _buildReadOnlyTimePair(context, TextString.subtitleAgreementTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
              const SizedBox(height: 15),
              _buildReadOnlyTimePair(context,  TextString.subtitleAgreementEndTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
            ],
          ),
        ),
        const SizedBox(height: 24),

        /// Dropoff Section
        Text(TextString.subtitleAgreementEndTimeStepTwoDropOff2, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(controller.endDateControllerStepTwo, "25/12/2025", context, isReadOnly: true),
        const SizedBox(height: 8),
        _editableTimeField(controller.endTimeControllerStepTwo, "12:12 PM", context, isReadOnly: true),
      ],
    );
  }
  Widget _buildReadOnlyTimePair(BuildContext context, String label, String date, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(TextEditingController(text: date), date, context, isReadOnly: true),
        const SizedBox(height: 8),
        _editableTimeField(TextEditingController(text: time), time, context, isReadOnly: true),
      ],
    );
  }
  Widget _editableTimeField(TextEditingController textController, String hint, BuildContext context, {bool isReadOnly = true}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: textController,
        readOnly: isReadOnly,
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

  // Car Report Section
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
                _buildReadOnlyField(TextString.subtitlePickupOdoStepTwoDropOff, controller.odoControllerStepTwo.text, context),
                const SizedBox(height: 15),
                _buildReadOnlyField(TextString.subtitlePickFuelLevelStepTwoDropOff, controller.fuelLevelControllerStepTwo.text, context, hasIcon: true),
                const SizedBox(height: 15),
                _buildReadOnlyField(TextString.subtitleExteriorCleanlinessStepTwoDropOff , controller.exteriorCleanlinessControllerStepTwo.text, context, hasIcon: true),
                const SizedBox(height: 15),
                _buildReadOnlyField(TextString.subtitleInteriorCleanlinessStepTwoDropOff, controller.interiorCleanlinessControllerStepTwo.text, context, hasIcon: true),
              ],
            ),
          ),

          /// DROPOFF SIDE
          Padding(
            padding: EdgeInsets.only(top: isMobile ? 0 : 5),
            child: SizedBox(
              width: columnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dropoff ODO
                  _buildMiniInputField(
                      TextString.subtitleDropOffOdoStepTwoDropOff,
                      "12457678",
                      columnWidth,
                      controller.odoControllerDropOff,
                      context
                  ),
                  const SizedBox(height: 18),


                  _buildLockedDropdown(
                      TextString.subtitleDropOffFuelLevelStepTwoDropOff,
                      controller.fuelLevelControllerDropOff.text,
                      columnWidth,
                      context
                  ),
                  const SizedBox(height: 18),

// Dropoff Exterior
                  _buildLockedDropdown(
                      TextString.subtitleExteriorCleanlinessStepTwoDropOff2,
                      controller.exteriorCleanlinessControllerDropOff.text,
                      columnWidth,
                      context
                  ),
                  const SizedBox(height: 18),

// Dropoff Interior
                  _buildLockedDropdown(
                      TextString.subtitleInteriorCleanlinessStepTwoDropOff2,
                      controller.interiorCleanlinessControllerDropOff.text,
                      columnWidth,
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

  // Signature Section
  Widget _buildSignatureSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(builder: (context, constraints) {
      if (isMobile) {
        return Column(
          children: [
            _buildPickupSignatureBlock(context),
            const SizedBox(height: 25),
            _buildDropoffSignatureBlock(context),
          ],
        );
      }
      /// Web
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PICKUP
          Expanded(
            flex: 1,
            child: _buildPickupSignatureBlock(context),
          ),

          const SizedBox(width: 30),

          // DROPOFF
          Expanded(
            flex: 1,
            child: _buildDropoffSignatureBlock(context),
          ),
        ],
      );
    });
  }
  Widget _buildPickupSignatureBlock(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfScreenColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pickup", style: TTextTheme.dropdowninsideText(context)),
          const SizedBox(height: 15),
          _buildSignatureCard(context, TextString.subtitleOwnerSignatureStepTwoDropOff, "Softsnip", isReadOnly: true, bgColor: AppColors.backgroundOfScreenColor),
          const SizedBox(height: 15),
          _buildSignatureCard(context, TextString.subtitleHirerSignatureStepTwoDropOff, "Softsnip", isReadOnly: true, bgColor: AppColors.backgroundOfScreenColor),
        ],
      ),
    );
  }
  Widget _buildDropoffSignatureBlock(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSignatureCard(context, TextString.subtitleOwnerSignatureStepTwoDropOff, "Softsnip", isReadOnly: false, bgColor: Colors.white),
          const SizedBox(height: 15),
          _buildSignatureCard(context, TextString.subtitleHirerSignatureStepTwoDropOff, "Softsnip", isReadOnly: false, bgColor: Colors.white),
        ],
      ),
    );
  }
  Widget _buildSignatureCard(BuildContext context, String title, String name, {bool isReadOnly = false, required Color bgColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.titleRadios(context)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style:TTextTheme.h2Style(context) ),
                    const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                    Text(TextString.subtitleFullNameStepTwoDropOff , style: TTextTheme.titleFullName(context)),
                  ],
                ),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(name, style: TTextTheme.h2Style(context)),
                    const Divider(thickness: 1, color: AppColors.tertiaryTextColor),
                    Text(TextString.titleSignatureStepTwoDropOff , style: TTextTheme.titleFullName(context)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Image Sections
  Widget _buildPickupImageBox(BuildContext context) {
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
  Widget _buildPickupImageBox2(BuildContext context) {
    bool isMobileView = MediaQuery.of(context).size.width < 600;

    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      dashPattern: const [8, 6],
      color: AppColors.tertiaryTextColor,
      strokeWidth: 1.5,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
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
                  border: Border.all(color: AppColors.primaryColor, width: 1),
                  image: DecorationImage(
                    image: AssetImage(ImageString.astonPic),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
          );
        }),
      ),
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
                          Text(TextString.titleCustomerImageStepTwoDropOff, style: TTextTheme.titleOne(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(TextString.titleDriverStepTwoDropOff, style: TTextTheme.btnTwo(context)),
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
                _infoBlock(IconString.smsIcon, TextString.titleEmailStepTwoDropOff, "Contact@SoftSnip.com.au", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.callIcon, TextString.titleContactStepTwoDropOff, "+12 3456 7890", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.location, TextString.titleAddressStepTwoDropOff, "Toronto, California, 1234", context),
                const SizedBox(width: 12),
                _infoBlock(IconString.nidIcon, TextString.titleNidStepTwoDropOff, "123 456 789", context),
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
              Text(TextString.titleCustomerImageStepTwoDropOff, style: TTextTheme.titleOne(context)),
              Text(TextString.titleDriverStepTwoDropOff, style: TTextTheme.btnTwo(context)),
            ],
          ),
        ],
      ),

      /// INFO BLOCKS
      const SizedBox(width: 20),
      _infoBlock(IconString.smsIcon, TextString.titleEmailStepTwoDropOff, "Contact@SoftSnip.com.au", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.callIcon,  TextString.titleContactStepTwoDropOff, "+12 3456 7890", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.location, TextString.titleAddressStepTwoDropOff, "Toronto, California, 1234", context),
      const SizedBox(width: 15),
      _infoBlock(IconString.nidIcon, TextString.titleNidStepTwoDropOff, "123 456 789", context),
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
                            Text(TextString.titleCarImageStepTwoDropOff, style: TTextTheme.titleSix(context), overflow: TextOverflow.ellipsis),
                            Text(TextString.titleCarImage2StepTwoDropOff, style: TTextTheme.h3Style(context), overflow: TextOverflow.ellipsis),
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
                  _infoRowTag(label: TextString.titleRegistrationStepTwoDropOff, value: "1234567890", context: context),
                  const SizedBox(width: 10),
                  _infoRowTag(
                    label:TextString.titleVinStepTwoDropOff,
                    value: "JTNBA3HK003001234",
                    labelColor: AppColors.backgroundOfVin,
                    context: context,
                  ),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label:TextString.titleTransmissionStepTwoDropOff, value: "Auto", imagePath: IconString.transmissionIcon),
                  const SizedBox(width: 30),
                  _buildSpecColumn(context, label: TextString.titleCapacityStepTwoDropOff, value: "2 seats", imagePath: IconString.capacityIcon),
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
              Text(TextString.titleCarImageStepTwoDropOff, style: TTextTheme.titleFour(context)),
              Text(TextString.titleCarImage2StepTwoDropOff, style: TTextTheme.h3Style(context)),

              if (!enableScroll) ...[
                const SizedBox(height: 12),
                _infoRowTag(label: TextString.titleRegistrationStepTwoDropOff, value: "1234567890", context: context),
                const SizedBox(height: 8),
                _infoRowTag(
                  label:TextString.titleVinStepTwoDropOff,
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
            _infoRowTag(label: TextString.titleRegistrationStepTwoDropOff, value: "1234567890", context: context),
            const SizedBox(width: 10),
            _infoRowTag(
              label: TextString.titleVinStepTwoDropOff,
              value: "JTNBA3HK003001234",
              labelColor: AppColors.backgroundOfVin,
              context: context,
            ),
          ],
        ),

      _buildSpecColumn(context, label: TextString.titleTransmissionStepTwoDropOff, value: "Automatic", imagePath: IconString.transmissionIcon),
      _buildSpecColumn(context, label: TextString.titleCapacityStepTwoDropOff, value: "2 seats", imagePath: IconString.capacityIcon),

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
  Widget _buildMiniInputField(String label, String hint, double width, TextEditingController txtController, BuildContext context, {bool isReadOnly = true}) {
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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              cursorColor: AppColors.blackColor,
              controller: txtController,
              readOnly: isReadOnly,
              enabled: !isReadOnly,

              textAlignVertical: TextAlignVertical.center,
              style: TTextTheme.insidetextfieldWrittenText(context),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
                isDense: true,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLockedDropdown(String label, String value, double width, BuildContext context) {
    String displayValue = value.isEmpty ? (label.contains("Fuel") ? "Full (100%)" : "Excellent") : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle_outline, size: 18, color: AppColors.blackColor),
              const SizedBox(width: 8),
              Text(displayValue, style: TTextTheme.pOne(context)),
            ],
          ),
        ),
      ],
    );
  }




}


