import 'dart:io';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/AddButtonOfPickup.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/AlertDialogs.dart';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/AddPickupButton.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:go_router/go_router.dart';

class PickupDetailWidget extends StatelessWidget {
  PickupDetailWidget({super.key});

  final controller = Get.find<PickupCarController>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 15 : 30),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- 0. PAGE TITLE & TOP ACTIONS ---
            _buildPageHeader(context, isMobile),
            const SizedBox(height: 25),

            /// --- 1. CUSTOMER NAME SECTION ---
            _buildSection(context,
                title: "Customer Name",
                icon: IconString.customerIcon,
                child: _buildDetailedCustomerCard(context, isMobile)),
            const SizedBox(height: 25),

            /// --- 2. CAR DETAILS SECTION ---
            _buildSection(context,
                title: "Car",
                icon: IconString.carInventoryIcon,
                child: _buildDetailedCarCard(context, isMobile)),
            const SizedBox(height: 25),

            /// --- 3. RENT PURPOSE ---
            /// --- 3. RENT PURPOSE ---
            _buildSection(context,
                title: "Rent Purpose",
                icon: IconString.customerIcon,
                child: _toggleStatusTag(context, "Personal Use", controller.isPersonalUse)),

            const SizedBox(height: 25),

            /// --- 4. PAYMENT METHOD ---
            _buildSection(context,
                title: "Payment Method",
                icon: IconString.paymentIcon,
                child: _toggleStatusTag(context, "Manual Payments", controller.isManualPayment)),
            const SizedBox(height: 25),

            /// --- 5. RENT AMOUNT SECTION ---
            _buildSection(context,
                title: "Rent Amount",
                icon: IconString.paymentIcon,
                child: _buildInfoGrid(context, [
                  {"label": "Weekly Rent", "controller": controller.weeklyRentController, "hint": "Enter Weekly Rent"},
                  {"label": "Daily Rent", "controller": controller.rentDueAmountController, "hint": "Enter Due Amount"},
                ], isMobile)),
            const SizedBox(height: 25),
            /// --- 6. BOND PAYMENT SECTION ---
            _buildSection(context,
                title: "Bond Payment",
                icon: IconString.paymentIcon,
                child: _buildInfoGrid(context, [
                  {
                    "label": "Bond Amount",
                    "controller": controller.bondAmountController,
                    "hint": "2600 \$"
                  },
                  {
                    "label": "Paid Bond",
                    "controller": controller.paidBondController,
                    "hint": "600 \$"
                  },
                  {
                    "label": "Due Bond Amount",
                    "controller": controller.dueBondAmountController,
                    "hint": "2000 \$"
                  },
                ], isMobile)),
            const SizedBox(height: 25),

            /// --- 7. CAR REPORT SECTION ---
            _buildSection(context,
                title: "Car Report",
                icon: IconString.carInventoryIcon,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoGrid(context, [
                      {"label": "ODO", "controller": controller.odoController, "hint": "12457678", "hasIcon": false},
                      {"label": "Fuel Level", "controller": controller.fuelLevelController, "hint": "Full (100%)", "hasIcon": true},
                      {"label": " Pickup Interior Cleanliness", "controller": controller.interiorCleanlinessController, "hint": "Excellent", "hasIcon": true},
                      {"label": "Pickup Exterior Cleanliness", "controller": controller.exteriorCleanlinessController, "hint": "Excellent", "hasIcon": true},
                    ], isMobile),
                    const SizedBox(height: 15),
                    _buildCommentField(context, "Additional Comments", controller.additionalCommentsController, "Describe the vehicle's condition..."),
                  ],
                )),
            const SizedBox(height: 25),
            /// --- 8. DAMAGE INSPECTION SECTION ---
            _buildSection(context,
                title: "Damage Inspection",
                icon: IconString.vinNumberIcon,
                child: _buildDamageInspectionCard(context, isMobile)),
            const SizedBox(height: 25),

            /// --- 9. CAR PICTURE UPLOAD ---
            _buildSection(context,
                title: "Car Picture",
                icon: IconString.carValueIcon,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Upload Car Image (Max 10)",
                        style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    _imageBox(context),
                  ],
                )),
            const SizedBox(height: 25),
            _buildSection(context,
                title: "Rent Time",
                icon: IconString.vinNumberIcon,
                showBadge: true,
                child: _buildRentTimeSection(context, isMobile)),
            const SizedBox(height: 25),

            /// --- 11. SIGNATURE SECTION ---
            _buildSection(context,
                title: "Signature",
                icon: IconString.customerIcon,
                child: _buildSignatureSection(context, isMobile)),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  /// --- UI COMPONENTS ---

  Widget _buildInfoGrid(BuildContext context, List<Map<String, dynamic>> items, bool isMobile) {
    // Screen width calculation to divide by 4 for Desktop
    final double availableWidth = MediaQuery.of(context).size.width;

    return Wrap(
      spacing: 20,
      runSpacing: 15,
      children: items.map((item) {
        // Logic: Desktop par 4 columns (approx 22% each), Mobile par full width
        double itemWidth = isMobile
            ? (availableWidth - 60)
            : (availableWidth / 4.5); // Adjusting for padding/spacing

        return SizedBox(
          width: itemWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['label']!,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF7FD),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextFormField(
                  controller: item['controller'],
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                  decoration: InputDecoration(
                    hintText: item['hint'],
                    prefixIcon: item['hasIcon'] == true
                        ? const Icon(Icons.check_circle_outline, size: 16, color: Colors.black87)
                        : null,
                    hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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

  Widget _buildCommentField(BuildContext context, String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: const Color(0xFFEDF7FD), borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(hintText: hint, border: InputBorder.none, hintStyle: const TextStyle(fontSize: 12, color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget _buildDamageInspectionCard(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        // 1. Screen Detection Logic
        bool isWeb = screenWidth > 1024; // Desktop/Web
        bool isTablet = screenWidth >= 450 && screenWidth <= 1024; // Tablet
        bool shouldStack = screenWidth < 450; // Mobile

        return Align(
          alignment: Alignment.centerLeft, // Hamesha left se start hoga
          child: Container(
            // Width logic: Web pe half, baaki jagah full
            width: isWeb ? (screenWidth * 0.5) : double.infinity,

            // Pixels issue na aaye isliye padding aur constraints set kiye hain
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dropoff Location
                _buildDropdownField("Dropoff Location", controller.dropoffLocation),
                const SizedBox(height: 20),

                /// Dropoff Type aur Severity Picker Section
                Flex(
                  direction: shouldStack ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: shouldStack ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    // Dropoff Type: Isay fixed width di hai taake web/tab pe phaylay nahi
                    SizedBox(
                      width: shouldStack ? double.infinity : 200,
                      child: _buildDropdownField("Dropoff Type", controller.dropoffType),
                    ),

                    // Gap adjustment
                    shouldStack ? const SizedBox(height: 15) : const SizedBox(width: 30),

                    // Severity Picker
                    if (!shouldStack)
                      Flexible(child: _buildSeverityPicker()) // Row mein flexible taake line mein rahe
                    else
                      _buildSeverityPicker(), // Mobile pe default behavior
                  ],
                ),

                const SizedBox(height: 20),

                // Dropoff Notes
                _buildCommentField(
                    context,
                    "Dropoff Notes",
                    controller.dropoffNotesController,
                    "Describe the vehicle's condition..."
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSeverityPicker() {
    final options = ["Minor", "Moderate", "Severe", "Critical"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Dropoff Severity",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Obx(() => Wrap(
          spacing: 15, // Options ke darmiyan thora gap
          runSpacing: 10,
          children: options.map((opt) => GestureDetector(
            onTap: () {
              // Click karne par controller ki value update hogi
              controller.dropoffSeverity.value = opt;
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  // Agar selected hai to filled circle warna khali circle
                  controller.dropoffSeverity.value == opt
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  size: 18,
                  color: controller.dropoffSeverity.value == opt
                      ? Colors.black87
                      : Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  opt,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )).toList(),
        )),
      ],
    );
  }

  Widget _buildDropdownField(String label, RxString value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: const Color(0xFFEDF7FD), borderRadius: BorderRadius.circular(6)),
          child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value.value,
              isExpanded: true,
              items: [value.value].map((String val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontSize: 13)))).toList(),
              onChanged: (_) {},
            ),
          )),
        ),
      ],
    );
  }


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
              Text(
                "Pickup Car Details",
                style: TTextTheme.titleOne(context)?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 18 : 24,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                "The specification for the pre rental details",
                style: TTextTheme.smallX(context)?.copyWith(
                  color: Colors.grey[600],
                  fontSize: isMobile ? 10 : 12,
                ),
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
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 38 : 110,
              height: 38,
              textColor: AppColors.secondTextColor,
              borderColor: AppColors.sideBoxesColor,
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
              onTap: () => _showDeleteDialog(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRentTimeSection(BuildContext context, bool isMobile) {
    // --- MOBILE VIEW (One by One layout) ---
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Agreement Start Time Section
          const Text("Agreement Start Time",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          _editableTimeField(controller.startDateController, "02/12/2025"), // Start Date
          const SizedBox(height: 8), // Chota gap field ke darmiyan
          _editableTimeField(controller.startTimeController, "12:12 PM"),   // Start Time

          const SizedBox(height: 24), // Bada gap Start aur End time ke darmiyan

          // 2. Agreement End Time Section
          const Text("Agreement End Time",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          _editableTimeField(controller.endDateController, "02/12/2025"),   // End Date
          const SizedBox(height: 8), // Chota gap field ke darmiyan
          _editableTimeField(controller.endTimeController, "12:12 PM"),     // End Time
        ],
      );
    }

    // --- WEB / TABLET VIEW (Same as before with Arrow) ---
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Agreement Start Time",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.startDateController, "02/12/2025")),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.startTimeController, "12:12 PM")),
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
                  Expanded(child: Container(height: 1.5, color: const Color(0xFFFFD1D1))),
                  const SizedBox(width: 5),
                  const Icon(Icons.access_time, color: Colors.red, size: 22),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      clipBehavior: Clip.none,
                      children: [
                        Container(height: 1.5, color: const Color(0xFFFFD1D1)),
                        const Positioned(
                          right: -5,
                          child: Icon(Icons.chevron_right, color: Color(0xFFFFD1D1), size: 20),
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
              const Text("Agreement End Time",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _editableTimeField(controller.endDateController, "02/12/2025")),
                  const SizedBox(width: 8),
                  Expanded(child: _editableTimeField(controller.endTimeController, "12:12 PM")),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editableTimeField(TextEditingController textController, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF7FD), // Light blue background matching screenshot
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: textController,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }


  Widget _buildSignatureSection(BuildContext context, bool isMobile) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Agar width 600 se kam hai toh boxes stack honge
        bool stackVertical = constraints.maxWidth < 600;

        // Width calculation: (Total Width - Total Gaps) / 2
        // Darmiyan ka gap 40px rakhne ke liye humne calculation adjust ki hai
        double cardWidth = stackVertical
            ? constraints.maxWidth
            : (constraints.maxWidth - 40) / 2;

        return Wrap(
          spacing: 40, // Horizontal gap barhaya gaya hai
          runSpacing: 20, // Vertical gap
          children: [
            SizedBox(
              width: cardWidth,
              child: _signatureCard("Signed by Owner", controller.ownerNameController),
            ),
            SizedBox(
              width: cardWidth,
              child: _signatureCard("Signed by Hirer", controller.hirerNameController),
            ),
          ],
        );
      },
    );
  }

  Widget _signatureCard(String title, TextEditingController nameController) {
    return LayoutBuilder(
      builder: (context, innerConstraints) {
        // 300px se kam par vertical kar dena chahiye taake dividers na milein
        bool forceVertical = innerConstraints.maxWidth < 300;

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // Flex direction change hogi width ke mutabiq
              Flex(
                direction: forceVertical ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  /// 1. Full Name Section
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100), // Max width control
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                              const Divider(thickness: 1, color: Colors.grey),
                            ],
                          ),
                        ),
                        const Text("Full Name", style: TextStyle(fontSize: 9, color: Colors.grey)),
                      ],
                    ),
                  ),

                  if (forceVertical) const SizedBox(height: 15) else const SizedBox(width: 10),

                  /// 2. Signature Section
                  Flexible(
                    flex: forceVertical ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100), // Balance maintain
                          child: Column(
                            crossAxisAlignment: forceVertical ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                            children: [
                              Text(
                                nameController.text.isEmpty ? "Sign" : nameController.text,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Cursive',
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // Text overflow safety
                              ),
                              const Divider(thickness: 1, color: Colors.grey),
                            ],
                          ),
                        ),
                        const Text("Signature", style: TextStyle(fontSize: 9, color: Colors.grey)),
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

  Widget _imageBox(BuildContext context) {
    bool isMobileView = MediaQuery.of(context).size.width < 600 && !kIsWeb;

    return GestureDetector(
      onTap: () => controller.pickImage(),
      child: Obx(() {
        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 180),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.tertiaryTextColor,
              width: 1.5,
            ),
          ),
          child: controller.selectedImages.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(IconString.uploadIcon, width: 24, height: 24),
              ),
              const SizedBox(height: 10),
              const Text("Upload Car Pictures",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const Text("PNG, JPG, SVG ",
                  style: TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          )
              : LayoutBuilder(builder: (context, constraints) {
            // Sirf mobile ke liye width calculate hogi, baki jagah 100 fixed rahegi
            final double itemWidth = isMobileView
                ? (constraints.maxWidth - 12) / 2
                : 100;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...controller.selectedImages.map((imageHolder) {
                  return Container(
                    height: 100,
                    width: itemWidth, // Mobile pe dynamic, Web pe 100
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      image: DecorationImage(
                        image: kIsWeb
                            ? MemoryImage(imageHolder.bytes!)
                            : FileImage(File(imageHolder.path!)) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ],
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

  Widget _buildDetailedCustomerCard(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW: Profile & View Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryColor, // Aapka primary color border
                          width: 0.5, // Border ki thickness
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.5), // Border ke andar fit hone ke liye thora kam radius
                        child: Image.asset(
                          ImageString.customerUser,
                          width: 35,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Carlie Harvy",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Driver",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 70,
                child: AddButtonOfPickup(
                  text: "View",
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          /// BOTTOM SECTION: Scrollable Info
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _infoBlock(Icons.phone_android_outlined, "Contact", "+12 3456 7890"),
                const SizedBox(width: 15),
                _infoBlock(Icons.badge_outlined, "License", "1245985642"),
                const SizedBox(width: 15),
                _infoBlock(Icons.credit_card, "Card", "1243567434"),
                const SizedBox(width: 15),
                _infoBlock(Icons.badge_outlined, "NID", "123 456 789"),
              ],
            ),
          ),
        ],
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildCustomerRowContent(context, false),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCustomerRowContent(BuildContext context, bool isMobile) {
    return [
      /// PROFILE
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(1.5), // Border color ko wazeh dikhane ke liye
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Outer radius thora bada rakha hai
              border: Border.all(
                color: AppColors.primaryColor, // Aapka primary border color
                width: 0.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Image ka radius border ke andar fit karne ke liye
              child: Image.asset(
                ImageString.customerUser,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Carlie Harvy", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text("Driver", style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),

      // Spacing adjustment
      isMobile ? const SizedBox(height: 20) : const SizedBox(width: 30),

      /// INFO BLOCKS
      _infoBlock(Icons.email_outlined, "Email", "Contact@SoftSnip.com.au"),
      isMobile ? const SizedBox(height: 12) : const SizedBox(width: 25),

      _infoBlock(Icons.phone_android_outlined, "Contact Number", "+12 3456 7890"),
      isMobile ? const SizedBox(height: 12) : const SizedBox(width: 25),

      _infoBlock(Icons.location_on_outlined, "Address", "Toronto, California, 1234"),
      isMobile ? const SizedBox(height: 12) : const SizedBox(width: 25),

      _infoBlock(Icons.badge_outlined, "NID Number", "123 456 789"),

      if (isMobile) const SizedBox(height: 20),
      if (!isMobile) const SizedBox(width: 30),

      /// VIEW BUTTON
      AddButtonOfPickup(text: "View", width: 100,onTap: () {}),
    ];
  }


  Widget _buildDetailedCarCard(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: isMobile ? 18 : 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
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
                    Image.asset(ImageString.astonPic, width: 75),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Aston 2025", style: TextStyle(fontSize: 10, color: Colors.grey), overflow: TextOverflow.ellipsis),
                          Text("Martin", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
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
            child: Row(
              children: [
                _infoRowTag(label: "Registration", value: "1234567890"),
                const SizedBox(width: 10),

                _infoRowTag(
                    label: "VIN",
                    value: "JTNBA3HK003001234",
                    labelColor: const Color(0xFF2196F3)
                ),

                const SizedBox(width: 45),
                _buildSpecColumn("Transmission", "Auto", Icons.settings_input_component),

                const SizedBox(width: 45),
                _buildSpecColumn("Capacity", "2 seats", Icons.chair_alt_outlined),

                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Price", style: TextStyle(fontSize: 9, color: Colors.grey)),
                    Row(
                      children: const [
                        Text("\$130", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Text("/Wk", style: TextStyle(fontSize: 9, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
          : LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _buildCarContent(context, false),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildCarContent(BuildContext context, bool isMobile) {
    return [
      ///  CAR IMAGE + TITLE
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(ImageString.astonPic, width: 110),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Range Rover 2024", style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Text("Velar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _infoRowTag(label: "Registration", value: "1234567890"),
              const SizedBox(height: 10),
              _infoRowTag(label: "VIN", value: "JTNBA3HK003001234", labelColor: const Color(0xFF2196F3)),
            ],
          ),
        ],
      ),

      if (isMobile) const SizedBox(height: 20),

      ///  TRANSMISSION & CAPACITY
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSpecColumn("Transmission", "Automatic", Icons.settings_input_component),
          const SizedBox(width: 30),
          _buildSpecColumn("Capacity", "2 seats", Icons.chair_alt_outlined),
        ],
      ),

      if (isMobile) const SizedBox(height: 20),

      ///  PRICE
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Price", style: TextStyle(fontSize: 10, color: Colors.grey)),
          Row(
            children: const [
              Text("\$130", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("/Weekly", style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ],
      ),

      if (isMobile) const SizedBox(height: 20),

      AddButtonOfPickup(text: "View",width: 100 ,onTap: () {}),
    ];
  }


  Widget _buildSpecColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: const Color(0xFFE0F2FE), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 20, color: Colors.blueGrey),
        ),
        const SizedBox(height: 3),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }


  Widget _infoRowTag({
    required String label,
    required String value,
    Color labelColor = const Color(0xFF1E293B),
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// VALUE BOX
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EEF5), // Light Grayish Blue like screenshot
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }



  Widget _infoBlock(IconData icon, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: Colors.black),
        ),
        const SizedBox(width: 8),
        // Flexible zaroori hai narrow row ke liye
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 9, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2), // Background color fixed rakha hai
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFEE2E2)), // Border fixed rakha hai
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sirf dot (icon) change hoga
            Icon(
              stateVariable.value ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 16,
              color: Colors.black87, // Icon color bhi same rahega
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87, // Text color same rahega
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => ResponsiveDeleteDialog(
        onCancel: () => context.pop(),
        onConfirm: () => context.pop(),
      ),
    );
  }
}