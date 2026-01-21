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
              // --- MAIN UI ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStepBadges(),
                    Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Add Pickup Car", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text("Enter the specification for the pre rental details",
                              style: TextStyle(fontSize: 14, color: Colors.blueGrey.shade300)),
                          const SizedBox(height: 20),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- CUSTOMER SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.person_outline_rounded,
                            title: "Customer",
                            subtitle: "Select a customer or add new customer",
                            content: Column(
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
                                  child: AddPickUpButton(text: "Add new customer", width: buttonWidth, onTap: () {
                                    Get.lazyPut(() => CustomerController());

                                    context.push(
                                      '/addNewCustomer',
                                      extra: {"hideMobileAppBar": true},
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- CAR SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.directions_car_outlined,
                            title: "Car",
                            subtitle: "Select a Car",
                            content: AddButtonOfPickup(
                              text: "Select The Car",
                              height: 45,
                              width: buttonWidth,
                              icon: const Icon(Icons.near_me_rounded, size: 16, color: Colors.white),
                              onTap: () {
                                if (controller.isCustomerDropdownOpen.value) {
                                  controller.isCustomerDropdownOpen.value = false;
                                }
                                controller.isCarDropdownOpen.value = !controller.isCarDropdownOpen.value;
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- RENT PURPOSE SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.group_outlined,
                            title: "Rent Purpose",
                            subtitle: "Select any Option",
                            content: Obx(() => Row(
                              children: [
                                _buildRadioButton(
                                  "Personal Use",
                                  controller.selectedRentPurpose.value == "Personal Use",
                                  onTap: () => controller.selectedRentPurpose.value = "Personal Use",
                                ),
                                const SizedBox(width: 20),
                                _buildRadioButton(
                                  "Commercial Use",
                                  controller.selectedRentPurpose.value == "Commercial Use",
                                  onTap: () => controller.selectedRentPurpose.value = "Commercial Use",
                                ),
                              ],
                            )),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- WEEKLY RENT SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.payments_outlined,
                            title: "Weekly Rent",
                            subtitle: "Select any Option",
                            content: Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: [
                                _buildMiniInputField("Weekly Rent", "Write Rent Amount...", buttonWidth / 2.1, controller.weeklyRentController2,context),
                                _buildMiniInputField("Daily Rent", "Write Rent Amount...", buttonWidth / 2.1, controller.dailyRentController2,context),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- BOND PAYMENT SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.account_balance_wallet_outlined,
                            title: "Bond Payment",
                            subtitle: "Select any Option",
                            content: Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: [
                                _buildMiniInputField("Bond Amount", "Write Rent Amount...", buttonWidth / 3.2, controller.bondAmountController2,context),
                                _buildMiniInputField("Paid Bond", "Write Bond Amount...", buttonWidth / 3.2, controller.paidBondController2,context),
                                _buildMiniInputField("Left Bond", "Write Due Bond Amount...", buttonWidth / 3.2, controller.leftBondController2,context),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- PAYMENT METHOD SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.contact_mail_outlined,
                            title: "Payment Method",
                            subtitle: "Select any Option",
                            content: Obx(() => Row(
                              children: [
                                _buildRadioButton(
                                  "Manual Payments",
                                  controller.isManualPayment.value,
                                  onTap: () => controller.isManualPayment.value = true,
                                ),
                                const SizedBox(width: 20),
                                _buildRadioButton(
                                  "Auto Payments",
                                  !controller.isManualPayment.value,
                                  onTap: () => controller.isManualPayment.value = false,
                                ),
                              ],
                            )),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- CAR REPORT SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.assignment_outlined,
                            title: "Car Report",
                            subtitle: "Fill the Report",
                            content: LayoutBuilder(
                              builder: (context, constraints) {
                                double screenWidth = MediaQuery.of(context).size.width;
                                // Agar screen 600px se kam hai to full width (1 column), warna 3 columns
                                double itemWidth = screenWidth < 600
                                    ? constraints.maxWidth
                                    : (constraints.maxWidth - 30) / 3; // 30 is total spacing (15+15)

                                return Wrap(
                                  spacing: 15,
                                  runSpacing: 20,
                                  children: [
                                    _buildMiniInputField("Pickup ODO", "12457578", itemWidth, controller.odoController,context),
                                    _buildReportDropdown(
                                        "Pickup Fuel Level",
                                        ["Empty (0%)", "Quarter", "Half", "Full"],
                                        itemWidth,
                                        controller.fuelLevelController,
                                        context
                                    ),
                                    _buildReportDropdown(
                                        "Pickup Interior Cleanliness",
                                        ["Excellent", "Good", "Fair", "Poor"],
                                        itemWidth,
                                        controller.interiorCleanlinessController,
                                        context
                                    ),
                                    _buildReportDropdown(
                                        "Pickup Exterior Cleanliness",
                                        ["Excellent", "Good", "Fair", "Poor"],
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
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- DAMAGE INSPECTION SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.car_crash_outlined,
                            title: "Damage Inspection",
                            subtitle: "Fill the Report",
                            trailing: _buildToggleWidget(),
                            content: _buildDamageInspectionCard(context, buttonWidth),
                          ),


                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// --- PICKUP NOTE SECTION ---
                          _buildSelectionRow(
                            context,
                            icon: Icons.note_alt_outlined,
                            title: "Pickup Note",
                            subtitle: "Fill the Report",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Pickup Comments", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: controller.additionalCommentsController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: "Describe the vehicle's condition, unique features...",
                                    hintStyle: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                                    filled: true,
                                    fillColor: const Color(0xFFF7FAFC),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// 4. CAR PICTURE SECTION
                          _buildSelectionRow(
                            context,
                            icon: Icons.camera_alt_outlined,
                            title: "Car Picture",
                            subtitle: "Fill the Picture",
                            content: _imageBox(context),
                          ),

                          const SizedBox(height: 30),
                          Divider(thickness: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 30),

                          /// 5. RENT TIME SECTION
                          _buildSelectionRow(
                            context,
                            icon: Icons.access_time_rounded,
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
                double topOffset = isMobile ? 225 : 181;
                return Positioned(
                  top: topOffset,
                  right: 24,
                  child: _buildModernDropdown(context, buttonWidth),
                );
              }),

              ///  CAR DROPDOWN OVERLAY
              Obx(() {
                if (!controller.isCarDropdownOpen.value) return const SizedBox.shrink();
                double topOffset = isMobile ? 420 : 315;

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
    required IconData icon,
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
              // Expanded title ko majboor karega ke wo available space mein fit ho
              Expanded(
                child: Row(
                  children: [
                    Icon(icon, size: 24, color: Colors.black87),
                    const SizedBox(width: 12),
                    // Flexible use kiya hai taaki text overflow na kare
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // 400px width safety
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8), // Thora gap title aur toggle ke beech
              if (trailing != null) trailing,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, bottom: 12),
            child: Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          content,
        ],
      );
    }

    // Web View
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children: [
                    Icon(icon, size: 24, color: Colors.black87),
                    const SizedBox(width: 12),
                    Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis))
                  ]
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 36),
                  child: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade400), overflow: TextOverflow.ellipsis)
              ),
            ],
          ),
        ),
        Expanded(flex: 3, child: content),
      ],
    );
  }

  Widget _buildCarModernDropdown(BuildContext context, double width) {
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: 15,
        shadowColor: const Color(0xFFFFE5E7).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8F9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFFE5E7), width: 1.5),
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
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Car...",
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey.shade400),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              // Dropdown container ke andar jahan Column hai
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 350),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical, // Upar niche scroll
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Yahan Right Overflow fix hoga
                      child: IntrinsicWidth( // Ye content ki poori width allow karega
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
      // Width ko thora kam kiya taaki horizontal scroll area mein fit lage
      width: 740,
      margin: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Tight alignment
        children: [
          // 1. Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(ImageString.astonPic, width: 75, height: 48, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          // 2. Info Section (Title & Subtitle)
          SizedBox(
            width: 105,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aston 2025", style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                Text(
                  "Martin",
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B254B)),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // 3. Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: const Color(0xFF4318FF), borderRadius: BorderRadius.circular(6)),
            child: const Text("Available", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),

          const SizedBox(width: 15), // Main gap between status and chips

          // 4. Registration Chip
          _buildInfoChip("Registration", "1234567890", const Color(0xFF1B254B)),

          const SizedBox(width: 8), // Chota gap chips ke darmiyan

          // 5. VIN Chip
          _buildInfoChip("VIN", "JTNBA3HK134567890", const Color(0xFF4299E1)),

          // Spacer ki jagah fixed gap use kiya taaki content View button ke kareeb rahe
          const SizedBox(width: 25),

          // 6. View Button
          SizedBox(
            width: 75,
            height: 38,
            child: AddButtonOfPickup(
              text: "Select",
              onTap: () => controller.isCarDropdownOpen.value = false,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FE),
        borderRadius: BorderRadius.circular(8), // Thora rounded
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              value,
              style: const TextStyle(fontSize: 10, color: Color(0xFF707EAE), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // --- AAPKA ORIGINAL DROPDOWN (BILKUL UNTOUCHED) ---
  Widget _buildModernDropdown(BuildContext context, double width) {
    return Material(
      elevation: 20,
      shadowColor: Colors.black38,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(12),
      ),
      color: Colors.white,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: Border.all(color: const Color(0xFFFFE5E7), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 38,
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search Customer...",
                    prefixIcon: const Icon(Icons.search, size: 18),
                    filled: true,
                    fillColor: Colors.grey.shade50,
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

  // --- AAPKA ORIGINAL CARD (BILKUL UNTOUCHED) ---
  Widget _buildCustomerCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 16, backgroundColor: Colors.grey),
          const SizedBox(width: 15),
          const SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Jack Morrison", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                Text("Jack@rhyta.com", style: TextStyle(color: Colors.grey, fontSize: 9)),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const SizedBox(width: 65, child: Text("34 years", style: TextStyle(fontSize: 10))),
          const SizedBox(width: 20),
          const SizedBox(width: 95, child: Text("789-012-3456", style: TextStyle(fontSize: 10))),
          const SizedBox(width: 20),
          const SizedBox(
            width: 180,
            child: Text(
              "404 Spruce Road, NJ 07001",
              style: TextStyle(fontSize: 10, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 80,
            height: 35,
            child: AddButtonOfPickup(
              text: "Select",
              onTap: () => controller.isCustomerDropdownOpen.value = false,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepBadge(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF2D55) : const Color(0xFFFFF1F2),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Text(text, style: TextStyle(color: isActive ? Colors.white : const Color(0xFFFFC5CB), fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildStepBadges() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [_buildStepBadge("Step 1", true), const SizedBox(width: 8), _buildStepBadge("Step 2", false)],
      ),
    );
  }

  Widget _buildRadioButton(String text, bool isSelected, {required VoidCallback onTap}) {
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
              style: TextStyle(
                fontSize: 13,
                color: AppColors.blackColor,
              )
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
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
                  const Icon(Icons.keyboard_arrow_down, size: 22, color: Colors.black),
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
        /// 1. Toggle & Legend Row
        Wrap(
          spacing: 15,
          runSpacing: 15,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Toggle Button: Sirf tab dikhega jab screen mobile NAHI hai
            if (!isMobile) _buildToggleWidget(),

            // Legend Box (Exact original style)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueGrey.shade100, width: 1),
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
                      duration: const Duration(milliseconds: 100),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE3F2FD) : Colors.transparent,
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
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              type['label'],
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: Colors.black87,
                              ),
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

  Widget _buildToggleWidget() {
    return Obx(() => GestureDetector(
      onTap: () => controller.isDamageInspectionOpen.value = !controller.isDamageInspectionOpen.value,
      child: Container(
        width: 70,
        height: 32,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: controller.isDamageInspectionOpen.value ? const Color(0xFFFF2D55) : Colors.grey.shade300,
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
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: controller.isDamageInspectionOpen.value ? Colors.white : Colors.black54,
                ),
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
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Upload Pickup Car Images (Max 10)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
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
    // Mobile check
    bool isMobile = AppSizes.isMobile(context);

    return Flex(
      // Mobile par Vertical (one by one), Web/Tab par Horizontal (side by side)
      direction: isMobile ? Axis.vertical : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Agreement Start Time
        // Web par Expanded (purana logic), Mobile par normal Column
        isMobile
            ? _buildStartTimeColumn(context)
            : Expanded(child: _buildStartTimeColumn(context)),

        // Beech ka gap
        isMobile ? const SizedBox(height: 20) : const SizedBox(width: 40),

        // Agreement End Time
        // Web par Expanded (purana logic), Mobile par normal Column
        isMobile
            ? _buildEndTimeColumn(context)
            : Expanded(child: _buildEndTimeColumn(context)),
      ],
    );
  }

// Start Time Column Logic (Aapka original code)
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

// End Time Column Logic (Aapka original code)
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

