import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:car_rental_project/Car%20Inventory/Car%20Directory/ReusableWidget/AlertDialogs.dart';
import 'package:car_rental_project/PickupCar/PickupCarInventory.dart';
import 'package:car_rental_project/PickupCar/Reusable%20Widget/AddPickupButton.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:dotted_border/dotted_border.dart';
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
                  {"label": "Bond Amount", "controller": controller.rentBondAmountController, "hint": "Enter Bond Amount"},
                  {"label": "Due Amount", "controller": controller.rentDueAmountController, "hint": "Enter Due Amount"},
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

  // Custom Grid for Rent/Bond Details (Matches image_ff62c2.png)
  // Extended Info Grid with Selection Icons (Matches Car Report Screenshot)
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

  // Large Comment/Notes Field
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

  // Damage Inspection Card (Matches ffc7e2.png)
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

  Widget _imageBox(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickImage(),
      child: Obx(() {
        return DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          dashPattern: const [8, 6],
          color: Colors.grey.shade400,
          strokeWidth: 1,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 180),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
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
                : Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...controller.selectedImages.asMap().entries.map((entry) {
                  int index = entry.key;
                  final imageHolder = entry.value;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.shade100, width: 1),
                          image: DecorationImage(
                            image: kIsWeb
                                ? MemoryImage(imageHolder.bytes!)
                                : FileImage(File(imageHolder.path!)) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: GestureDetector(
                          onTap: () {
                            controller.removeImage(index);
                          },
                          child: const CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close, size: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPageHeader(BuildContext context, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pickup Car Details",
                style: TTextTheme.titleOne(context)?.copyWith(fontWeight: FontWeight.bold, fontSize: isMobile ? 20 : 24)),
            Text("The specification for the pre rental details",
                style: TTextTheme.smallX(context)?.copyWith(color: Colors.grey[600])),
          ],
        ),
        Row(
          children: [
            AddPickUpButton(
              text: isMobile ? "" : "Edit",
              iconPath: IconString.editIcon,
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 40 : 110,
              height: 38,
              textColor: AppColors.secondTextColor,
              borderColor: AppColors.sideBoxesColor,
            ),
            const SizedBox(width: 8),
            AddPickUpButton(
              text: isMobile ? "" : "Delete",
              iconPath: IconString.deleteIcon,
              iconColor: AppColors.secondTextColor,
              width: isMobile ? 40 : 110,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Agreement Start Time (Flexible taake overlap na ho)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Agreement Start Time",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                ],
              ),
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
          width: isMobile ? 60 : 180,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 20), // Label ke sath align karne ke liye
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left Pink Line
                  Expanded(child: Container(height: 2, color: const Color(0xFFFFD1D1))),
                  const SizedBox(width: 5),
                  // Clock Icon
                  const Icon(Icons.access_time, color: Colors.red, size: 24),
                  const SizedBox(width: 5),
                  // Right Pink Line with Arrow
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        Container(height: 2, color: const Color(0xFFFFD1D1)),
                        const Icon(Icons.arrow_forward_ios, color: Color(0xFFFFD1D1), size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 3. Agreement End Time
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFEE2E2)),
      ),
      child: isMobile
          ? Column(children: _buildCustomerContent(context, true))
          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: _buildCustomerContent(context, false)),
    );
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

  List<Widget> _buildCustomerContent(BuildContext context, bool isMobile) {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(ImageString.customerUser, width: 50, height: 50, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Carlie Harvy", style: TTextTheme.titleThree(context)?.copyWith(fontWeight: FontWeight.bold)),
              Text("Driver", style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ],
      ),
      if (isMobile) const SizedBox(height: 15),
      _infoBlock(context, Icons.email_outlined, "Email", "Contact@SoftSnip.com.au"),
      _infoBlock(context, Icons.phone_android_outlined, "Contact Number", "+12 3456 7890"),
      _infoBlock(context, Icons.location_on_outlined, "Address", "Toronto, California, 1234"),
      _redActionBtn("View", () {}),
    ];
  }

  Widget _buildDetailedCarCard(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFEE2E2)),
      ),
      child: isMobile
          ? Column(children: _buildCarContent(context, true))
          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: _buildCarContent(context, false)),
    );
  }

  List<Widget> _buildCarContent(BuildContext context, bool isMobile) {
    return [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(ImageString.astonPic, width: 120),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Range Rover 2024", style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text("Velar", style: TTextTheme.titleThree(context)?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(children: [
                _miniTag("Registration", "1234567890", Colors.blueGrey),
                const SizedBox(width: 5),
                _miniTag("VIN", "JTNBA3HK003001234", Colors.blue),
              ]),
            ],
          ),
        ],
      ),
      if (isMobile) const SizedBox(height: 15),
      _carSpecIcon(context, Icons.settings_input_component_outlined, "Transmission", "Automatic"),
      _carSpecIcon(context, Icons.person_outline, "Capacity", "2 seats"),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Price", style: TextStyle(fontSize: 10, color: Colors.grey)),
          Text("\$130/Weekly", style: TTextTheme.titleThree(context)?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
      _redActionBtn("View", () {}),
    ];
  }

  Widget _infoBlock(BuildContext context, IconData icon, String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, size: 16, color: Colors.black87),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _carSpecIcon(BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _miniTag(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text("$label: $value", style: TextStyle(fontSize: 8, color: color, fontWeight: FontWeight.bold)),
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

  Widget _redActionBtn(String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF3B3B),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
    );
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