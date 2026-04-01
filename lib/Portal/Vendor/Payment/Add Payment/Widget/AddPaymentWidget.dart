import 'dart:io';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentWidget extends StatelessWidget {
  AddPaymentWidget({super.key});


  final controller = Get.put(PaymentController());

  final LayerLink _dueLink = LayerLink();
  final LayerLink _fromLink = LayerLink();
  final LayerLink _toLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizes.isMobile(context);
    final bool showSideBySide = AppSizes.isWeb(context);

    return Column(
      children: [
        _buildCard(
          title: "Payment Information",
          subtitle: "All details about the payment",
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildField(context, "Invoice Id", "Enter Invoice Number", controller.invoiceIdController, "invoice"),
                _buildField(context, "Customer Name", "Enter Full Name", controller.customerNameController, "customer"),
                _buildField(context, "Phone Number", "Enter Phone Number", controller.phoneNumberController, "phone"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildField(context, "Payment Amount", "Enter Amount", controller.paymentAmountController, "amount"),
                _buildDateField(context, "Due Date", "Select Date", controller.dueDateController, _dueLink),
                if (!isMobile) const Expanded(child: SizedBox()),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 24),

        showSideBySide
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCarDetail(context, isMobile)),
            const SizedBox(width: 24),
            Expanded(child: _buildRentalPeriod(context, isMobile)),
          ],
        )
            : Column(
          children: [
            _buildCarDetail(context, isMobile),
            const SizedBox(height: 24),
            _buildRentalPeriod(context, isMobile),
          ],
        ),

        const SizedBox(height: 24),
        _buildCard(
          title: "Upload Screenshot",
          subtitle: "Upload screenshot here",
          child: Obx(() {
            return controller.selectedImage2.value != null
                ? _buildSelectedImagePreview(context)
                : _buildUploadBox(context);
          }),
        ),
        const SizedBox(height: 32),

        Align(
          alignment: Alignment.centerRight,
          child: PrimaryBtnOfPayment(
            text: "Mark as Complete",
            onTap: () {
              print("Payment marked as complete");
            },
            borderRadius: BorderRadius.circular(8),
            width:  180,
          ),
        ),

        const SizedBox(height: 32),

        _buildOtherPaymentsTable(context),
        const SizedBox(height: 22),
      ],
    );
  }


 /// ---------- Extra Widget --------- ///

     // Field
  Widget _buildField(BuildContext context, String label, String hint, TextEditingController ctr, String id) {
    final Map<String, FocusNode> focusNodes = {};
    focusNodes[id] ??= FocusNode();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A1D1F))),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: focusNodes[id]!,
          builder: (context, child) {
            bool hasFocus = focusNodes[id]!.hasFocus;
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: hasFocus ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ] : [],
              ),
              child: TextField(
                controller: ctr,
                focusNode: focusNodes[id],
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Color(0xFF9A9FA5), fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

//  Date Field
  Widget _buildDateField(BuildContext context, String label, String hint, TextEditingController ctr, LayerLink link) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A1D1F))),
        const SizedBox(height: 8),
        CompositedTransformTarget(
          link: link,
          child: TextField(
            controller: ctr,
            readOnly: true,
            onTap: () => controller.toggleCalendar(context, link, ctr, 280),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF9A9FA5), fontSize: 13),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(IconString.calendarIcon, width: 18, color: const Color(0xFF9A9FA5)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Colors.white,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //  Car Detail Section
  Widget _buildCarDetail(BuildContext context, bool isMobile) {
    return _buildCard(
      title: "Car Detail",
      subtitle: "Your Car detail listed here",
      child: Column(
        children: [
          _buildResponsiveRow(isMobile, [
            _buildField(context, "Car Name", "Enter Car Name", controller.carNameController, "carName"),
            _buildCustomDropdown(context, "Type", ["Sedan", "SUV", "Hatchback"], controller.selectedCarType, id: "carType"),
          ]),
          const SizedBox(height: 15),
          _buildResponsiveRow(isMobile, [
            _buildField(context, "Registration", "Enter Registration No.", controller.registrationController, "registration"),
            _buildCustomDropdown(context, "Transmission", ["Manual", "Automatic"], controller.selectedTransmission, id: "transmission"),
          ]),
        ],
      ),
    );
  }

  //  Rental Period Section
  Widget _buildRentalPeriod(BuildContext context, bool isMobile) {
    return _buildCard(
      title: "Rental Period",
      subtitle: "Your rental period detail listed here",
      child: Column(
        children: [
          _buildResponsiveRow(isMobile, [
            _buildDateField(context, "From Date", "Select Date", controller.fromDateController, _fromLink),
            _buildDateField(context, "To Date", "Select Date", controller.toDateController, _toLink),
          ]),
          const SizedBox(height: 15),
          _buildField(context, "Duration", "Select Number of days", controller.durationController, "duration"),
        ],
      ),
    );
  }

  //  Reusable Responsive Row
  Widget _buildResponsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 15), child: w)).toList(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: entry.key == children.length - 1 ? 0 : 20),
            child: entry.value,
          ),
        );
      }).toList(),
    );
  }

  //  Dropdown Helper
  Widget _buildCustomDropdown(BuildContext context, String label, List<String> items, RxString selected, {required String id}) {
    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A1D1F))),
          const SizedBox(height: 8),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth),
              offset: const Offset(0, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Color(0xFFEFEFEF))),
              color: Colors.white,
              onOpened: () => controller.openedDropdown2.value = id,
              onCanceled: () => controller.openedDropdown2.value = "",
              onSelected: (val) {
                selected.value = val;
                controller.openedDropdown2.value = "";
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFEFEFEF)),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(selected.value, style: const TextStyle(fontSize: 14, color: Color(0xFF1A1D1F)))),
                    Image.asset(isOpen ? IconString.upsideDropdownIcon : IconString.dropdownIcon, height: 16),
                  ],
                ),
              ),
              itemBuilder: (context) => items.map((val) => PopupMenuItem(value: val, child: Text(val))).toList(),
            );
          }),
        ],
      );
    });
  }

  //  Card Helper
  Widget _buildCard({required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  // Image Fetching
  Widget _buildSelectedImagePreview(BuildContext context) {
    final image = controller.selectedImage2.value;
    if (image == null) return const SizedBox.shrink();
    final bool isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfPickupsWidget,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 350,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: (kIsWeb || image.bytes != null)
                            ? Image.memory(image.bytes!, fit: BoxFit.contain)
                            : Image.file(File(image.path!), fit: BoxFit.contain),
                      ),
                    ),
                    Positioned.fill(
                      child: MouseRegion(
                        onEnter: (_) => controller.setHover2(true),
                        onExit: (_) => controller.setHover2(false),
                        child: InkWell(
                          onTap: () => _showImagePopup(context),
                          child: Obx(() => AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: controller.isImageHovered2.value ? 1.0 : 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.zoom_in,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.backgroundOfScreenColor),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: isSmallScreen
                    ? Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(IconString.receiptIcon, height: 20),
                        const SizedBox(width: 8),
                        Expanded(child: Text(image.name ?? "Receipt.png", style: TTextTheme.bodyRegular12black(context), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => controller.clearSelection2(),
                        child: Text("cancel", style: TTextTheme.bodyRegular12Primary(context)),
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(IconString.receiptIcon),
                        const SizedBox(width: 8),
                        Text(image.name ?? "Receipt.png", style: TTextTheme.bodyRegular12black(context)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => controller.clearSelection2(),
                      child: Text("cancel", style: TTextTheme.bodyRegular12Primary(context)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _showImagePopup(BuildContext context) {
    final image = controller.selectedImage2.value;
    if (image == null) return;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// Close Button
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.sideBoxesColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: kIsWeb
                        ? Image.memory(
                      image.bytes!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    )
                        : Image.file(
                      File(image.path!),
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildUploadBox(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.pickPaymentReceipt2(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfPickupsWidget,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Image.asset(IconString.invoicesIcon, color:AppColors.primaryColor,),
            const SizedBox(height: 12),
            Text(
                "Upload Payment Receipt",
                style: TTextTheme.h1Style(context)
            ),

            const SizedBox(height: 4),
            RichText(
              text:  TextSpan(
                style: TTextTheme.bodyRegular16secondary(context),
                children: [
                  TextSpan(text: "JPEG,PNG "),
                  TextSpan(text: "(Must be under 10 MB)", style: TTextTheme.bodyRegular16Primary(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tables
  Widget _buildOtherPaymentsTable(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                const TextSpan(text: "Other Payments by "),
                TextSpan(text: "(Adam Jhones)", style: TextStyle(color: AppColors.primaryColor)),
              ],
            ),
          ),
          const Text("List of all payments", style: TextStyle(color: Color(0xFF9A9FA5), fontSize: 13)),
          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1190,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      _cell(width: 180, child: _headerCell("Invoice Id", controller,context)),
                      _cell(width: 160, child: _headerCell("Customer Name", controller,context)),
                      _cell(width: 230, child: _headerCell("Duration", controller,context)),
                      _cell(width: 190, child: _headerCell("Car Name", controller,context)),
                      _cell(width: 110, child: _headerCell("Amount", controller,context)),
                      _cell(width: 130, child: _headerCell("Status", controller,context, isCenter: true, canSort: false)),
                      _cell(width: 130, child: _headerCell("Action", controller,context, isCenter: true, canSort: false)),
                    ],
                  ),
                ),

                // Data Rows
                Obx(() => Column(
                  children: controller.otherPaymentsList.map((data) {
                    return SizedBox(
                        width: 1190,
                        child: _buildSimplePaymentRow(data, context)
                    );
                  }).toList(),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(
      String title,
      PaymentController controller,
      BuildContext context, {
        bool isCenter = false,
        bool canSort = true,
      }) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort2(title) : null,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TTextTheme.medium14tableHeading(context),
            ),
          ),

          if (canSort) ...[
            const SizedBox(width: 4),
            Obx(() {
              bool isCurrent = controller.sortColumn2.value == title;
              int order = isCurrent ? controller.sortOrder2.value : 0;

              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 14,
                      color: order == 1 ? AppColors.primaryColor : const Color(0xFF94A3B8),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -9),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: order == 2 ? AppColors.primaryColor : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
  Widget _buildSimplePaymentRow(Map data, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEFEFEF)),
      ),
      child: Row(
        children: [
          _cell(width: 180, child: Text(data["id"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 160, child: Text(data["customerName"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 230, child: Text(data["duration"] ?? "", style: TTextTheme.tableRegular14black(context))),
          _cell(width: 190, child: Text(data["car"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 110, child: Text("\$${data["amount"]}",
              style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 16))),
          _cell(width: 130, child: Center(
            child: Container(
              constraints: const BoxConstraints(minWidth: 90),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8CB10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Pending", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          )),
          _cell(width: 130, child: Center(
            child: SizedBox(
              height: 32,
              width: 100,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(color: AppColors.primaryColor),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.visibility_outlined, size: 14),
                    const SizedBox(width: 4),
                    const Text("View", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }
}
