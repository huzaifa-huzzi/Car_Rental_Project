import 'package:car_rental_project/Portal/Vendor/Customers/CustomersController.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/Portal/Vendor/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class StepOneSelectionWidget extends StatelessWidget {
  final PickupCarController controller = Get.find();

  StepOneSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.isCustomerDropdownOpen.value = false;
          controller.isCarDropdownOpen.value = false;
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            double totalWidth = constraints.maxWidth;
            bool isMobile = AppSizes.isMobile(context);
            bool isTablet = AppSizes.isTablet(context);
            final screenWidth = MediaQuery.sizeOf(context).width;
            double padding = 24.0;
            double buttonWidth = (isMobile || isTablet)
                ? (totalWidth - (padding * 2))
                : (totalWidth - 48) * (2.8 / 5);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    Container(
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
                                Text(TextString.titleAddHeader, style: TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis, maxLines: 1),
                                const SizedBox(height: 6),
                                Text(TextString.subtitleHeader, style: TTextTheme.titleThree(context), overflow: TextOverflow.ellipsis, maxLines: 1),
                                const SizedBox(height: 7),
                                _buildStepBadges(context),
                                const SizedBox(height: 20),

                                ///  CUSTOMER SECTION
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.customerNameIcon,
                                  title: TextString.titleAddCustomer,
                                  subtitle: TextString.subtitleAddCustomer,
                                  content: Obx(() {
                                    bool hasError = controller.errorMessage.value.contains("customer") && controller.selectedCustomer.value == null;

                                    if (controller.selectedCustomer.value != null) {
                                      return _buildSelectedCustomerDisplay(context);
                                    }

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AddButtonOfPickup(
                                          text: "Select The Customers",
                                          height: 45,
                                          width: buttonWidth,
                                          icon: Image.asset(IconString.pickCarIconArrow, color: Colors.white),
                                          onTap: () {
                                            if (controller.isCarDropdownOpen.value) {
                                              controller.isCarDropdownOpen.value = false;
                                            }
                                            controller.isCustomerDropdownOpen.value = !controller.isCustomerDropdownOpen.value;
                                          },
                                        ),
                                        if (hasError)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text("Required", style: TTextTheme.ErrorStyle(context)),
                                          ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          height: 32,
                                          child: AddPickUpButton(
                                              text: "Add new customer",
                                              width: buttonWidth,
                                              onTap: () {
                                                Get.lazyPut(() => CustomerController());
                                                context.go('/addNewCustomer', extra: {"hideMobileAppBar": true});
                                              }
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                                ),

                                const SizedBox(height: 30),

                                ///  CAR SECTION
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.pickupCarIcon,
                                  title: TextString.titleAddCar,
                                  subtitle: TextString.subtitleAddCar,
                                  content: Obx(() {
                                    bool hasError = controller.errorMessage.value.contains("car") && controller.selectedCar.value == null;
                                    double carButtonWidth = (AppSizes.isMobile(context) || AppSizes.isTablet(context))
                                        ? buttonWidth
                                        : (totalWidth - 48) * (4 / 5);

                                    if (controller.selectedCar.value != null) {
                                      return _buildSelectedCarDisplay(context, controller);
                                    }
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: carButtonWidth,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: hasError ? AppColors.primaryColor : Colors.transparent,
                                                  width: 1.5
                                              ),
                                            ),
                                            child: AddButtonOfPickup(
                                              text: "Select The Car",
                                              height: 45,
                                              width: carButtonWidth,
                                              icon: Image.asset(IconString.pickCarIconArrow),
                                              onTap: () => controller.isCarDropdownOpen.value = !controller.isCarDropdownOpen.value,
                                            ),
                                          ),
                                        ),
                                        if (hasError)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              "Required",
                                              style: TTextTheme.ErrorStyle(context),
                                            ),
                                          ),
                                      ],
                                    );
                                  }),
                                ),
                                const SizedBox(height: 30),

                                ///  RENT PURPOSE
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.rentPurposeIcon,
                                  title: TextString.titleAddRent,
                                  subtitle: TextString.subtitleAddRent,
                                  content: Obx(() {
                                    bool hasError = controller.errorMessage.value.isNotEmpty &&
                                        controller.selectedRentPurpose.value.isEmpty;

                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(color: hasError ? AppColors.primaryColor : Colors.transparent, width: 1)),
                                          ),
                                          child: Wrap(
                                            spacing: 20,
                                            runSpacing: 12,
                                            children: [
                                              _buildRadioButton(
                                                context,
                                                TextString.subtitleAddOne,
                                                controller.selectedRentPurpose.value == TextString.subtitleAddOne,
                                                onTap: () => controller.selectedRentPurpose.value = TextString.subtitleAddOne,
                                              ),
                                              _buildRadioButton(
                                                context,
                                                TextString.subtitleAddTwo,
                                                controller.selectedRentPurpose.value == TextString.subtitleAddTwo,
                                                onTap: () => controller.selectedRentPurpose.value = TextString.subtitleAddTwo,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (hasError)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text("Required", style: TTextTheme.ErrorStyle(context)),
                                          ),
                                      ],
                                    );
                                  }),
                                ),

                                const SizedBox(height: 30),

                                ///  WEEKLY RENT SECTION
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.rentMoneyIcon,
                                  title: TextString.titleAddWeekly,
                                  subtitle: TextString.subtitleAddWeekly,
                                  content: Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: [
                                      _buildMiniInputField(TextString.titleAddWeeklyInputFieldOne, TextString.subtitleAddWeeklyInputFieldOne, isMobile ? double.infinity : 200, controller.weeklyRentController2, context),
                                      _buildMiniInputField(TextString.titleAddWeeklyInputFieldTwo, TextString.subtitleAddWeeklyInputFieldTwo, isMobile ? double.infinity : 200, controller.dailyRentController2, context),
                                    ],
                                  ),
                                ),

                                const SizedBox(height: 30),

                                ///  BOND PAYMENT SECTION
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.bondPaymentIcon,
                                  title: TextString.titleAddBond,
                                  subtitle: TextString.subtitleAddBond,
                                  content: Wrap(
                                    spacing: 15,
                                    runSpacing: 15,
                                    children: [
                                      _buildMiniInputField(TextString.titleAddBondInputFieldOne, TextString.subtitleAddBondInputFieldOne, isMobile ? double.infinity : 200, controller.bondAmountController2, context),
                                      _buildMiniInputField(TextString.titleAddBondInputFieldTwo, TextString.subtitleAddBondInputFieldTwo, isMobile ? double.infinity : 200, controller.paidBondController2, context),
                                      _buildMiniInputField(TextString.titleAddBondInputFieldThree, TextString.subtitleAddBondInputFieldThree, isMobile ? double.infinity : 200, controller.leftBondController2, context),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),

                                /// PAYMENT METHOD SECTION
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.paymentMethodIcon,
                                  title: TextString.titleAddPayment,
                                  subtitle: TextString.subtitleAddPayment,
                                  content: Obx(() => Wrap(
                                    spacing: 20,
                                    runSpacing: 10,
                                    children: [
                                      _buildRadioButton(context, TextString.subtitleAddPaymentOne, controller.isManualPayment.value, onTap: () => controller.isManualPayment.value = true),
                                      _buildRadioButton(context, TextString.subtitleAddPaymentTwo, !controller.isManualPayment.value, onTap: () => controller.isManualPayment.value = false),
                                    ],
                                  )),
                                ),

                                const SizedBox(height: 30),

                                ///  CAR REPORT
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.carReportIcon,
                                  title: TextString.titleAddCarReport,
                                  subtitle: TextString.subtitleAddCarReport,
                                  content: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double itemWidth = screenWidth < 600 ? constraints.maxWidth : (constraints.maxWidth - 30) / 3;
                                      return Wrap(
                                        spacing: 15,
                                        runSpacing: 20,
                                        children: [
                                          _buildMiniInputField(TextString.titleAddCarReportInputFieldOne, TextString.subtitleAddCarReportInputFieldOne, itemWidth, controller.odoAddController, context),
                                          _buildReportDropdown(TextString.titleAddCarReportInputFieldTwo, ["Full 100%", "High 75%", "Half 50%", "Low 25%", "Empty 0%"], itemWidth, controller.fuelLevelAddController, context,),
                                          _buildReportDropdown(TextString.titleAddCarReportInputFieldThree, ["Excellent", "Good", "Average", "Dirt"], itemWidth, controller.interiorCleanlinessAddController, context, ),
                                          _buildReportDropdown(TextString.titleAddCarReportInputFieldFour, ["Excellent", "Good", "Average", "Dirty"], itemWidth, controller.exteriorCleanlinessAddController, context,),
                                        ],
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 30),

                                ///  PICKUP NOTE
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.pickupNote,
                                  title: TextString.titleAddNote,
                                  subtitle: TextString.subtitleAddNote,
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(TextString.subtitleAddNoteOne, style: TTextTheme.titleTwo(context)),
                                      const SizedBox(height: 12),
                                      Obx(() {
                                        bool hasError = controller.errorMessage.value.isNotEmpty &&
                                            controller.additionalAddCommentsController.text.isEmpty;

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondaryColor,
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: hasError ? AppColors.primaryColor : Colors.transparent,
                                                    width: 1.5
                                                ),
                                              ),
                                              child: TextField(
                                                cursorColor: AppColors.blackColor,
                                                controller: controller.additionalAddCommentsController,
                                                maxLines: 6,
                                                style: TTextTheme.insidetextfieldWrittenText(context),
                                                decoration: InputDecoration(
                                                  hintText: TextString.subtitleViewEditPickup,
                                                  hintStyle: TTextTheme.titleFour(context),
                                                  filled: false,
                                                  fillColor: Colors.transparent,
                                                  contentPadding: const EdgeInsets.all(16),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            if (hasError)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 6, left: 4),
                                                child: Text("Note is required", style: TTextTheme.ErrorStyle(context)),
                                              ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),

                                ///  RENT TIME
                                _buildSelectionRow(
                                  context,
                                  icon: IconString.rentTimeIcon,
                                  title: TextString.titleAddRentTime,
                                  subtitle: TextString.subtitleAddDRentTime,
                                  content: _buildRentTimeSection(context),
                                ),
                                const SizedBox(height: 12)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buttonSection(context, isMobile),
                    SizedBox(height: isMobile ? 230 : 180),
                  ],
                ),

                /// Overlays
                Obx(() {
                  if (controller.isCustomerDropdownOpen.value || controller.isCarDropdownOpen.value) {
                    return Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          controller.isCustomerDropdownOpen.value = false;
                          controller.isCarDropdownOpen.value = false;
                        },
                        child: Container(color: Colors.transparent),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                /// Dropdowns logic
                Obx(() {
                  if (!controller.isCustomerDropdownOpen.value) return const SizedBox.shrink();
                  double topOffset = isMobile ? 250 : (isTablet ? 250 : 195);
                  double rightOffset = isMobile ? 24 : (isTablet ? screenWidth * 0.034 : screenWidth * 0.078);
                  return Positioned(
                    top: topOffset,
                    right: rightOffset,
                    child: Material(
                      elevation: 25,
                      borderRadius: BorderRadius.circular(12),
                      shadowColor: AppColors.quadrantalTextColor,
                      child: _buildModernDropdown(context, buttonWidth, controller),
                    ),
                  );
                }),

                Obx(() {
                  if (!controller.isCarDropdownOpen.value) return const SizedBox.shrink();
                  bool isCustomerSelected = controller.selectedCustomer.value != null;
                  double topOffset;
                  if (isMobile) {
                    topOffset = isCustomerSelected ? 560 : 480;
                  } else if (isTablet) {
                    topOffset = isCustomerSelected ? 600 : 490;
                  } else {
                    topOffset = isCustomerSelected ? 460 : 362;
                  }
                  double rightOffset = isMobile ? 24.0 : (isTablet ? screenWidth * 0.04 : screenWidth * 0.04);
                  double carDropdownWidth = (isMobile || isTablet) ? buttonWidth : (totalWidth - 48) * (3.5 / 5);

                  return Positioned(
                    top: topOffset,
                    right: rightOffset,
                    child: Material(
                      elevation: 25,
                      borderRadius: BorderRadius.circular(15),
                      shadowColor: AppColors.quadrantalTextColor,
                      child: _buildCarModernDropdown(context, carDropdownWidth, controller),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }


  /// --------- Extra Widget ----------///

  // selectionRow
  Widget _buildSelectionRow(BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    required Widget content,
    Widget? trailing,
  }) {
    bool useVerticalLayout = AppSizes.isMobile(context) || AppSizes.isTablet(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.tertiaryTextColor, width: 0.7),
      ),
      child: useVerticalLayout
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(icon, width: 24, height: 24),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        title,
                        style: TTextTheme.h6Style(context).copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, bottom: 16, top: 4),
            child: Text(
              subtitle,
              style: TTextTheme.titleThree(context).copyWith(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          content,
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(icon, width: 24, height: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: TTextTheme.h6Style(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(
                    subtitle,
                    style: TTextTheme.titleThree(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 8,
            child: content,
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

   // Cars Dropdown
  Widget _buildCarModernDropdown(BuildContext context, double width, PickupCarController controller) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: 15,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    controller: controller.carSearchController,
                    cursorColor: AppColors.blackColor,
                    style: TTextTheme.insidetextfieldWrittenText(context),
                    decoration: InputDecoration(
                      hintText: "Search Car...",
                      hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                      prefixIcon: Icon(Icons.search, size: 20, color: AppColors.secondTextColor),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: controller.carScrollController,
                  child: SingleChildScrollView(
                    controller: controller.carScrollController,
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: List.generate(6, (index) => _buildCarCardItem(context, controller)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCarCardItem(BuildContext context, PickupCarController controller) {
    return Container(
      width: 790,
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: AppColors.sideBoxesColor, blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(ImageString.astonPic, width: 75, height: 48, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 105,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextString.titleAddCarDropdown, style: TTextTheme.dropdownOfCar(context)),
                Text(
                  TextString.subtitleAddCarDropdown,
                  maxLines: 1,
                  style: TTextTheme.dropdownOfCartitle(context),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: AppColors.availableBackgroundColor, borderRadius: BorderRadius.circular(6)),
            child: Text("Available", style: TTextTheme.titleeight(context)),
          ),
          const SizedBox(width: 15),
          _buildInfoChip(TextString.subtitleAddCarDropdownReg, "1234567890", AppColors.textColor, context),
          const SizedBox(width: 8),
          _buildInfoChip(TextString.subtitleAddCarDropdownVin, "JTNBA3HK134567890", AppColors.backgroundOfVin, context),
          const SizedBox(width: 25),
          SizedBox(
            width: 75,
            height: 38,
            child: AddButtonOfPickup(
              text: "Select",
              onTap: () {
                controller.selectedCar.value = <String, dynamic>{
                  "name": "Martin",
                  "year": "Aston 2025",
                  "reg": "1234567890",
                  "vin": "JTNBA3HK134567890",
                  "image": ImageString.astonPic,
                  "transmission": "Automatic",
                  "seats": "2 seats"
                };
                if (controller.errorMessage.value.contains("car")) {
                  controller.errorMessage.value = "";
                }

                controller.isCarDropdownOpen.value = false;
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSelectedCarDisplay(BuildContext context, PickupCarController controller) {
    var car = controller.selectedCar.value!;

    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      bool isMobile = maxWidth < 680;
      bool isExtraSmall = maxWidth < 350;

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1200),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.tertiaryTextColor, width: 0.7)),
                  child: isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            car['image'],
                            width: isExtraSmall ? 60 : 110,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(car['year'] ?? "2024", style: TTextTheme.titleThree(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text(car['name'] ?? "Velar", style: TTextTheme.h3Style(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          AddButtonOfPickup(text: "View", width: isExtraSmall ? 60 : 70, height: 35, onTap: () {}),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            _buildInfoChip(TextString.subtitleAddCarDropdownReg, car['reg'], AppColors.textColor, context),
                            const SizedBox(width: 10),
                            _buildInfoChip(TextString.subtitleAddCarDropdownVin, car['vin'], AppColors.backgroundOfVin, context),
                            const SizedBox(width: 25),
                            _buildCarSpecIcon(context, IconString.transmissionIcon, TextString.subtitleAddCarDropdownTrans, car['transmission'] ?? "Auto"),
                            const SizedBox(width: 25),
                            _buildCarSpecIcon(context, IconString.capacityIcon, TextString.subtitleAddCarDropdownCap, car['seats'] ?? "2 seats"),
                          ],
                        ),
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(car['image'], width: 140, fit: BoxFit.contain),
                          const SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(car['year'] ?? "2024", style: TTextTheme.titleThree(context)),
                              Text(car['name'] ?? "Velar", style: TTextTheme.h3Style(context)),
                              const SizedBox(height: 10),
                              _buildInfoChip(TextString.subtitleAddCarDropdownReg, car['reg'], AppColors.textColor, context),
                              const SizedBox(height: 8),
                              _buildInfoChip(TextString.subtitleAddCarDropdownVin, car['vin'], AppColors.backgroundOfVin, context),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildCarSpecIcon(context, IconString.transmissionIcon, TextString.subtitleAddCarDropdownTrans, car['transmission'] ?? "Automatic"),
                          const SizedBox(width: 50),
                          _buildCarSpecIcon(context, IconString.capacityIcon, TextString.subtitleAddCarDropdownCap, car['seats'] ?? "2 seats"),
                          const SizedBox(width: 60),
                          AddButtonOfPickup(text: "View", width: 70, height: 38, onTap: () {}),
                        ],
                      ),
                    ],
                  )),
              Positioned(
                top: -12,
                right: -12,
                child: GestureDetector(
                  onTap: () {
                    controller.selectedCar.value = null;
                  },
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),

                    ),
                    child: Center(
                      child: Image.asset(
                        IconString.deleteIcon,
                        color: AppColors.primaryColor,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
  Widget _buildInfoChip(String label, String value, Color color,BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: TTextTheme.titleeight(context),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              value,
              style:TTextTheme.pOne(context),
            ),
          ),
        ],
      ),
    );
  }




  // Customer Display
  Widget _buildSelectedCustomerDisplay(BuildContext context) {
    return Obx(() {
      bool hasError = controller.errorMessage.value.contains("customer") &&
          controller.selectedCustomer.value == null;

      var customer = controller.selectedCustomer.value!;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: hasError ? AppColors.primaryColor : AppColors.tertiaryTextColor,
                width: hasError ? 1.5 : 0.7,
              ),
              boxShadow: hasError
                  ? [BoxShadow(color: AppColors.primaryColor, blurRadius: 10)]
                  : [],
            ),
            child: AppSizes.isMobile(context)
                ? _buildMobileLayout(context, customer)
                : _buildWebLayout(context, customer),
          ),
          Positioned(
            top: -12,
            right: -12,
            child: GestureDetector(
              onTap: () {
                controller.selectedCustomer.value = null;
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Image.asset(
                    IconString.deleteIcon,
                    color: AppColors.primaryColor,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
  Widget _buildWebLayout(BuildContext context, Map customer) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileLayout(context, customer);
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(ImageString.customerUser, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(customer['name'] ?? "Carlie Harvy", style: TTextTheme.h2Style(context)),
                Text(TextString.subtitleAddCustomerDropdownDriver, style: TTextTheme.titleDriver(context)),
              ],
            ),

            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCarSpecIcon(context, IconString.callIcon, TextString.subtitleAddCustomerInputFieldOne, customer['phone'] ?? "+12 3456 7890"),
                    const SizedBox(width: 25),
                    _buildCarSpecIcon(context, IconString.cardIconPickup, TextString.subtitleAddCustomerInputFieldTwo, customer['card'] ?? "1243567434"),
                    const SizedBox(width: 25),
                    _buildCarSpecIcon(context, IconString.licesnseNo, TextString.subtitleAddCustomerInputFieldThree, customer['license'] ?? "1245985642"),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 20),
            AddButtonOfPickup(text: "View", width: 80, height: 44, onTap: () {}),
          ],
        );
      },
    );
  }
  Widget _buildMobileLayout(BuildContext context, Map customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(ImageString.customerUser, width: 55, height: 55, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(customer['name'] ?? "Carlie Harvy", style: TTextTheme.h2Style(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(TextString.subtitleAddCustomerDropdownDriver, style: TTextTheme.titleDriver(context), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AddButtonOfPickup(text: "View", width: 65, height: 38, onTap: () {}),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildCarSpecIcon(context, IconString.callIcon, TextString.subtitleAddCustomerInputFieldOne, customer['phone'] ?? "+12 3456 7890"),
              const SizedBox(width: 30),
              _buildCarSpecIcon(context, IconString.licesnseNo, TextString.subtitleAddCustomerInputFieldTwo, customer['license'] ?? "1245985642"),
              const SizedBox(width: 30),
              _buildCarSpecIcon(context, IconString.cardIconPickup, TextString.subtitleAddCustomerInputFieldThree, customer['card'] ?? "1243567434"),
            ],
          ),
        ),
      ],
    );
  }
  // Helper for Specs Icons
  Widget _buildCarSpecIcon(BuildContext context, String assetPath, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34, height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Image.asset(assetPath, width: 17, height: 17, fit: BoxFit.scaleDown, color: AppColors.textColor),
        ),
        const SizedBox(height: 4),
        Text(label, style: TTextTheme.smallXX(context), maxLines: 1, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 1),
        Text(value, style: TTextTheme.pFive(context)),
      ],
    );
  }



  Widget _buildModernDropdown(BuildContext context, double width, PickupCarController controller) {
    return Obx(() {
      bool hasError = controller.errorMessage.value.isNotEmpty &&
          controller.selectedCustomer.value == null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: AppColors.backgroundOfPickupsWidget,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hasError ? AppColors.primaryColor : AppColors.primaryColor,
                  width: hasError ? 1.5 : 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 38,
                      child: TextField(
                        controller: controller.customerSearchController,
                        cursorColor: AppColors.blackColor,
                        style: TTextTheme.insidetextfieldWrittenText(context),
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search Name, reg etc",
                          hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 180),
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: controller.customerScrollController,
                      child: SingleChildScrollView(
                        controller: controller.customerScrollController,
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              4,
                                  (index) => _buildCustomerCard(context, controller),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          if (hasError)
             Padding(
              padding: EdgeInsets.only(top: 6, left: 8),
              child: Text(
                "Please select a customer",
                style: TTextTheme.ErrorStyle(context),
              ),
            ),
        ],
      );
    });
  }

  // Customer Card inside dropdown
  Widget _buildCustomerCard(BuildContext context, PickupCarController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.fieldsBackground.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage(ImageString.customerUser),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TextString.titleAddCustomerDropdown,
                  style: TTextTheme.pOne(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                    TextString.subtitleAddCustomerDropdown,
                    style: TTextTheme.pFour(context)
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
              width: 65,
              child: Text(TextString.titleAddCustomerYear, style: TTextTheme.pOne(context))
          ),
          const SizedBox(width: 20),
          SizedBox(
              width: 95,
              child: Text(TextString.titleAddCustomerNumber, style: TTextTheme.pOne(context))
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 180,
            child: Text(
              TextString.titleAddCustomerAddress,
              style: TTextTheme.pOne(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 80,
            height: 35,
            child: AddButtonOfPickup(
              text: "Select",
              onTap: () {
                controller.selectedCustomer.value = {
                  "name": "Jack Morrison",
                  "email": "Jack@rhyta.com",
                  "phone": "+12 3456 7890",
                  "card": "1243567434",
                  "license": "1245985642",
                  "Nid": "123 456 789",
                  "image": ImageString.customerUser,
                };
                if (controller.errorMessage.value.toLowerCase().contains("customer")) {
                  controller.errorMessage.value = "";
                }
                controller.isCustomerDropdownOpen.value = false;
              },
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
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

  // Radio Buttons Widget
  Widget _buildRadioButton(BuildContext context, String text, bool isSelected, {required VoidCallback onTap}) {
    return Obx(() {
      bool hasError = controller.errorMessage.value.isNotEmpty &&
          controller.selectedRentPurpose.value.isEmpty;

      return GestureDetector(
        onTap: () {
          onTap();
          controller.errorMessage.value = "";
        },
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected
                  ? AppColors.blackColor
                  : (hasError ? AppColors.primaryColor
                  : AppColors.blackColor),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TTextTheme.titleRadios(context).copyWith(
                color: hasError && !isSelected ? AppColors.primaryColor: null,
              ),
            ),
          ],
        ),
      );
    });
  }

  // Input Fields Widget
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
        initialValue: txtController.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (_) {
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
            mainAxisSize: MainAxisSize.min,
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
                  border: state.hasError
                      ? Border.all(color: AppColors.primaryColor, width: 1.2)
                      : null,
                ),
                child: TextField(
                  readOnly: isReadOnly,
                  cursorColor: AppColors.blackColor,
                  controller: txtController,
                  textAlignVertical: TextAlignVertical.center,
                  style: TTextTheme.insidetextfieldWrittenText(context),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    state.didChange(val);
                    state.validate();
                  },
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: Text(
                     "Required",
                    style: TTextTheme.ErrorStyle(context),
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

    return SizedBox(
      width: width,
      child: FormField<String>(
        initialValue: txtController.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (txtController.text.trim().isEmpty) {
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
                  state.validate();
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
                    border: state.hasError ? Border.all(color: AppColors.primaryColor, width: 1.2) : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          txtController.text.isEmpty ? "Select Option" : txtController.text,
                          style: TTextTheme.dropdowninsideText(context),
                          overflow: TextOverflow.ellipsis,
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
                  child: Text(
                    state.errorText!,
                    style: TTextTheme.ErrorStyle(context),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }


  // Rent Time Section
  Widget _buildRentTimeSection(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);

    return GetBuilder<PickupCarController>(
      builder: (controller) {
        return Wrap(
          spacing: 40,
          runSpacing: 20,
          children: [
            _buildDateTimeColumn(
              context,
              label: "Agreement Start Time",
              dateController: controller.startDateAddController,
              timeController: controller.startTimeAddController,
              dateLink: controller.startDateLink,
              timeLink: controller.startTimeLink,
              isMobile: isMobile,
            ),
            _buildDateTimeColumn(
              context,
              label: "Agreement End Time",
              dateController: controller.endDateAddController,
              timeController: controller.endTimeAddController,
              dateLink: controller.endDateLink,
              timeLink: controller.endTimeLink,
              isMobile: isMobile,
            ),
          ],
        );
      },
    );
  }

//  Date & Time
  Widget _buildDateTimeColumn(BuildContext context, {
    required String label,
    required TextEditingController dateController,
    required TextEditingController timeController,
    required LayerLink dateLink,
    required LayerLink timeLink,
    required bool isMobile,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth = isMobile ? (screenWidth * 0.85) : 220;

    final carController = Get.find<PickupCarController>();

    return Obx(() {
      bool showDateError = carController.errorMessage.value.isNotEmpty && dateController.text.isEmpty;
      bool showTimeError = carController.errorMessage.value.isNotEmpty && timeController.text.isEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 10),
          CompositedTransformTarget(
            link: dateLink,
            child: _buildCustomTimeBox(
              context,
              controller: dateController,
              hint: "DD/MM/YYYY",
              iconWidget: Image.asset(IconString.calendarIcon, height: 20, width: 20),
              width: fieldWidth,
              borderColor: showDateError ? AppColors.primaryColor : Colors.transparent,
              onTap: () => carController.toggleCalendar(context, dateLink, dateController, fieldWidth),
            ),
          ),
          if (showDateError)
             Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text("Required", style: TTextTheme.ErrorStyle(context)),
            ),

          const SizedBox(height: 12),
          CompositedTransformTarget(
            link: timeLink,
            child: _buildCustomTimeBox(
              context,
              controller: timeController,
              hint: "00:00 AM",
              width: fieldWidth,
              borderColor: showTimeError ? AppColors.primaryColor : Colors.transparent,
              onTap: () => carController.toggleTimePicker(context, timeLink, timeController, fieldWidth),
              iconWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.keyboard_arrow_up, size: 16, color: AppColors.textColor),
                  SizedBox(height: 2),
                  Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textColor),
                ],
              ),
            ),
          ),
          if (showTimeError)
             Padding(
              padding: EdgeInsets.only(top: 4, left: 4),
              child: Text("Required", style: TTextTheme.ErrorStyle(context)),
            ),
        ],
      );
    });
  }

//  Custom Box
  Widget _buildCustomTimeBox(
      BuildContext context, {
        required TextEditingController controller,
        required String hint,
        required double width,
        required VoidCallback onTap,
        required Widget iconWidget,
        Color borderColor = Colors.transparent,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor != Colors.transparent ? borderColor : Colors.transparent,
            width: borderColor != Colors.transparent ? 1.5 : 0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                controller.text.isEmpty ? hint : controller.text,
                style: TTextTheme.insidetextfieldWrittenText(context),
              ),
            ),
            iconWidget,
          ],
        ),
      ),
    );
  }


  // Buttons Widgets
  Widget _buttonSection(BuildContext context, bool isMobile) {
    const double webButtonWidth = 150.0;
    const double webButtonHeight = 45.0;
    final double spacing = AppSizes.padding(context);
    void handleContinue() {
      bool isFormValid = controller.formKey.currentState?.validate() ?? false;
      bool isManualValid = controller.validateForm();

      print("Form State Valid: $isFormValid");
      print("Manual Logic Valid: $isManualValid");

      if (isFormValid && isManualValid) {
        context.push('/stepTwoWidgetScreen', extra: {"hideMobileAppBar": true});
      } else {
        controller.update();

        Get.snackbar(
          "Required Fields",
          "Please fill all marked fields to continue.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      }
    }

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: webButtonHeight,
            child: AddPickUpButton(
              text: 'Cancel',
              backgroundColor: Colors.transparent,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () => Get.back(),
            ),
          ),
          SizedBox(height: spacing),
          SizedBox(
            height: webButtonHeight,
            child: AddButtonOfPickup(
              text: "Continue",
              icon: Image.asset(IconString.continueIcon),
              onTap: handleContinue,
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          const Spacer(),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddPickUpButton(
              text: 'Cancel',
              backgroundColor: Colors.transparent,
              textColor: AppColors.textColor,
              borderColor: AppColors.quadrantalTextColor,
              onTap: () => Get.back(),
            ),
          ),
          SizedBox(width: spacing),
          SizedBox(
            width: webButtonWidth,
            height: webButtonHeight,
            child: AddButtonOfPickup(
              text: "Continue",
              icon: Image.asset(IconString.continueIcon),
              onTap: handleContinue,
            ),
          ),
        ],
      );
    }
  }

}

