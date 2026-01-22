import 'dart:io';
import 'package:car_rental_project/Customers/CustomersController.dart';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/AddButtonOfPickup.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/AddPickupButton.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
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
                           Text("Add Pickup Car", style:TTextTheme.h6Style(context), overflow: TextOverflow.ellipsis, maxLines: 1,),
                          const SizedBox(height: 6),
                          Text("Enter the specification for the pre rental details", style: TTextTheme.titleThree(context), overflow: TextOverflow.ellipsis, maxLines: 1,
                          ),
                          const SizedBox(height: 20),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  CUSTOMER SECTION
                          _buildSelectionRow(
                            context,
                            icon:IconString.customerNameIcon,
                            title: "Customer",
                            subtitle: "Select a customer or add new customer",
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
                                    icon: const Icon(Icons.near_me_rounded, size: 16, color: Colors.white),
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
                            title: "Car",
                            subtitle: "Select a Car",
                            content: Obx(() => controller.selectedCar.value != null
                                ? _buildSelectedCarDisplay(context)
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AddButtonOfPickup(
                                  text: "Select The Car",
                                  height: 45,
                                  width: buttonWidth,
                                  icon: const Icon(Icons.near_me_rounded, size: 16, color: Colors.white),
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
                            title: "Rent Purpose",
                            subtitle: "Select any Option",
                            content: Obx(() => Wrap(
                              spacing: 20,
                              runSpacing: 12,
                              children: [
                                _buildRadioButton(
                                  context,
                                  "Personal Use",
                                  controller.selectedRentPurpose.value == "Personal Use",
                                  onTap: () => controller.selectedRentPurpose.value = "Personal Use",
                                ),
                                _buildRadioButton(
                                  context,
                                  "Commercial Use",
                                  controller.selectedRentPurpose.value == "Commercial Use",
                                  onTap: () => controller.selectedRentPurpose.value = "Commercial Use",
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
                title: "Weekly Rent",
                subtitle: "Select any Option",
                content: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    _buildMiniInputField(
                        "Weekly Rent",
                        "Write Rent Amount...",
                        isMobile ? double.infinity : 200,
                        controller.weeklyRentController2,
                        context
                    ),
                    _buildMiniInputField(
                        "Daily Rent",
                        "Write Rent Amount...",
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
                title: "Bond Payment",
                subtitle: "Select any Option",
                content: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    _buildMiniInputField(
                        "Bond Amount",
                        "Write Rent Amount...",
                        isMobile ? double.infinity : 200,
                        controller.bondAmountController2,
                        context
                    ),
                    _buildMiniInputField(
                        "Paid Bond",
                        "Write Bond Amount...",
                        isMobile ? double.infinity : 200,
                        controller.paidBondController2,
                        context
                    ),
                    _buildMiniInputField(
                        "Left Bond",
                        "Write Due Bond Amount...",
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
                            title: "Payment Method",
                            subtitle: "Select any Option",
                            content: Obx(() => Wrap(
                              spacing: 20,
                              runSpacing: 10,
                              children: [
                                _buildRadioButton(
                                  context,
                                  "Manual Payments",
                                  controller.isManualPayment.value,
                                  onTap: () => controller.isManualPayment.value = true,
                                ),
                                _buildRadioButton(
                                  context,
                                  "Auto Payments",
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
                            title: "Car Report",
                            subtitle: "Fill the Report",
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
                                    _buildMiniInputField("Pickup ODO", "12457578", itemWidth, controller.odoController,context),
                                    _buildReportDropdown(
                                        "Pickup Fuel Level",
                                        ["Full 100%", "High 75%", "Half 50%", "Low 25%","Empty 0%"],
                                        itemWidth,
                                        controller.fuelLevelController,
                                        context
                                    ),
                                    _buildReportDropdown(
                                        "Pickup Interior Cleanliness",
                                        ["Excellent", "Good", "Average", "Dirt"],
                                        itemWidth,
                                        controller.interiorCleanlinessController,
                                        context
                                    ),
                                    _buildReportDropdown(
                                        "Pickup Exterior Cleanliness",
                                        ["Excellent", "Good", "Average", "Dirty"],
                                        itemWidth,
                                        controller.exteriorCleanlinessController,
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
                            title: "Damage Inspection",
                            subtitle: "Fill the Report",
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
                            title: "Pickup Note",
                            subtitle: "Fill the Report",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pickup Comments", style:TTextTheme.titleTwo(context)),
                                const SizedBox(height: 8),
                                TextField(
                                  cursorColor: AppColors.blackColor,
                                  controller: controller.additionalCommentsController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: "Describe the vehicle's condition, unique features...",
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
                            title: "Car Picture",
                            subtitle: "Fill the Picture",
                            content: _imageBox(context),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 0.5, color: AppColors.quadrantalTextColor),
                          const SizedBox(height: 30),

                          ///  RENT TIME 
                          _buildSelectionRow(
                            context,
                            icon: IconString.rentTimeIcon,
                            title: "Rent Time",
                            subtitle: "Select any Option",
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
                double topOffset = isMobile ? 210 : 160;
                return Positioned(
                  top: topOffset,
                  right: 24,
                  child: _buildModernDropdown(context, buttonWidth),
                );
              }),

              ///  CAR DROPDOWN OVERLAY
              Obx(() {
                if (!controller.isCarDropdownOpen.value) return const SizedBox.shrink();
                double topOffset = isMobile ? 430 : 315;

                return Positioned(
                  top: topOffset,
                  right: 24,
                  child: _buildCarModernDropdown(context, buttonWidth),
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

        const SizedBox(width: 16), // 👈 thora sa controlled gap

        Expanded(
          flex: 5, // 👈 CONTENT KO REAL SPACE
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
                Text("Aston 2025", style: TTextTheme.dropdownOfCar(context)),
                Text(
                  "Martin",
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

          _buildInfoChip("Registration", "1234567890", AppColors.textColor,context),

          const SizedBox(width: 8),

          _buildInfoChip("VIN", "JTNBA3HK134567890", AppColors.backgroundOfVin,context),

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

      return Center(
        child: ConstrainedBox(
          // Web par card ko width limit di taaki spacing screenshot jaisi phaili hui aaye
          constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 1200),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8F9), // Screenshot wala light pink bg
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFFFE5E7)),
                ),
                child: isMobile
                    ? Column( // --- MOBILE LAYOUT (Scrollable) ---
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(car['image'], width: 120),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(car['year'] ?? "2024", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                    Text(car['name'] ?? "Velar", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AddButtonOfPickup(text: "View", width: 70, onTap: () {}),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildInfoChip("Registration", car['reg'], const Color(0xFF1B254B),context),
                          const SizedBox(width: 10),
                          _buildInfoChip("VIN", car['vin'], const Color(0xFF4299E1),context),
                          const SizedBox(width: 30),
                          _buildCarSpecIcon(IconString.transmissionIcon, "Transmission", car['transmission'] ?? "Auto"),
                          const SizedBox(width: 30),
                          _buildCarSpecIcon(IconString.capacityIcon, "Capacity", car['seats'] ?? "2 seats"),
                        ],
                      ),
                    ),
                  ],
                )
                    : // --- WEB LAYOUT ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. LEFT: Car Image & Info
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(car['image'], width: 140, fit: BoxFit.contain),
                        const SizedBox(width: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(car['year'] ?? "2024", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            Text(car['name'] ?? "Velar",
                                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1B254B))),
                            const SizedBox(height: 10),
                            _buildInfoChip("Registration", car['reg'], const Color(0xFF1B254B),context),
                            const SizedBox(height: 8),
                            _buildInfoChip("VIN", car['vin'], const Color(0xFF4299E1),context),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        _buildCarSpecIcon(IconString.transmissionIcon, "Transmission", car['transmission'] ?? "Automatic"),
                        const SizedBox(width: 50),
                        _buildCarSpecIcon(IconString.capacityIcon, "Capacity", car['seats'] ?? "2 seats"),
                        const SizedBox(width: 60),
                        AddButtonOfPickup(text: "View", width: 70, height: 38, onTap: () {}),
                      ],
                    ),
                  ],
                )
              ),

              // --- DELETE BUTTON (Bin Icon) ---
              // --- EXACT CIRCULAR DELETE BUTTON DESIGN ---
              Positioned(
                top: -12, // Thora aur bahar nikalne ke liye
                right: -12,
                child: GestureDetector(
                  onTap: () => controller.selectedCar.value = null,
                  child: Container(
                    width: 32, // Fixed width aur height se hi perfect circle banta hai
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFE5E7), width: 1), // Light pink border
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 2), // Neeche ki taraf halki shadow
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.delete_outline,
                        color: Color(0xFFFF4D4F), // Exactly wahi red jo screenshot mein hai
                        size: 18,
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

// Helper for Specs Icons
  Widget _buildCarSpecIcon(String assetPath, String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 34,   // ↓ 36
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Image.asset(
            assetPath,
            width: 17,
            height: 17,
          ),
        ),

        const SizedBox(height: 4), // ↓ 6

        Text(
          label,
          style: const TextStyle(fontSize: 9, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 1),

        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5, // ↓ thora sa
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B254B),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }



  Widget _buildSelectedCustomerDisplay(BuildContext context) {
    var customer = controller.selectedCustomer.value!;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 950; // Tablet aur Mobile ka threshold

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20), // Thori zyada padding design ke liye
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8F9),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFFFFE5E7), width: 1.5),
          ),
          child: isMobile
              ? _buildMobileLayout(context, customer)
              : _buildWebLayout(context, customer), // 2nd row design yahan hai
        ),

        // --- DELETE BUTTON (Top Right) ---
        Positioned(
          top: -12,
          right: -12,
          child: GestureDetector(
            onTap: () => controller.selectedCustomer.value = null,
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFE5E7)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: const Center(child: Icon(Icons.delete_outline, color: Color(0xFFFF4D4F), size: 18)),
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
                  customer['name'] ?? "Jack Morrison",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B254B)),
                ),
                const Text("Driver", style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                        Expanded(child: _buildCarSpecIcon(IconString.callIcon, "Contact Number", customer['phone'] ?? "+12 3456 7890")),
                        Expanded(child: _buildCarSpecIcon(IconString.cardIcon, "Card Number", customer['card'] ?? "1243567434")),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _buildCarSpecIcon(IconString.licesnseNo, "License Number", customer['license'] ?? "1245985642")),
                        Expanded(child: _buildCarSpecIcon(IconString.cardIcon, "NID Number", customer['Nid'] ?? "123 456 789")),
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
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(ImageString.customerUser, width: 55, height: 55, fit: BoxFit.cover),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customer['name'] ?? "Carlie Harvy", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Text("Driver", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            AddButtonOfPickup(text: "View", width: 75, height: 35, onTap: () {}),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCarSpecIcon(IconString.callIcon, "Contact", customer['phone'] ?? "+12 3456 7890"),
              const SizedBox(width: 20),
              _buildCarSpecIcon(IconString.licesnseNo, "License", customer['license'] ?? "1245985642"),
              const SizedBox(width: 20),
              _buildCarSpecIcon(IconString.cardIcon, "Card", customer['card'] ?? "1243567434"),
              const SizedBox(width: 20),
              _buildCarSpecIcon(IconString.cardIcon, "NID", customer['Nid'] ?? "123 456 789"),
            ],
          ),
        ),
      ],
    );
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
            backgroundImage: AssetImage(ImageString.userImage),
          ),
          const SizedBox(width: 15),
           SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jack Morrison", style: TTextTheme.pOne(context)),
                Text("Jack@rhyta.com", style: TTextTheme.pFour(context)),
              ],
            ),
          ),
          const SizedBox(width: 20),
           SizedBox(width: 65, child: Text("34 years", style: TTextTheme.pOne(context))),
          const SizedBox(width: 20),
           SizedBox(width: 95, child: Text("789-012-3456", style: TTextTheme.pOne(context))),
          const SizedBox(width: 20),
           SizedBox(
            width: 180,
            child: Text(
              "404 Spruce Road, NJ 07001",
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

        /// 2. Interactive Car Diagram (Scale handling)
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
                              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
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

  Widget _imageBox(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Upload Pickup Car Images (Max 10)",
            style: TTextTheme.titleTwo(context),
          ),
        ),

        GestureDetector(
          onTap: () => controller.pickImage2(),
          child: Obx(() {
            final imagesList = controller.pickupCarImages;

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
                    Text("Upload Image", style: TTextTheme.btnOne(context)),
                    Text("PNG, JPG, SVG ", style: TTextTheme.documnetIsnideSmallText2(context)),
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

// Start Rent Time  
  Widget _buildStartTimeColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Agreement Start Time", style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(controller.startDateController, "DD/MM/YYYY", context),
        const SizedBox(height: 8),
        _editableTimeField(controller.startTimeController, "Time:", context),
      ],
    );
  }

// End Rent Time
  Widget _buildEndTimeColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Agreement End Time", style: TTextTheme.dropdowninsideText(context)),
        const SizedBox(height: 8),
        _editableTimeField(controller.endDateController, "DD/MM/YYYY", context),
        const SizedBox(height: 8),
        _editableTimeField(controller.endTimeController, "Time:", context),
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

