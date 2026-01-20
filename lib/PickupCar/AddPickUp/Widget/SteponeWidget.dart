import 'dart:io';

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


class StepOneSelectionWidget extends StatelessWidget {
  final PickupCarController controller = Get.find();

  StepOneSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => controller.isCustomerDropdownOpen.value = false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double totalWidth = constraints.maxWidth;
          bool isMobile = AppSizes.isMobile(context);
          double padding = 24.0; // Purana padding

          // Button width calculation
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
                                  onTap: () => controller.isCustomerDropdownOpen.value = !controller.isCustomerDropdownOpen.value,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 32,
                                  child: AddPickUpButton(text: "Add new customer", width: buttonWidth, onTap: () {}),
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
                              onTap: (){},
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
                            content: Row(
                              children: [
                                _buildRadioButton("Personal Use", true), // Iska logic controller se link kar sakte hain
                                const SizedBox(width: 20),
                                _buildRadioButton("Commercial Use", false),
                              ],
                            ),
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
                                _buildMiniInputField("Weekly Rent", "Write Rent Amount...", buttonWidth / 2.1, controller.weeklyRentController2),
                                _buildMiniInputField("Daily Rent", "Write Rent Amount...", buttonWidth / 2.1, controller.dailyRentController2),
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
                                _buildMiniInputField("Bond Amount", "Write Rent Amount...", buttonWidth / 3.2, controller.bondAmountController2),
                                _buildMiniInputField("Paid Bond", "Write Bond Amount...", buttonWidth / 3.2, controller.paidBondController2),
                                _buildMiniInputField("Left Bond", "Write Due Bond Amount...", buttonWidth / 3.2, controller.leftBondController2),
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
                            content: Row(
                              children: [
                                Obx(() => GestureDetector(
                                  onTap: () => controller.isManualPayment.value = true,
                                  child: _buildRadioButton("Manual Payments", controller.isManualPayment.value),
                                )),
                                const SizedBox(width: 20),
                                Obx(() => GestureDetector(
                                  onTap: () => controller.isManualPayment.value = false,
                                  child: _buildRadioButton("Auto Payments", !controller.isManualPayment.value),
                                )),
                              ],
                            ),
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
                            content: Wrap(
                              spacing: 15,
                              runSpacing: 20,
                              children: [
                                _buildMiniInputField("Pickup ODO", "12457578", buttonWidth / 3.2, controller.odoController),
                                _buildReportDropdown("Pickup Fuel Level", ["Empty (0%)", "Quarter", "Half", "Full"], buttonWidth / 3.2, controller.fuelLevelController),
                                _buildReportDropdown("Pickup Interior Cleanliness", ["Excellent", "Good", "Fair", "Poor"], buttonWidth / 3.2, controller.interiorCleanlinessController),
                                _buildReportDropdown("Pickup Exterior Cleanliness", ["Excellent", "Good", "Fair", "Poor"], buttonWidth / 3.2, controller.exteriorCleanlinessController),
                              ],
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
                            content: _buildDamageInspectionCard(context, buttonWidth), // Function call
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
                            content: _buildRentTimeSection(context), // Humne jo naya time field banaya
                          ),

                          const SizedBox(height: 50),


                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// --- DROPDOWN OVERLAY (Aapka Original Logic) ---
              Obx(() {
                if (!controller.isCustomerDropdownOpen.value) return const SizedBox.shrink();

                // Mobile par dropdown thora niche shift hoga kyunki layout Column ho gaya hai
                double topOffset = isMobile ? 225 : 181;

                return Positioned(
                  top: topOffset,
                  right: 24,
                  child: _buildModernDropdown(context, buttonWidth),
                );
              }),
            ],
          );
        },
      ),
    );
  }


  /// --------- Extra Widget ----------///
  // Layout switcher: Mobile par one-by-one, Web par Row
  Widget _buildSelectionRow(BuildContext context, {required IconData icon, required String title, required String subtitle, required Widget content}) {
    bool isMobile = AppSizes.isMobile(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 24, color: Colors.black87),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 36, bottom: 12),
            child: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
          ),
          content,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Icon(icon, size: 24, color: Colors.black87), const SizedBox(width: 12), Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))]),
              Padding(padding: const EdgeInsets.only(left: 36), child: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade400))),
            ],
          ),
        ),
        Expanded(flex: 3, child: content),
      ],
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
            width: 70,
            height: 35,
            child: AddButtonOfPickup(
              text: "View",
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

  Widget _buildRadioButton(String text, bool isSelected) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? AppColors.blackColor : AppColors.blackColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildMiniInputField(String label, String hint, double width, TextEditingController txtController) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextField(
              controller: txtController, // Har field ka apna controller
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                filled: true,
                fillColor: const Color(0xFFF7FAFC),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportDropdown(String label, List<String> items, double width, TextEditingController txtController) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: DropdownButtonFormField<String>(
              value: items.contains(txtController.text) ? txtController.text : items.first,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF7FAFC),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
              style: const TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w500),
              icon: const Icon(Icons.keyboard_arrow_down, size: 18),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                txtController.text = newValue!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDamageInspectionCard(BuildContext context, double buttonWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 1. YES/NO Toggle & Legend Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Toggle Button
            Obx(() => GestureDetector(
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
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
            )),
            const SizedBox(width: 20),

            // Legend Box with Background Selection
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey.shade100, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE3F2FD) : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: type['color'],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  type['id'].toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              type['label'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        /// 2. Interactive Car Diagram with Add/Remove Logic
        Obx(() {
          double width = buttonWidth;
          double height = width * 0.7;

          return IgnorePointer(
            ignoring: !controller.isDamageInspectionOpen.value,
            child: Opacity(
              opacity: controller.isDamageInspectionOpen.value ? 1.0 : 0.4,
              child: Center(
                child: GestureDetector(
                  onTapDown: (details) {
                    double dx = details.localPosition.dx / width;
                    double dy = details.localPosition.dy / height;

                    // Check if a point already exists at this location (Remove if exists)
                    int existingIndex = controller.damagePoints2.indexWhere((p) =>
                    (p.dx - dx).abs() < 0.04 && (p.dy - dy).abs() < 0.04
                    );

                    if (existingIndex != -1) {
                      controller.damagePoints2.removeAt(existingIndex);
                    } else {
                      // Add new point
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
                          left: (point.dx * width) - 12,
                          top: (point.dy * height) - 12,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: point.color,
                            child: Text(
                              point.typeId.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
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
    return Row(
      children: [
        // Agreement Start Time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Agreement Start Time", style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              _editableTimeField(controller.startDateController, "DD/MM/YYYY", context),
              const SizedBox(height: 8),
              _editableTimeField(controller.startTimeController, "Time:", context),
            ],
          ),
        ),
        const SizedBox(width: 40), // Gap between start and end
        // Agreement End Time
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Agreement End Time", style: TTextTheme.dropdowninsideText(context)),
              const SizedBox(height: 8),
              _editableTimeField(controller.endDateController, "DD/MM/YYYY", context),
              const SizedBox(height: 8),
              _editableTimeField(controller.endTimeController, "Time:", context),
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
}

