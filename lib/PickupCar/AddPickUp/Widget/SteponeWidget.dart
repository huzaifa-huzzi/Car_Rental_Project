import 'dart:io';
import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/ReusableWidgetOfPickup/AddPickupButton.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class StepOneSelectionWidget extends StatelessWidget {
  final PickupCarController controller = Get.find();

  StepOneSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          final screenWidth = MediaQuery.sizeOf(context).width ;
          double padding = 24.0;

          double buttonWidth = isMobile
              ? (totalWidth - (padding * 2))
              : (totalWidth - 48) * (3 / 5);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStepBadges(context),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(TextString.titleAddHeader, style:TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis, maxLines: 1,),
                          const SizedBox(height: 6),
                          Text(TextString.subtitleHeader, style: TTextTheme.titleThree(context), overflow: TextOverflow.ellipsis, maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  CUSTOMER SECTION
                          _buildSelectionRow(
                            context,
                            icon:IconString.customerNameIcon,
                            title:TextString.titleAddCustomer ,
                            subtitle:TextString.subtitleAddCustomer ,
                            content: Obx(() {
                              if (controller.selectedCustomer.value != null) {
                                return _buildSelectedCustomerDisplay(context);
                              }

                              return Column(
                                children: [
                                  AddButtonOfPickup(
                                    text: "Select The Customers",
                                    height: 45,
                                    width: buttonWidth,
                                    icon:  Image.asset(IconString.pickCarIconArrow, color: Colors.white),
                                    onTap: () {
                                      if (controller.isCarDropdownOpen.value) {
                                        controller.isCarDropdownOpen.value = false;
                                      }
                                      controller.isCustomerDropdownOpen.value = !controller.isCustomerDropdownOpen.value;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 32,
                                    child: AddPickUpButton(
                                        text: "Add new customer",
                                        width: buttonWidth,
                                        onTap: () {
                                          Get.lazyPut(() => CustomerController());
                                          context.push('/addNewCustomer', extra: {"hideMobileAppBar": true});
                                        }
                                    ),
                                  )
                                ],
                              );
                            }),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  CAR SECTION
                          _buildSelectionRow(
                            context,
                            icon: IconString.pickupCarIcon,
                            title: TextString.titleAddCar,
                            subtitle: TextString.subtitleAddCar,
                            content: Obx(() => controller.selectedCar.value != null
                                ? _buildSelectedCarDisplay(context)
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AddButtonOfPickup(
                                  text: "Select The Car",
                                  height: 45,
                                  width: buttonWidth,
                                  icon:  Image.asset(IconString.pickCarIconArrow),
                                  onTap: () => controller.isCarDropdownOpen.value = !controller.isCarDropdownOpen.value,
                                ),
                              ],
                            )
                            ),
                          ),
                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  RENT PURPOSE
                          _buildSelectionRow(
                            context,
                            icon: IconString.rentPurposeIcon,
                            title:TextString.titleAddRent,
                            subtitle: TextString.subtitleAddRent,
                            content: Obx(() => Wrap(
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
                            )),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
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
                    _buildMiniInputField(
                        TextString.titleAddWeeklyInputFieldOne,
                       TextString.subtitleAddWeeklyInputFieldOne,
                        isMobile ? double.infinity : 200,
                        controller.weeklyRentController2,
                        context
                    ),
                    _buildMiniInputField(
                        TextString.titleAddWeeklyInputFieldTwo,
                        TextString.subtitleAddWeeklyInputFieldTwo,
                        isMobile ? double.infinity : 200,
                        controller.dailyRentController2,
                        context
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
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
                    _buildMiniInputField(
                        TextString.titleAddBondInputFieldOne,
                       TextString.subtitleAddBondInputFieldOne,
                        isMobile ? double.infinity : 200,
                        controller.bondAmountController2,
                        context
                    ),
                    _buildMiniInputField(
                        TextString.titleAddBondInputFieldTwo,
                        TextString.subtitleAddBondInputFieldTwo,
                        isMobile ? double.infinity : 200,
                        controller.paidBondController2,
                        context
                    ),
                    _buildMiniInputField(
                        TextString.titleAddBondInputFieldThree,
                        TextString.subtitleAddBondInputFieldThree,
                        isMobile ? double.infinity : 200,
                        controller.leftBondController2,
                        context
                    ),
                  ],
                ),
              ),
                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
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
                                _buildRadioButton(
                                  context,
                                  TextString.subtitleAddPaymentOne,
                                  controller.isManualPayment.value,
                                  onTap: () => controller.isManualPayment.value = true,
                                ),
                                _buildRadioButton(
                                  context,
                                  TextString.subtitleAddPaymentTwo,
                                  !controller.isManualPayment.value,
                                  onTap: () => controller.isManualPayment.value = false,
                                ),
                              ],
                            )),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color:AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  CAR REPORT
                          _buildSelectionRow(
                            context,
                            icon: IconString.carReportIcon,
                            title: TextString.titleAddCarReport,
                            subtitle: TextString.subtitleAddCarReport,
                            content: LayoutBuilder(
                              builder: (context, constraints) {
                                double screenWidth = MediaQuery.of(context).size.width;
                                double itemWidth = screenWidth < 600
                                    ? constraints.maxWidth
                                    : (constraints.maxWidth - 30) / 3;

                                return Wrap(
                                  spacing: 15,
                                  runSpacing: 20,
                                  children: [
                                    _buildMiniInputField(TextString.titleAddCarReportInputFieldOne, TextString.subtitleAddCarReportInputFieldOne, itemWidth, controller.odoAddController,context),
                                    _buildReportDropdown(
                                       TextString.titleAddCarReportInputFieldTwo,
                                        ["Full 100%", "High 75%", "Half 50%", "Low 25%","Empty 0%"],
                                        itemWidth,
                                        controller.fuelLevelAddController,
                                        context
                                    ),
                                    _buildReportDropdown(
                                        TextString.titleAddCarReportInputFieldThree,
                                        ["Excellent", "Good", "Average", "Dirt"],
                                        itemWidth,
                                        controller.interiorCleanlinessAddController,
                                        context
                                    ),
                                    _buildReportDropdown(
                                        TextString.titleAddCarReportInputFieldFour,
                                        ["Excellent", "Good", "Average", "Dirty"],
                                        itemWidth,
                                        controller.exteriorCleanlinessAddController,
                                        context
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  DAMAGE INSPECTION
                          _buildSelectionRow(
                            context,
                            icon: IconString.damageInspection,
                            title: TextString.titleAddDamage,
                            subtitle: TextString.subtitleAddDamage,
                            trailing: _buildToggleWidget(context),
                            content: _buildDamageInspectionCard(context, buttonWidth),
                          ),


                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  PICKUP NOTE
                          _buildSelectionRow(
                            context,
                            icon: IconString.pickupNote,
                            title:TextString.titleAddNote,
                            subtitle: TextString.subtitleAddNote,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(TextString.subtitleAddNoteOne, style:TTextTheme.titleTwo(context)),
                                const SizedBox(height: 8),
                                TextField(
                                  cursorColor: AppColors.blackColor,
                                  controller: controller.additionalAddCommentsController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: 'Describe the vehicles condition, unique features, or rental policies...',
                                    hintStyle:TTextTheme.titleFour(context),
                                    filled: true,
                                    fillColor: AppColors.secondaryColor,
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  CAR PICTURE
                          _buildSelectionRow(
                            context,
                            icon: IconString.carPictureIconPickup,
                            title: TextString.titleAddPicture,
                            subtitle: TextString.subtitleAddPicture,
                            content: _imageBox(context),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  RENT TIME
                          _buildSelectionRow(
                            context,
                            icon: IconString.rentTimeIcon,
                            title: TextString.titleAddRentTime,
                            subtitle: TextString.subtitleAddDRentTime,
                            content: _buildRentTimeSection(context),
                          ),
                          const SizedBox(height: 50),
                          /// Buttons
                          _buttonSection(context,isMobile),

                          const SizedBox(height: 10),


                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///  Customer DROPDOWN OVERLAY
              Obx(() {
                if (!controller.isCustomerDropdownOpen.value) return const SizedBox.shrink();

                //  Responsive TOP Calculation
                double topOffset;
                if (isMobile) {
                  topOffset = 215;
                } else if (isTablet) {
                  topOffset = 165;
                } else {
                  topOffset = 175;
                }

                //  Responsive RIGHT Calculation
                double rightOffset;
                if (isMobile) {
                  rightOffset = 24;
                } else if (isTablet) {
                  rightOffset = screenWidth * 0.072;
                } else {
                  rightOffset = screenWidth * 0.056;
                }

                return Positioned(
                  top: topOffset,
                  right: rightOffset,
                  child: Material(
                    elevation: 25,
                    borderRadius: BorderRadius.circular(12),
                    shadowColor: AppColors.quadrantalTextColor,
                    child: _buildModernDropdown(context, buttonWidth),
                  ),
                );
              }),

              ///  CAR DROPDOWN OVERLAY
              Obx(() {
                if (!controller.isCarDropdownOpen.value) return const SizedBox.shrink();

                bool isCustomerSelected = controller.selectedCustomer.value != null;

                double topOffset;
                if (isMobile) {
                  topOffset = isCustomerSelected ? 535 : 440;
                } else if (isTablet) {
                  topOffset = isCustomerSelected ? 425 : 330;
                } else {
                  topOffset = isCustomerSelected ? 435 : 338;
                }

                double screenWidth = MediaQuery.of(context).size.width;
                double rightOffset = isMobile ? 24.0 : (isTablet ? screenWidth * 0.07 : screenWidth * 0.055);

                return Positioned(
                  top: topOffset,
                  right: rightOffset,
                  child: Material(
                    elevation: 25,
                    borderRadius: BorderRadius.circular(15),
                    shadowColor: AppColors.quadrantalTextColor,
                    child: _buildCarModernDropdown(context, buttonWidth),
                  ),
                );
              }),
            ],
          );
        },
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
    bool isMobile = AppSizes.isMobile(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(icon),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        title,
                        style: TTextTheme.h6Style(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (trailing != null) trailing,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, bottom: 12),
            child: Text(
              subtitle,
              style: TTextTheme.titleThree(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          content,
        ],
      );
    }

    // Web View
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(icon),
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

        const SizedBox(width: 16),

        Expanded(
          flex: 5,
          child: SizedBox(
            width: double.infinity,
            child: content,
          ),
        ),
      ],
    );

  }

   // Cars Dropdown
  Widget _buildCarModernDropdown(BuildContext context, double width) {
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
                    cursorColor: AppColors.blackColor,
                    style:TTextTheme.insidetextfieldWrittenText(context) ,
                    decoration: InputDecoration(
                      hintText: "Search Car...",
                      hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                      prefixIcon: Icon(Icons.search, size: 20, color:AppColors.secondTextColor),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),

              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: IntrinsicWidth(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: List.generate(6, (index) => _buildCarCardItem(context)),
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

  Widget _buildCarCardItem(BuildContext context) {
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
            padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: AppColors.availableBackgroundColor, borderRadius: BorderRadius.circular(6)),
            child:  Text("Available", style: TTextTheme.titleeight(context)),
          ),

          const SizedBox(width: 15),

          _buildInfoChip(TextString.subtitleAddCarDropdownReg, "1234567890", AppColors.textColor,context),

          const SizedBox(width: 8),

          _buildInfoChip(TextString.subtitleAddCarDropdownVin, "JTNBA3HK134567890", AppColors.backgroundOfVin,context),

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
    controller.isCarDropdownOpen.value = false;
    }
            )
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedCarDisplay(BuildContext context) {
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
                    color: AppColors.backgroundOfPickupsWidget,
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                                Text(
                                  car['year'] ?? "2024",
                                  style: TTextTheme.titleThree(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  car['name'] ?? "Velar",
                                  style: TTextTheme.h3Style(context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          AddButtonOfPickup(
                              text: "View",
                              width: isExtraSmall ? 60 : 70,
                              height: 35,
                              onTap: () {}
                          ),
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
                      :
                  Row(
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
                              Text(car['name'] ?? "Velar",
                                  style: TTextTheme.h3Style(context)),
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
                  )
              ),

              // DELETE BUTTON
              Positioned(
                top: -12,
                right: -12,
                child: GestureDetector(
                  onTap: () => controller.selectedCar.value = null,
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




  // Customer Display (web/mobile next two widgets)
  Widget _buildSelectedCustomerDisplay(BuildContext context) {
    var customer = controller.selectedCustomer.value!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundOfPickupsWidget,
            borderRadius: BorderRadius.circular(15),
          ),
          child: AppSizes.isMobile(context)
              ? _buildMobileLayout(context, customer)
              : _buildWebLayout(context, customer),
        ),

        //  DELETE BUTTON
        Positioned(
          top: -12,
          right: -12,
          child: GestureDetector(
            onTap: () => controller.selectedCustomer.value = null,
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
  }

  Widget _buildWebLayout(BuildContext context, Map customer) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool canFitGrid = constraints.maxWidth > 600;

        if (!canFitGrid) {
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
                Text(
                  customer['name'] ?? "Carlie Harvy",
                  style: TTextTheme.h2Style(context),
                ),
                Text(TextString.subtitleAddCustomerDropdownDriver, style: TTextTheme.titleDriver(context)),
              ],
            ),

            const Spacer(flex: 1),
            Flexible(
              flex: 8,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildCarSpecIcon(context, IconString.callIcon,TextString.subtitleAddCustomerInputFieldOne, customer['phone'] ?? "+12 3456 7890")),
                        Expanded(child: _buildCarSpecIcon(context, IconString.cardIconPickup,TextString.subtitleAddCustomerInputFieldTwo , customer['card'] ?? "1243567434")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildCarSpecIcon(context, IconString.licesnseNo,TextString.subtitleAddCustomerInputFieldThree , customer['license'] ?? "1245985642")),
                        Expanded(child: _buildCarSpecIcon(context, IconString.nidIcon, TextString.subtitleAddCustomerInputFieldFour, customer['Nid'] ?? "123 456 789")),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(flex: 1),

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
                  Text(
                    customer['name'] ?? "Carlie Harvy",
                    style: TTextTheme.h2Style(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    TextString.subtitleAddCustomerDropdownDriver,
                    style: TTextTheme.titleDriver(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            AddButtonOfPickup(
                text: "View",
                width: 65,
                height: 38,
                onTap: () {}
            ),
          ],
        ),
        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildCarSpecIcon(context, IconString.callIcon,TextString.subtitleAddCustomerInputFieldOne , customer['phone'] ?? "+12 3456 7890"),
              const SizedBox(width: 20),
              _buildCarSpecIcon(context, IconString.licesnseNo, TextString.subtitleAddCustomerInputFieldTwo, customer['license'] ?? "1245985642"),
              const SizedBox(width: 20),
              _buildCarSpecIcon(context, IconString.cardIconPickup,TextString.subtitleAddCustomerInputFieldThree, customer['card'] ?? "1243567434"),
              const SizedBox(width: 20),
              _buildCarSpecIcon(context, IconString.nidIcon, TextString.subtitleAddCustomerInputFieldFour, customer['Nid'] ?? "123 456 789"),
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
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Image.asset(
            assetPath,
            width: 17,
            height: 17,
            fit: BoxFit.scaleDown,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TTextTheme.smallXX(context),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: TTextTheme.pFive(context),
        ),
      ],
    );
  }



  // Dropdown of customers
  Widget _buildModernDropdown(BuildContext context, double width) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 38,
                child: TextField(
                  cursorColor: AppColors.blackColor,
                  style:TTextTheme.insidetextfieldWrittenText(context) ,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search Name,reg etc",
                    hintStyle: TTextTheme.insidetextfieldWrittenText(context),
                    prefixIcon: const Icon(Icons.search, size: 18),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 180),
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(4, (index) => _buildCustomerCard(context)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Customer Card inside dropdown
  Widget _buildCustomerCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
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
                Text(TextString.titleAddCustomerDropdown, style: TTextTheme.pOne(context),overflow: TextOverflow.ellipsis,maxLines: 1,),
                Text(TextString.subtitleAddCustomerDropdown, style: TTextTheme.pFour(context)),
              ],
            ),
          ),
          const SizedBox(width: 20),
           SizedBox(width: 65, child: Text(TextString.titleAddCustomerYear, style: TTextTheme.pOne(context))),
          const SizedBox(width: 20),
           SizedBox(width: 95, child: Text(TextString.titleAddCustomerNumber, style: TTextTheme.pOne(context))),
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
                  "image": ImageString.customerUser,
                };
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
  Widget _buildStepBadge(String text, bool isActive,BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.backgroundOfPickupsWidget,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Text(text, style: TTextTheme.btnWhiteColor(context)),
    );
  }
  Widget _buildStepBadges(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [_buildStepBadge("Step 1", true,context), const SizedBox(width: 8), _buildStepBadge("Step 2", false,context)],
      ),
    );
  }

  // Radio Buttons Widget
  Widget _buildRadioButton(BuildContext context,String text, bool isSelected, {required VoidCallback onTap}){
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: AppColors.blackColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
              text,
              style: TTextTheme.titleRadios(context),
          ),
        ],
      ),
    );
  }

  // Input Fields Widget
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

  // Damage Inspection Card Widgets
  Widget _buildDamageInspectionCard(BuildContext context, double cardWidth) {
    bool isMobile = AppSizes.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 15,
          runSpacing: 15,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (!isMobile) _buildToggleWidget(context),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.secondaryColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.damageTypes2.map((type) {
                  bool isSelected = controller.selectedDamageType2.value == type['id'];

                  return GestureDetector(
                    onTap: () {
                      if (controller.isDamageInspectionOpen.value) {
                        controller.selectedDamageType2.value = type['id'];
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ?AppColors.secondaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(color: type['color'], shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                type['id'].toString(),
                                style: TTextTheme.btnNumbering(context),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              type['label'],
                              style: TTextTheme.titleSix(context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
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

        /// 2. Interactive Car Diagram
        Obx(() {
          double width = cardWidth > 500 ? 500 : cardWidth;
          double height = width * 0.75;

          return IgnorePointer(
            ignoring: !controller.isDamageInspectionOpen.value,
            child: Opacity(
              opacity: controller.isDamageInspectionOpen.value ? 1.0 : 0.4,
              child: Center(
                child: GestureDetector(
                  onTapDown: (details) {
                    double dx = details.localPosition.dx / width;
                    double dy = details.localPosition.dy / height;

                    int existingIndex = controller.damagePoints2.indexWhere((p) =>
                    (p.dx - dx).abs() < 0.05 && (p.dy - dy).abs() < 0.05
                    );

                    if (existingIndex != -1) {
                      controller.damagePoints2.removeAt(existingIndex);
                    } else {
                      var type = controller.damageTypes2.firstWhere((t) => t['id'] == controller.selectedDamageType2.value);
                      controller.damagePoints2.add(DamagePoint(
                        dx: dx,
                        dy: dy,
                        typeId: type['id'],
                        color: type['color'],
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
                        fit: BoxFit.contain,
                      ),
                      ...controller.damagePoints2.map((point) {
                        return Positioned(
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
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
  Widget _buildToggleWidget(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: () => controller.isDamageInspectionOpen.value = !controller.isDamageInspectionOpen.value,
      child: Container(
        width: 70,
        height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: controller.isDamageInspectionOpen.value ? AppColors.primaryColor : AppColors.quadrantalTextColor,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: controller.isDamageInspectionOpen.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              ),
            ),
            Align(
              alignment: controller.isDamageInspectionOpen.value ? const Alignment(-0.6, 0) : const Alignment(0.6, 0),
              child: Text(
                controller.isDamageInspectionOpen.value ? "Yes" : "No",
                style:TTextTheme.btnWhiteColor(context),
              ),
            ),
          ],
        ),
      ),
    ));
  }


  // Image Box Widget
  Widget _imageBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
           TextString.titleAddImage,
            style: TTextTheme.titleTwo(context),
          ),
        ),

        GestureDetector(
          onTap: () => controller.pickImage2(),
          child: Obx(() {
            final imagesList = controller.AddpickupCarImages;

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
                child: imagesList.isEmpty
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
                    Text(TextString.subtitleAddImage, style: TTextTheme.btnOne(context)),
                    Text(TextString.subtitleAddImage2, style: TTextTheme.documnetIsnideSmallText2(context)),
                  ],
                )
                    : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: imagesList.asMap().entries.map((entry) {
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
                            onTap: () => controller.removeImage2(index),
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
        ),
      ],
    );
  }

  // Rent time Widgets
  Widget _buildRentTimeSection(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);

    return Flex(
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMobile
            ? _buildStartTimeColumn(context)
            : Expanded(child: _buildStartTimeColumn(context)),

        isMobile ? const SizedBox(height: 20) : const SizedBox(width: 40),

        isMobile
            ? _buildEndTimeColumn(context)
            : Expanded(child: _buildEndTimeColumn(context)),
      ],
    );
  }
  Widget _buildStartTimeColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.titleAddAgreementTime, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(controller.startDateAddController, "DD/MM/YYYY", context),
        const SizedBox(height: 8),
        _editableTimeField(controller.startTimeAddController, "Time:", context),
      ],
    );
  }
  Widget _buildEndTimeColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.titleAddAgreementEndTime, style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(controller.endDateAddController, "DD/MM/YYYY", context),
        const SizedBox(height: 8),
        _editableTimeField(controller.endTimeAddController, "Time:", context),
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

  // Buttons Widgets
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
              text: "Continue",
              icon: Image.asset(
                IconString.continueIcon,
              ),
              onTap: () {
                context.push('/stepTwoWidgetScreen', extra: {"hideMobileAppBar": true});
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
              text: "Continue",
              icon: Image.asset(
                IconString.continueIcon,
              ),
              onTap: () {
                context.push('/stepTwoWidgetScreen', extra: {"hideMobileAppBar": true});
              },
            ),
          ),

        ],
      );
    }
  }

}

