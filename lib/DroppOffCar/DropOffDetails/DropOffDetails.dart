import 'package:car_rental_project/DroppOffCar/DropOffController.dart';
import 'package:car_rental_project/DroppOffCar/DropOffDetails/Term&ConditionDropOff.dart';
import 'package:car_rental_project/DroppOffCar/DropOffDetails/VehicleConditionDropOff.dart';
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
import 'package:go_router/go_router.dart';


class DropOffDetails extends StatelessWidget {
  final controller = Get.find<DropOffController>();
   DropOffDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final bool isMobile = AppSizes.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            HeaderWebDropOffWidget(
              mainTitle: 'DropOff Car Details',
              showBack: true,
              showSmallTitle: true,
              smallTitle: 'DropOff Car/DropOff Car Details',
              showSearch: isWeb,
              showSettings: isWeb,
              showAddButton: true,
              showNotification: true,
              showProfile: true,
              onAddPressed: () {
                context.push('/addDropOff', extra: {"hideMobileAppBar": true});
              },
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PAGE HEADER
                    _buildPageHeader(context, isMobile),
                    const SizedBox(height: 20),

                    // TABS SECTION
                    _buildTabs(context),
                    const SizedBox(height: 25),

                    //  TAB CONTENT
                    Obx(() => _buildTabContent(context, isMobile,controller)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    /// Customer and Contract  Screen
  Widget _buildCustomerAndContractTab(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //  Customer Section
        _buildSection(context,
            title: TextString.titleViewCustomerStepTwoDropOff,
            icon: IconString.customerNameIcon,
            child: _buildDetailedCustomerCard(context, isMobile)),
        const SizedBox(height: 25),

        //  Car Section
        _buildSection(context,
            title: TextString.titleViewCarStepTwoDropOff,
            icon: IconString.pickupCarIcon,
            child: _buildDetailedCarCard(context, isMobile)),
        const SizedBox(height: 25),

        //  Rent Purpose & Payment Method
        Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            if (!isMobile) const SizedBox(width: 25) else const SizedBox(height: 25),
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

        //  Rent Amount
        _buildSection(context,
            title: TextString.titleViewRentAmountStepTwoDropOff,
            icon: IconString.rentMoneyIcon,
            child: _buildInfoGrid(context, [
              {"label": TextString.subtitleWeeklyRentStepTwoDropOff, "controller": controller.weeklyRentControllerStepTwo, "hint": "2600 \$"},
              {"label": TextString.subtitleDailyRentStepTwoDropOff, "controller": controller.rentDueAmountControllerStepTwo, "hint": "2600 \$"},
            ], isMobile,)),
        const SizedBox(height: 25),

        // Bond Payment
        _buildSection(
          context,
          title: TextString.titleBondPaymentStepTwoDropOff,
          icon: IconString.bondPaymentIcon,
          child: _buildBondGrid(context, [
            {"label": "Bond Amount", "controller": controller.bondAmountControllerStepTwo, "hint": "2600 \$"},
            {"label": "Paid Bond", "controller": controller.paidBondControllerStepTwo, "hint": "600 \$"},
            {"label": TextString.subtitleLeftBondStepTwoDropOff, "controller": controller.dueBondAmountControllerStepTwo, "hint": "2000 \$"},
            {"label": "Bond Returned", "controller": controller.dueBondReturnedControllerStepTwo, "hint": "2000 \$"},
          ], isMobile),
        ),
        const SizedBox(height: 25),
        //Car Report
        _buildSection(context,
            title: TextString.titleCarReportStepTwoDropOff,
            icon: IconString.carReportIcon,
            child:  _buildCarReportComparison( context,isMobile),),
        const SizedBox(height: 25),
        // DropOff Notes
        _buildSection(context,
            title: TextString.titlePickupNoteStepTwoDropOff,
            icon: IconString.pickupNote,
            child:  _buildDropoffNoteComparison( context, isMobile),),

        const SizedBox(height: 25),
        // Rent Time
        _buildSection(context,
            title: TextString.titleRentTimeStepTwoDropOff,
            icon: IconString.rentTimeIcon,
            child: _buildRentTimeSection( context, isMobile))

      ],
    );
  }


  /// -------- Extra Widgets -------- ///

  Widget _buildTabs(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
        ),
        child: Row(
          children: List.generate(controller.tabs.length, (index) {
            return Obx(() {
              final isSelected = controller.selectedIndex.value == index;
              return GestureDetector(
                onTap: () => controller.changeTab(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    controller.tabs[index],
                    style: isSelected ? TTextTheme.titleSelectedTab(context) : TTextTheme.titleUnselectedTab(context),
                  ),
                ),
              );
            });
          }),
        ),
      ),
    );
  }
  Widget _buildTabContent(BuildContext context, bool isMobile,DropOffController controller) {
    switch (controller.selectedIndex.value) {
      case 0:
        return _buildCustomerAndContractTab(context, isMobile);
      case 1:
        return VehicleConditionDropOff(
          controller: controller,
          isMobile: isMobile,
        );
      case 2:
        return TermandConditionDropOff();
      default:
        return const SizedBox();
    }
  }

  // Info Grids
  Widget _buildInfoGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile, {bool isEditable = false}) {
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
                  cursorColor: AppColors.blackColor,
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
      bool useColumn = constraints.maxWidth < 600;

      return Flex(
        direction: useColumn ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PICKUP NOTES
          Expanded(
            flex: useColumn ? 0 : 1,
            child: _buildCommentField(
              context,
              TextString.titlePickupNoteStepTwoDropOff,
              controller.additionalCommentsControllerStepTwo,
              TextString.subtitleViewPickupStepTwoDropOff,
              isReadOnly: true,
            ),
          ),
          useColumn ? const SizedBox(height: 20) : const SizedBox(width: 20),

          // DROPOFF NOTES
          Expanded(
            flex: useColumn ? 0 : 1,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfPickupsWidget,
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildCommentField(
                context,
                TextString.titlePickupNoteStepTwoDropOFf2,
                controller.additionalCommentsControllerDropOff,
                "Describe the vehicles condition...",
                isReadOnly: true,
              ),
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


   // Header
  Widget _buildPageHeader(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool shouldStack = constraints.maxWidth < 390;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 12,
            children: [
              SizedBox(
                width: shouldStack ? constraints.maxWidth : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextString.titleViewPickStepTwoDropOff,
                      style: TTextTheme.h6Style(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      TextString.titleViewPickStepTwoDropOff,
                      style: TTextTheme.titleThree(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),

              PrimaryBthDropOff(
                text: "Update Bond",
                width: shouldStack ? double.infinity : 130,
                height: 39,
                onTap: () {

                },
              ),
            ],
          ),
        );
      },
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReadOnlyTimePair(context, TextString.subtitleAgreementTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
              const SizedBox(height: 15),
              _buildReadOnlyTimePair(context,  TextString.subtitleAgreementEndTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
            ],
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
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfPickupsWidget,
              borderRadius: BorderRadius.circular(10),
            ),
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
        ),
      ],
    );
  }
  Widget _buildMobileRentTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Pickup Section
        Column(
          children: [
            _buildReadOnlyTimePair(context, TextString.subtitleAgreementTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
            const SizedBox(height: 15),
            _buildReadOnlyTimePair(context,  TextString.subtitleAgreementEndTimeStepTwoPickupDropOff, "02/12/2025", "12:12 PM"),
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
          child:Column(
            children: [
              Text(TextString.subtitleAgreementEndTimeStepTwoDropOff2, style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              _editableTimeField(controller.endDateControllerStepTwo, "25/12/2025", context, isReadOnly: true),
              const SizedBox(height: 8),
              _editableTimeField(controller.endTimeControllerStepTwo, "12:12 PM", context, isReadOnly: true),
            ],
          )
        )

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
      bool useColumn = constraints.maxWidth < 600;

      return Flex(
        direction: useColumn ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE
          Expanded(
            flex: useColumn ? 0 : 1,
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

          useColumn ? const SizedBox(height: 25) : const SizedBox(width: 40),

          /// RIGHT SIDE
          Expanded(
            flex: useColumn ? 0 : 1,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.backgroundOfPickupsWidget,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMiniInputField(
                      TextString.subtitleDropOffOdoStepTwoDropOff,
                      "12457678",
                      double.infinity,
                      controller.odoControllerDropOff,
                      context
                  ),
                  const SizedBox(height: 18),
                  _buildLockedDropdown(
                      TextString.subtitleDropOffFuelLevelStepTwoDropOff,
                      controller.fuelLevelControllerDropOff.text,
                      double.infinity,
                      context
                  ),
                  const SizedBox(height: 18),
                  _buildLockedDropdown(
                      TextString.subtitleExteriorCleanlinessStepTwoDropOff2,
                      controller.exteriorCleanlinessControllerDropOff.text,
                      double.infinity,
                      context
                  ),
                  const SizedBox(height: 18),
                  _buildLockedDropdown(
                      TextString.subtitleInteriorCleanlinessStepTwoDropOff2,
                      controller.interiorCleanlinessControllerDropOff.text,
                      double.infinity,
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
        border: Border.all(color: AppColors.tertiaryTextColor,width: 0.7),
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
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: isMobile ? 18 : 15),
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
                      Center(child: Image.asset(ImageString.astonPic, width: 90)),
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


   // Radio Items
  Widget _toggleStatusTag(BuildContext context, String text, RxBool stateVariable) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.radio_button_checked,
          size: 16,
          color: AppColors.blackColor,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TTextTheme.titleRadios(context),
        ),
      ],
    );
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



