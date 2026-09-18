import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PaginationBarOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart' show AppColors;
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectedPaymentHistoryDetailView extends StatelessWidget {
  const SelectedPaymentHistoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.find<PaymentController>();

    return Container(
      width: double.infinity,
      color: AppColors.backgroundOfScreenColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsGrid(context),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderText(context),
                const SizedBox(height: 20),

                _buildCustomerAndFiltersRow(context, controller),
                const SizedBox(height: 24),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTableHeader(context),
                      if (controller.selectedCustomerPaymentHistory.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Text("No payment history records found."),
                        )
                      else
                        ...controller.selectedCustomerPaymentHistory
                            .map((data) => _buildPaymentRow(context, data)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildPagination(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ------------- Extra Widget ---------------------- ///

  // Kpi Stat card
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      int crossAxisCount = width >= 1100 ? 4 : (width >= 750 ? 2 : 1);
      double spacing = 16;
      double totalSpacing = (crossAxisCount - 1) * spacing;
      double cardWidth = (width - totalSpacing) / crossAxisCount;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _statCard(context, cardWidth, "Total Revenue", "\$ 1245567", IconString.paymentIconModule),
          _statCard(context, cardWidth, "Auto Payments", "6", IconString.autoPaymentICon),
          _statCard(context, cardWidth, "Manual Payment", "4", IconString.manualIcon),
          _statCard(context, cardWidth, "Active paid Customer", "65", IconString.paidCustomerIcon),
        ],
      );
    });
  }

  Widget _statCard(BuildContext context, double width, String title, String value, String iconData) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(iconData,height: 20,width: 20, color: AppColors.textColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.bodyRegular12(context),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TTextTheme.h2Style(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header Text
  Widget _buildHeaderText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "All payments",
          style: TTextTheme.h2Style(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "List of all payments",
          style: TTextTheme.bodyRegular14tertiary(context),
        ),
      ],
    );
  }

  // Filter Row
  Widget _buildCustomerAndFiltersRow(BuildContext context, PaymentController controller) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 900;
      double fieldHeight = 42;

      return isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerTag(context, controller),
          const SizedBox(height: 12),
          _buildDateFilterBox(context, isMobile, fieldHeight, controller),
          const SizedBox(height: 12),
          _buildCustomerDropdown(context, controller, isMobile, fieldHeight),
          const SizedBox(height: 12),
          _buildSearchBar(context, isMobile, fieldHeight),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCustomerTag(context, controller),
          Row(
            children: [
              _buildDateFilterBox(context, isMobile, fieldHeight, controller),
              const SizedBox(width: 12),
              _buildCustomerDropdown(context, controller, isMobile, fieldHeight),
              const SizedBox(width: 12),
              _buildSearchBar(context, isMobile, fieldHeight),
            ],
          ),
        ],
      );
    });
  }

  // Customer Tag
  Widget _buildCustomerTag(BuildContext context, PaymentController controller) {
    return Obx(() {
      final customer = controller.selectedCustomerData;
      String customerName = customer['customerName'] ?? 'John Smith';
      String customerId = customer['id'] ?? 'CUS-1234';

      return Container(
        width: MediaQuery.of(context).size.width < 900 ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.backgroundOfScreenColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.sideBoxesColor,
            width: 1,
          ),
        ),
        child: Text(
          "Customer: $customerName ($customerId)",
          style: TTextTheme.h2Style(context).copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );
    });
  }

  // Date Filter
  Widget _buildDateFilterBox(BuildContext context, bool isMobile, double height, PaymentController controller) {
    return CompositedTransformTarget(
      link: controller.dateFilterLink,
      child: InkWell(
        onTap: () {
          controller.toggleCalendar(
            context,
            controller.dateFilterLink,
            controller.dateTextController,
            isMobile ? MediaQuery.of(context).size.width * 0.85 : 320,
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height,
          width: isMobile ? double.infinity : 180,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Image.asset(IconString.calendarIcon,height: 18,width: 18,color: AppColors.tertiaryTextColor,),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(() => Text(
                  controller.selectedDateRangeText.value.isEmpty
                      ? "Filter by Date"
                      : controller.selectedDateRangeText.value,
                  style: TTextTheme.btncustomer(context),
                  overflow: TextOverflow.ellipsis,
                )),
              ),
              Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.quadrantalTextColor),
            ],
          ),
        ),
      ),
    );
  }

  // Customer Dropdown
  Widget _buildCustomerDropdown(BuildContext context, PaymentController controller, bool isMobile, double height) {
    final List<String> items = [
      "Customer Name",
      "Car Name",
      "Registration",
      "Amount",
    ];

    return Obx(() {
      return PopupMenuButton<String>(
        offset: const Offset(0, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        onSelected: (val) => controller.selectedSearchCategory.value = val,
        child: Container(
          height: height,
          width: isMobile ? double.infinity : 140,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  controller.selectedSearchCategory.value.isEmpty
                      ? "Registration"
                      : controller.selectedSearchCategory.value,
                  style: TTextTheme.btncustomer(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.quadrantalTextColor,
              ),
            ],
          ),
        ),
        itemBuilder: (context) {
          return items.asMap().entries.map((entry) {
            int idx = entry.key;
            String item = entry.value;

            return PopupMenuItem<String>(
              value: item,
              height: 40,
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: controller.selectedSearchCategory.value == item
                            ? AppColors.primaryColor
                            : AppColors.textColor,
                      ),
                    ),
                  ),
                  if (idx != items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 0.8,
                      color: AppColors.sideBoxesColor,
                    ),
                ],
              ),
            );
          }).toList();
        },
      );
    });
  }

  // Searchbar
  Widget _buildSearchBar(BuildContext context, bool isMobile, double height) {
    return Container(
      width: isMobile ? double.infinity : 280,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.signaturePadColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, size: 18, color: AppColors.quadrantalTextColor),
          ),
          Expanded(
            child: TextField(
              cursorColor: AppColors.blackColor,
              textAlignVertical: TextAlignVertical.center,
              style: TTextTheme.insidetextfieldWrittenText(context),
              decoration: InputDecoration(
                hintText: "Search Company by Name",
                hintStyle: TTextTheme.smallX(context),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.only(bottom: 2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text("Search", style: TTextTheme.searchText(context)),
            ),
          ),
        ],
      ),
    );
  }

  // Table Header
  Widget _buildTableHeader(BuildContext context) {
    const double containerWidth = 1480;

    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _tableHeaderCell(context, "Registration", 130),
          _tableHeaderCell(context, "Car Name", 210),
          _tableHeaderCell(context, "Duration", 200),
          _tableHeaderCell(context, "Payment Type", 150),
          _tableHeaderCell(context, "Payment Status", 160),
          _tableHeaderCell(context, "Submission Status", 170),
          _tableHeaderCell(context, "Amount", 120),
          _tableHeaderCell(context, "Paid Date", 140),
          _tableHeaderCell(context, "Action", 100, isAction: true),
        ],
      ),
    );
  }

  Widget _tableHeaderCell(
      BuildContext context,
      String title,
      double width,
      {bool isAction = false}
      ) {
    final PaymentController controller = Get.find<PaymentController>();

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: isAction ? null : () => controller.toggleSort(title),
        child: Row(
          mainAxisAlignment: isAction ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TTextTheme.medium14tableHeading(context),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 6),

            if (!isAction)
              Obx(() {
                bool isCurrent = controller.sortColumn.value == title;
                int order = isCurrent ? controller.sortOrder.value : 0;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: Image.asset(
                          IconString.sortIcon,
                          height: 14,
                          color: order == 1 ? AppColors.primaryColor : AppColors.secondTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 1),
                    ClipRect(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 0.5,
                        child: Image.asset(
                          IconString.sortIcon,
                          height: 14,
                          color: order == 2 ? AppColors.primaryColor : AppColors.secondTextColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
          ],
        ),
      ),
    );
  }

  // Payment Row
  Widget _buildPaymentRow(BuildContext context, Map<String, dynamic> data) {
    const double containerWidth = 1480;

    IconData? icon;
    String pType = (data["paymentType"] ?? "Manual").toString().toLowerCase();
    if (pType.contains("direct debit")) {
      icon = Icons.credit_card;
    } else if (pType.contains("pay to")) {
      icon = Icons.electric_bolt;
    }

    String paymentStatus = (data["paymentStatus"] ?? "Pending").toString().toLowerCase();

    return Container(
      width: containerWidth,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              data["registration"] ?? "Abc12345",
              style: TTextTheme.bodySemiBold14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 210,
            child: Text(
              data["carName"] ?? "Toyota Corolla 2022 Altis",
              style: TTextTheme.tableRegular14black(context),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              data["duration"] ?? "Mar 7, 2026 - Mar 14, 2026",
              style: TTextTheme.tableRegular14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: AppColors.primaryColor),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    data["paymentType"] ?? "Manual",
                    style: TTextTheme.tableRegular14black(context),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 160,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildStatusChip(context, data["paymentStatus"] ?? "Pending"),
            ),
          ),
          SizedBox(
            width: 170,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildSubmissionChip(context, data["submissionStatus"] ?? "Nill"),
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              "\$${data["amount"] ?? "45.00"}",
              style: TTextTheme.bodySemiBold14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              data["paidDate"] ?? "7th April,2026",
              style: TTextTheme.tableRegular14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              children: [
                _buildActionButton(
                  iconPath: IconString.viewIcon,
                  onTap: () {},
                ),
                // Sirf tabhi approved/completed icon dikhayega jab status "completed" NA ho
                if (paymentStatus != 'completed') ...[
                  const SizedBox(width: 6),
                  _buildActionButton(
                    iconPath: IconString.approvedIcon,
                    onTap: () {
                      showPausedConfirmationDialog(context);
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Action Button
  Widget _buildActionButton({required String iconPath, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Image.asset(
          iconPath,
          color: Colors.white,
        ),
      ),
    );
  }

  // Status Chip
  Widget _buildStatusChip(BuildContext context, String status) {
    Color bg;
    switch (status.toLowerCase()) {
      case 'pending':
        bg = AppColors.pendingColor;
        break;
      case 'overdue':
        bg = AppColors.overdueColor;
        break;
      case 'completed':
        bg = AppColors.completedColor;
        break;
      default:
        bg = AppColors.secondTextColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TTextTheme.bodySemiBold14White(context).copyWith(fontSize: 12),
      ),
    );
  }

  // Submission chip
  Widget _buildSubmissionChip(BuildContext context, String status) {
    Color bg;
    switch (status.toLowerCase()) {
      case 'late':
        bg = AppColors.primaryColor;
        break;
      case 'on time':
        bg = AppColors.completedColor;
        break;
      case 'nill':
      case 'nil':
      default:
        bg = AppColors.tertiaryTextColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TTextTheme.bodySemiBold14White(context).copyWith(fontSize: 12),
      ),
    );
  }

  // Pagination
  Widget _buildPagination(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: PaginationBarOfPayment(
        isMobile: isMobile,
        tablePadding: 240,
      ),
    );
  }

  /// Dialog
  void showPausedConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50, width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text("🤨", style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Marked Payment as Completed", style: TTextTheme.h2Style(context)),
                          const SizedBox(height: 8),
                          Text(
                            "Are your sure you want marked it as completed",
                            style: TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, size: 20),
                      padding: EdgeInsets.zero,
                    )
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50),
                          side: BorderSide(color: AppColors.primaryColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showPausedSuccessDialog(context);
                        },
                        child: Text(
                          "Save",
                          style: TTextTheme.medium14Primary(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50),
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TTextTheme.btnWhiteColor(context),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
  void showPausedSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 450,
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.emojiBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Payment Marked Successfully",
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                "Congratulations! Payment has been marked",
                                style: TTextTheme.bodyRegular16(context)
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.sideBoxesColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 16, color: AppColors.blackColor),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}