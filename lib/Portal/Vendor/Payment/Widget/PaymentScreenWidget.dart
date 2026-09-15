import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PaginationBarOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildStatsGrid(context),
          const SizedBox(height: 30),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isMobile = constraints.maxWidth < 450;
                    return isMobile
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeaderText(),
                        const SizedBox(height: 16),
                        _buildAddPaymentButton(isMobile),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildHeaderText()),
                        const SizedBox(width: 16),
                        _buildAddPaymentButton(isMobile),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 25),
                _buildTabs(),
                const SizedBox(height: 20),
                _buildFiltersRow(),
                const SizedBox(height: 30),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Obx(() {
                      var currentList = controller.displayedCarList;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTableHeader(controller),
                            ...currentList.map((data) {
                              return _buildPaymentRow(data);
                            }),
                          ],
                        ),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
                _buildPagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------Extra Widget --------------///

  //  Filters Row
  Widget _buildFiltersRow() {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      bool isMobile = width < 750;
      double fieldHeight = 42;

      return Align(
        alignment: isMobile ? Alignment.centerLeft : Alignment.centerRight,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildDateFilterBox(context, isMobile, fieldHeight),
            _buildCustomerDropdown(
                context,
                "cust_drop",
                controller.selectedCustomerValue,
                isMobile,
                fieldHeight
            ),
            _buildSearchBar(context, isMobile, fieldHeight),
          ],
        ),
      );
    });
  }

  Widget _buildDateFilterBox(BuildContext context, bool isMobile, double height) {
    return CompositedTransformTarget(
      link: controller.dateFilterLink,
      child: InkWell(
        onTap: () {
          controller.toggleCalendar(
              context,
              controller.dateFilterLink,
              controller.dateTextController,
              isMobile ? MediaQuery.of(context).size.width * 0.9 : 320
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: height,
          width: isMobile ? double.infinity : 200,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.quadrantalTextColor),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(() => Text(
                  controller.selectedDateRangeText.value.isEmpty
                      ? "Filter by Week"
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

  Widget _buildSearchBar(BuildContext context, bool isMobile, double height) {
    return Container(
      width: isMobile ? double.infinity : 320,
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
                hintText: TextString.searchTextPayment,
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
              child: Text(TextString.search, style: TTextTheme.searchText(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerDropdown(BuildContext context, String id, RxString selectedValue, bool isMobile, double height) {
    List<String> items = ["Customer Name", "Registration No", "Car Name"];

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;

      return PopupMenuButton<String>(
        constraints: BoxConstraints(
          minWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 180,
          maxWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 180,
        ),
        offset: const Offset(0, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white,
        elevation: 4,
        onOpened: () => controller.openedDropdown2.value = id,
        onCanceled: () => controller.openedDropdown2.value = "",
        onSelected: (val) {
          selectedValue.value = val;
          controller.openedDropdown2.value = "";
        },
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
              Expanded(
                child: Text(
                  selectedValue.value.isEmpty ? "Customer" : selectedValue.value,
                  style: TTextTheme.btncustomer(context),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 20,
                color: AppColors.blackColor,
              ),
            ],
          ),
        ),
        itemBuilder: (context) => items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            padding: EdgeInsets.zero,
            height: 40,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(item, style: TTextTheme.bodyRegular14(context)),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildHeaderText() {
    return Obx(() {
      String currentTab = controller.selectedTab.value;
      String dynamicNote = "";
      if (currentTab == "Submitted" || currentTab == "ReSubmit") {
        dynamicNote = " (This tab is specifically for Manual Payment)";
      } else if (currentTab == "Failed") {
        dynamicNote = " (This tab is specifically for Auto Payment)";
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TTextTheme.h2Style(context),
              children: [
                const TextSpan(text: TextString.titlePayment),
                if (dynamicNote.isNotEmpty)
                  TextSpan(
                    text: dynamicNote,
                    style: TTextTheme.h2Style(context).copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.subTitlePayment,
            style: TTextTheme.bodyRegular16(context),
          ),
        ],
      );
    });
  }

  Widget _buildAddPaymentButton(bool isFullWidth) {
    return PrimaryBtnOfPayment(
      text: "Link Payment",
      onTap: () {
        context.push('/linkPayment', extra: {"hideMobileAppBar": true});
      },
      width: isFullWidth ? double.infinity : 160,
      borderRadius: BorderRadius.circular(10),
    );
  }

  // KPI Stats Grid
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      int crossAxisCount = width >= 1100 ? 4 : (width >= 750 ? 3 : (width >= 480 ? 2 : 1));
      double spacing = 16;
      double totalSpacing = (crossAxisCount - 1) * spacing;
      double cardWidth = (width - totalSpacing) / crossAxisCount;

      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          _statCard(context, cardWidth, TextString.revenue, "\$ 12345.99", IconString.paymentIconBlack),
          _statCard(context, cardWidth, TextString.actionRequired, "24", IconString.actionRequiredIcon),
          _statCard(context, cardWidth, TextString.pendingpayment, "8", IconString.pendingPaymentIcon),
          _statCard(context, cardWidth, TextString.overduePayment, "5", IconString.overdueIcon),
          _statCard(context, cardWidth, TextString.resubmitrequest, "8", IconString.resubmitIcon),
          _statCard(context, cardWidth, TextString.submitPayment, "8", IconString.submittedIcon),
          _statCard(context, cardWidth, TextString.completedPayment, "246", IconString.completedIcon),
          _statCard(context, cardWidth, TextString.total, "246", IconString.paymentIconBlack),
        ],
      );
    });
  }

  Widget _statCard(BuildContext context, double width, String title, String value, String icon) {
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
            child: Image.asset(icon, height: 20, width: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TTextTheme.bodyRegular12(context)),
                const SizedBox(height: 4),
                Text(value, maxLines: 1, overflow: TextOverflow.ellipsis, style: TTextTheme.h2Style(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Status Tabs
  Widget _buildTabs() {
    List<String> tabs = ["All", "Pending", "Overdue", "Submitted", "ReSubmit", "Failed", "Completed"];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.7))),
        child: Obx(() => Row(
          children: tabs.map((tab) {
            bool isSelected = controller.selectedTab.value == tab;
            return GestureDetector(
              onTap: () => controller.changeTab(tab),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                    tab,
                    style: isSelected
                        ? TTextTheme.medium14White(context)
                        : TTextTheme.bodyRegular14tertiary(context)
                ),
              ),
            );
          }).toList(),
        )),
      ),
    );
  }

  /// Data Table Headers
  Widget _buildTableHeader(PaymentController controller) {
    return Container(
      width: 1450,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 110, child: _headerCell("Reg No", controller)),
          SizedBox(width: 150, child: _headerCell(TextString.header7payment, controller)),
          SizedBox(width: 200, child: _headerCell(TextString.header2payment, controller)),
          SizedBox(width: 180, child: _headerCell(TextString.header3payment, controller)),
          SizedBox(width: 110, child: _headerCell(TextString.header4payment, controller)),
          SizedBox(width: 150, child: _headerCell("Payment Type", controller)),
          SizedBox(width: 170, child: _headerCell("Previous Overdue", controller)),
          SizedBox(width: 130, child: _headerCell(TextString.header5payment, controller, isCenter: true)),
          SizedBox(width: 110, child: _headerCell("Rating", controller, isCenter: true)),
          SizedBox(width: 110, child: _headerCell(TextString.header6payment, controller, isCenter: true, canSort: false)),
        ],
      ),
    );
  }

  Widget _headerCell(String title, PaymentController controller, {bool isCenter = false, bool canSort = true}) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort(title) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Row(
          mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                bool isCurrent = controller.sortColumn.value == title;
                int order = isCurrent ? controller.sortOrder.value : 0;
                return SizedBox(
                  width: 12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.keyboard_arrow_up, size: 12, color: order == 1 ? AppColors.primaryColor : AppColors.textColor),
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: Icon(Icons.keyboard_arrow_down, size: 12, color: order == 2 ? AppColors.primaryColor : AppColors.textColor),
                      ),
                    ],
                  ),
                );
              })
            ],
          ],
        ),
      ),
    );
  }

  /// Data Table Rows
  Widget _buildPaymentRow(Map data) {
    String rawStatus = data["status"] ?? "Pending";

    return Container(
      width: 1450,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.7), width: 1),
      ),
      child: Row(
        children: [
          _cell(
              width: 110,
              child: Text(
                   "ABC 1234",
                  style: TTextTheme.bodySemiBold14black(context),
                  overflow: TextOverflow.ellipsis
              )
          ),
          _cell(
              width: 150,
              child: Text(
                  data["customerName"] ?? "Jhon Martin",
                  style: TTextTheme.bodySemiBold14black(context),
                  overflow: TextOverflow.ellipsis
              )
          ),
          _cell(
              width: 200,
              child: Text(
                data["duration"] ?? "Mar 7, 2026 - Mar 14, 2026",
                style: TTextTheme.tableRegular14black(context),
                overflow: TextOverflow.ellipsis,
              )
          ),
          _cell(
              width: 180,
              child: Text(
                  data["car"] ?? "Toyota Corolla 2022 Altis",
                  style: TTextTheme.tableRegular14black(context),
                  overflow: TextOverflow.ellipsis
              )
          ),
          _cell(
              width: 110,
              child: Text(
                  "\$${data["amount"] ?? "245"}",
                  style: TTextTheme.bodySemiBold16(context).copyWith(color: AppColors.primaryColor)
              )
          ),
          _cell(
              width: 150,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (data["paymentTypeIcon"] != null) ...[
                    Image.asset(data["paymentTypeIcon"], width: 16, height: 16),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      data["paymentType"] ?? "Pay to",
                      style: TTextTheme.tableRegular14black(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
          ),
          _cell(
              width: 150,
              child: Text(
                  data["previousOverdue"] ?? "2 Week",
                  style: TTextTheme.tableRegular14black(context)
              )
          ),
          _cell(width: 130, child: Center(child: _buildStatusChip(rawStatus))),
          _cell(
              width: 110,
              child: Center(
                child: Text(
                  data["rating"] ?? "80%",
                  style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.activeColor2),
                ),
              )
          ),
          SizedBox(
            width: 120,
            child: Obx(() {
              bool isCompletedTab = controller.selectedTab.value == "Completed";

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionIconButton(
                    iconPath: IconString.viewIcon,
                    onTap: () => context.push('/invoicesDetail', extra: data),
                  ),
                  if (!isCompletedTab) ...[
                    const SizedBox(width: 8),
                    _buildActionIconButton(
                      iconPath: IconString.approvedIconTwo,
                      onTap: () => showApproveRequestDialog(context),
                    ),
                  ],
                  const SizedBox(width: 8),
                  _buildActionIconButton(
                    iconPath: IconString.tableIcon,
                    onTap: () => context.go('/invoicesTableDetail'),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _buildActionIconButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 28,
        height: 28,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          iconPath,
          color: Colors.white,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }

  Widget _buildStatusChip(String status) {
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
      case 'failed':
        backgroundColor = AppColors.primaryColor;
        displayStatus = "Failed";
        break;
      case 'submitted':
        backgroundColor = AppColors.textColor;
        displayStatus = "Submitted";
        break;
      default:
        backgroundColor = AppColors.secondTextColor;
    }

    return Container(
      constraints: const BoxConstraints(minWidth: 85),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        displayStatus,
        textAlign: TextAlign.center,
        style: TTextTheme.bodySemiBold14White(context).copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildPagination() {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: PaginationBarOfPayment(
        isMobile: isMobile,
        tablePadding: 240,
      ),
    );
  }
   /// Dialogs
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
                      child: Center(child: Text("🤨", style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(TextString.dialogPayment1, style: TTextTheme.h2Style(context)),
                          const SizedBox(height: 8),
                          Text(
                           TextString.dialogPaymentSubtitle1,
                            style: TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, size: 20),
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
                                TextString.dialogPayment2,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.dialogPaymentSubtitle2,
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
  void showCancelConfirmationDialog(BuildContext context) {
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
                      child: Center(child: Text("🤨", style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(TextString.dialogPayment3, style: TTextTheme.h2Style(context)),
                          const SizedBox(height: 8),
                          Text(
                            TextString.dialogPaymentSubtitle3,
                            style: TTextTheme.bodyRegular16(context),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close_rounded, size: 20),
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
                          showCancelSuccessDialog(context);
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
  void showCancelSuccessDialog(BuildContext context) {
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
                                TextString.dialogPayment4,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.dialogPaymentSubtitle4,
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
  void showApproveRequestDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('🤨', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextString.dialogPayment5,
                            style: TTextTheme.h13Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            TextString.dialogPayment6,
                            style: TTextTheme.bodyRegular14(context).copyWith(
                              color: AppColors.secondTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: const BorderSide(color: AppColors.primaryColor, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            showSuccessDialog(context);
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Save',
                              style: TTextTheme.btnSavePrimary(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Cancel',
                              style: TTextTheme.btnSave(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showSuccessDialog(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Text('👍', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                        TextString.dialogPayment7,
                            style: TTextTheme.h13Style(context).copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            TextString.dialogPayment8,
                            style: TTextTheme.bodyRegular14(context).copyWith(
                              color: AppColors.secondTextColor,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}