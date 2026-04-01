import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Resources/Colors.dart' show AppColors;


class InvoicesDetailWidget extends StatelessWidget {
  final Map data;
  InvoicesDetailWidget({super.key, required this.data});

  final controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildPaymentInfoCard(context),

          const SizedBox(height: 20),

          isWeb
              ? Row(
            children: [
              Expanded(child: _buildCarDetailCard(context)),
              const SizedBox(width: 20),
              Expanded(child: _buildRentalCard(context)),
            ],
          )
              : Column(
            children: [
              _buildCarDetailCard(context),
              const SizedBox(height: 20),
              _buildRentalCard(context),
            ],
          ),

          const SizedBox(height: 20),

          _buildOtherPaymentsTable(context),
        ],
      ),
    );
  }

  /// ----------- Extra Widgets --------- ///

  // payment info
  Widget _buildPaymentInfoCard(BuildContext context) {
    String status = data["status"] ?? "Pending";
    bool isMobile = MediaQuery.of(context).size.width < 400;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment Information", style: TTextTheme.h2Style(context)),
                Text("All details about the payment", style: TTextTheme.bodyRegular16(context)),
                const SizedBox(height: 12),
                _buildStatusChip(status, context),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Payment Information", style: TTextTheme.h2Style(context)),
                      Text("All details about the payment", style: TTextTheme.bodyRegular16(context)),
                    ],
                  ),
                ),
                _buildStatusChip(status, context),
              ],
            ),

          const SizedBox(height: 24),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, "Invoice Id", data["id"] ?? "In-2026-004"),
            _buildReadOnlyField(context, "Customer Name", data["customerName"] ?? "Adam Jhon"),
            _buildReadOnlyField(context, "Phone Number", "12345667"),
          ]),

          const SizedBox(height: 16),

          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, "Payment Amount", "\$${data["amount"] ?? "1425"}", isPrice: true),
            _buildReadOnlyField(context, "Due Date", "12 March, 2026"),
            const SizedBox(),
          ]),
        ],
      ),
    );
  }

  // Car Detail
  Widget _buildCarDetailCard(BuildContext context) {
    return _buildCard(
      context,
      title: "Car Detail",
      subtitle: "Your Car detail listed here",
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, "Car Name",
                data["car"] ?? "Mazda CX-5 (2017)"),
            _buildReadOnlyField(context, "Type", "Sedan"),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, "Registration", "Abc12345"),
            _buildReadOnlyField(context, "Transmission", "Automatic"),
          ]),
        ],
      ),
    );
  }

  // car Rental
  Widget _buildRentalCard(BuildContext context) {
    return _buildCard(
      context,
      title: "Rental Period",
      subtitle: "Your rental period detail listed here",
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, "From Date", "March 7, 2026"),
            _buildReadOnlyField(context, "To Date", "March 14, 2026"),
          ]),
          const SizedBox(height: 16),
          _buildReadOnlyField(context, "Duration", "7 days"),
        ],
      ),
    );
  }

  // Basic card
  Widget _buildCard(BuildContext context,
      {required String title,
        required String subtitle,
        required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.h2Style(context)),
          Text(subtitle, style: TTextTheme.bodyRegular16(context)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  // Fields
  Widget _buildReadOnlyField(
      BuildContext context, String label, String value,
      {bool isPrice = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.bodyRegular12(context)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.toolBackground),
          ),
          child: Text(
            value,
            style: isPrice
                ? const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
            )
                : TTextTheme.bodySemiBold14black(context),
          ),
        ),
      ],
    );
  }

  // Rows Responsive
  Widget _buildResponsiveRow(
      BuildContext context, List<Widget> children) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    if (isMobile) {
      return Column(
        children: children
            .map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: e,
        ))
            .toList(),
      );
    }

    return Row(
      children: children
          .map((e) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: e,
        ),
      ))
          .toList(),
    );
  }

  // Status Chips
  Widget _buildStatusChip(String status, BuildContext context) {
    Color backgroundColor;
    String displayStatus = status;

    switch (status.toLowerCase()) {
      case 'overdue':
        backgroundColor = AppColors.overdueColor;
        break;
      case 'pending':
        backgroundColor = AppColors.pendingColor;
        break;
      case 'completed':
        backgroundColor = AppColors.completedColor;
        break;
      case 'resubmit':
        backgroundColor = AppColors.reviewColor;
        break;
      case 'submitted':
        backgroundColor = AppColors.textColor;
        displayStatus = "Submitted";
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      constraints: const BoxConstraints(minWidth: 85),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        displayStatus,
        textAlign: TextAlign.center,
        style: TTextTheme.bodySemiBold14White(context),
      ),
    );
  }

  // Table
  Widget _buildOtherPaymentsTable(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TTextTheme.h2Style(context),
              children: [
                const TextSpan(text: "Other Payments by "),
                TextSpan(
                  text: "(Adam Jhones)",
                  style: TTextTheme.h2PrimaryStyle(context),
                ),
              ],
            ),
          ),

          Text("List of all payments",
              style: TTextTheme.bodyRegular16(context)),

          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1200,
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      _cell(
                          width: 180,
                          child: _headerCell("Invoice Id", context)),
                      _cell(
                          width: 160,
                          child: _headerCell("Customer Name", context)),
                      _cell(
                          width: 230,
                          child: _headerCell("Duration", context)),
                      _cell(
                          width: 190,
                          child: _headerCell("Car Name", context)),
                      _cell(
                          width: 110,
                          child: _headerCell("Amount", context)),
                      _cell(
                          width: 130,
                          child: _headerCell("Status", context,
                              isCenter: true, canSort: false)),
                      _cell(
                          width: 130,
                          child: _headerCell("Action", context,
                              isCenter: true, canSort: false)),
                    ],
                  ),
                ),
                Obx(() => Column(
                  children: controller.otherPaymentsListinvoices.map((row) {
                    return SizedBox(
                      width: 1200,
                      child: _buildSimplePaymentRow(row, context),
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
      BuildContext context, {
        bool isCenter = false,
        bool canSort = true,
      }) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort3(title) : null,
      child: Row(
        mainAxisAlignment:
        isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.medium14tableHeading(context)),

          if (canSort) ...[
            const SizedBox(width: 4),
            Obx(() {
              bool isCurrent = controller.sortColumn3.value == title;
              int order = isCurrent ? controller.sortOrder3.value : 0;

              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 14,
                      color: order == 1 ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -9),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: order == 2 ? AppColors.primaryColor : AppColors.quadrantalTextColor,
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
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.sideBoxesColor.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          _cell(
              width: 180,
              child: Text(data["id"] ?? "",
                  style: TTextTheme.bodySemiBold14black(context),
                  overflow: TextOverflow.ellipsis)),

          _cell(
              width: 160,
              child: Text(data["customerName"] ?? "",
                  style: TTextTheme.bodySemiBold14black(context),
                  overflow: TextOverflow.ellipsis)),

          _cell(
              width: 230,
              child: Text(data["duration"] ?? "",
                  style: TTextTheme.tableRegular14black(context))),

          _cell(
              width: 190,
              child: Text(data["car"] ?? "",
                  style: TTextTheme.tableRegular14black(context),
                  overflow: TextOverflow.ellipsis)),

          _cell(
              width: 110,
              child: Text("\$${data["amount"]}",
                  style: TTextTheme.hPickupStyle(context))),

          // 🔥 DYNAMIC STATUS
          _cell(
            width: 130,
            child: Center(
              child: _buildStatusChip(
                  data["status"] ?? "Pending", context),
            ),
          ),

          // 🔹 ACTION BUTTON
          _cell(
            width: 130,
            child: Center(
              child: SizedBox(
                height: 32,
                width: 100,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.visibility_outlined, size: 14),
                      const SizedBox(width: 4),
                      Text("View",
                          style:
                          TTextTheme.tableRegular14Primary(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }
}
