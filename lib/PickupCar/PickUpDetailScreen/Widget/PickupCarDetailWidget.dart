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
                      {"label": "Interior Cleanliness", "controller": controller.interiorCleanlinessController, "hint": "Excellent", "hasIcon": true},
                      {"label": "Exterior Cleanliness", "controller": controller.exteriorCleanlinessController, "hint": "Excellent", "hasIcon": true},
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
                title: "Rent Time", // Is title ke sath badge automatically ayega agar hum niche wala function update karein
                icon: IconString.vinNumberIcon,
                showBadge: true, // Naya parameter badge dikhane ke liye
                child: _buildRentTimeSection(context, isMobile)),
            const SizedBox(height: 25),

            /// --- 11. SIGNATURE SECTION ---
            _buildSection(context,
                title: "Signature",
                icon: IconString.customerIcon, // Use a signature/check icon
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownField("Dropoff Location", controller.dropoffLocation),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildDropdownField("Dropoff Type", controller.dropoffType)),
              const SizedBox(width: 20),
              Expanded(child: _buildSeverityPicker()),
            ],
          ),
          const SizedBox(height: 15),
          _buildCommentField(context, "Dropoff Notes", controller.dropoffNotesController, "Describe the vehicle's condition..."),
        ],
      ),
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
      crossAxisAlignment: CrossAxisAlignment.start, // Align top for better look on small screens
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
                  fontSize: isMobile ? 18 : 24, // Thora font size kam kiya mobile ke liye
                ),
                overflow: TextOverflow.ellipsis, // Dots (...) if width < 200px
                maxLines: 1,
              ),
              Text(
                "The specification for the pre rental details",
                style: TTextTheme.smallX(context)?.copyWith(
                  color: Colors.grey[600],
                  fontSize: isMobile ? 10 : 12,
                ),
                overflow: TextOverflow.ellipsis, // Safety for sub-text
                maxLines: 1,
              ),
            ],
          ),
        ),

        const SizedBox(width: 8), // Gap between text and buttons

        /// BUTTONS SECTION
        Row(
          mainAxisSize: MainAxisSize.min, // Buttons sirf utni hi jagah lein jitni zaroori hai
          children: [
            AddPickUpButton(
              text: isMobile ? "" : "Edit",
              iconPath: IconString.editIcon,
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 38 : 110, // Width adjust for 200px screen
              height: 38,
              textColor: AppColors.secondTextColor,
              borderColor: AppColors.sideBoxesColor,
            ),
            const SizedBox(width: 6), // Tight spacing for mobile
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ek left aur ek right ke liye
      children: [
        // 1. Left Box
        Expanded(
          child: _signatureCard("Signed by Owner", controller.ownerNameController),
        ),

        // Darmiyan ka gap (isMobile ke hisab se adjust hoga)
        SizedBox(width: isMobile ? 20 : 60),

        // 2. Right Box
        Expanded(
          child: _signatureCard("Signed by Hirer", controller.hirerNameController),
        ),
      ],
    );
  }

  Widget _signatureCard(String title, TextEditingController nameController) {
    return Container(
      // Padding aur height image_00bf0b.png ke mutabiq
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Full Name Input Section
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    const Text("Full Name", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              // Signature Section (Script Text)
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      nameController.text,
                      style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Cursive', // Script look ke liye
                          color: Colors.black87
                      ),
                    ),
                    const Divider(thickness: 1, color: Colors.grey),
                    const Text("Signature", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
    bool showBadge = false, // Default false rakha hai
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE).withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(icon, width: 20, height: 20),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),

              // --- YAHAN BADGE LAGAYA HAI (Heading ke sath) ---
              if (showBadge) ...[
                const SizedBox(width: 10),
                _statusBadge("Completed"),
              ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
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
              Expanded( // Yeh text ko wrap karega taake button ke liye jagah bache
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        ImageString.customerUser,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded( // Name aur Driver text ke liye
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Carlie Harvy",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Driver",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              AddButtonOfPickup(
                text: "View",
                width: 60, // Width thori kam ki hai 200px ke liye
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 15),

          /// BOTTOM SECTION: Scrollable Info
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(ImageString.customerUser, width: 50, height: 50, fit: BoxFit.cover),
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
      AddButtonOfPickup(text: "View", onTap: () {}),
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
          const SizedBox(width: 95),
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

      AddButtonOfPickup(text: "View", onTap: () {}),
    ];
  }

  Widget _statusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), // Dark Navy Blue color from the screenshot
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w400
        ),
      ),
    );
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