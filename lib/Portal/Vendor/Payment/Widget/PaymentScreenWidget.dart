import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PaginationBarOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
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
          _buildTopHeader(context),
          SizedBox(height: 10,),
          Obx(() {
            bool isManual = controller.selectedMainTab.value == "Manual Payment";

            return Column(
              children: [
                isManual ? _buildStatsGrid(context) : _buildAutoPaymentStatsGrid(context),

                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isMobile = constraints.maxWidth < 330;
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
                              _buildHeaderText(),
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
                            bool isManual = controller.selectedMainTab.value == "Manual Payment";
                            var currentDataList = isManual
                                ? controller.displayedCarList
                                : controller.autoData;

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: isManual ? 1180 : 1520,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    isManual
                                        ? _buildTableHeader(controller)
                                        : _buildAutoTableHeader(controller),

                                    const SizedBox(height: 8),

                                    if (currentDataList.isEmpty)
                                      const SizedBox(height: 200, child: Center(child: Text("No Data Found")))
                                    else
                                      Column(
                                        children: currentDataList
                                            .map((data) => isManual
                                            ? _buildPaymentRow(data)
                                            : _buildAutoPaymentRow(data))
                                            .toList(),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          });
                        },
                      ),
                      _buildPagination(),
                    ],
                  ),
                ),
              ],
            );
          }),

        ],
      ),
    );
  }

  /// --- Extra Widgets ---
  // Top Tabs
  Widget _buildTopHeader(BuildContext context) {
    bool isMobile = AppSizes.isMobile(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Align(
        alignment: isMobile ? Alignment.centerLeft : Alignment.centerRight,
        child: _buildMainToggleTabs(isMobile),
      ),
    );
  }
  Widget _buildMainToggleTabs(bool isMobile) {
    return Obx(() => Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _tabButton("Manual Payment", isMobile),
        _tabButton("Auto Payment", isMobile),
      ],
    ));
  }
  Widget _tabButton(String title, bool isMobile) {
    bool isSelected = controller.selectedMainTab.value == title;

    return InkWell(
      onTap: () {
        controller.selectedMainTab.value = title;
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: isMobile ? (MediaQuery.of(context).size.width * 0.44) : 160,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.quadrantalTextColor.withOpacity(0.8),
            width: 1,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: isSelected ? TTextTheme.btnWhiteColor(context) : TTextTheme.bodyRegular14Search(context)
        ),
      ),
    );
  }
  // Filters
  Widget _buildFiltersRow() {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      bool isMobile = width < 750;
      double fieldHeight = 40;

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
            border: Border.all(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
          ),
          child: Row(
            children: [
              Icon(
                  Icons.calendar_today_outlined,
                  size: 18,
                  color: AppColors.quadrantalTextColor
              ),
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
              Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.quadrantalTextColor
              ),
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
                contentPadding: const EdgeInsets.only(bottom: 4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
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
    List<String> items = ["Customer Name", "Invoice Id",];

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;

      return PopupMenuButton<String>(
        constraints: BoxConstraints(
          minWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 180,
          maxWidth: isMobile ? (MediaQuery.of(context).size.width - 48) : 180,
        ),
        offset: const Offset(0, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
                  selectedValue.value.isEmpty ? "Select Item" : selectedValue.value,
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
        itemBuilder: (context) => items.asMap().entries.map((entry) {
          return PopupMenuItem<String>(
            value: entry.value,
            padding: EdgeInsets.zero,
            height: 40,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Text(
                    entry.value,
                    style: TTextTheme.bodyRegular14(context),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  // Header Text
  Widget _buildHeaderText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.titlePayment, style: TTextTheme.h2Style(context)),
        const SizedBox(height: 4),
        Text(TextString.subTitlePayment, style: TTextTheme.bodyRegular16(context)),
      ],
    );
  }
  Widget _buildAddPaymentButton(bool isFullWidth) {
    return PrimaryBtnOfPayment(
      text: "Add Payment",
      onTap: () {
        context.go('/AddPayment', extra: {"hideMobileAppBar": true});
      },
      width: isFullWidth ? double.infinity : 160,
      borderRadius: BorderRadius.circular(10),
    );
  }

  //  Stats Grid
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth > 850
          ? 4
          : (constraints.maxWidth > 480 ? 3 : 1);

      double aspectRatio;
      if (constraints.maxWidth > 850) {
        aspectRatio = 1.8;
      } else if (constraints.maxWidth > 480) {
        aspectRatio = 1.4;
      } else {
        aspectRatio = constraints.maxWidth / 110;
      }

      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspectRatio,
        children: [
          _statCard(TextString.revenue, "\$ 12345.99",TextString.revenuesubtitle , IconString.paymentIconBlack),
          _statCard(TextString.actionRequired, "24",TextString.actionRequiredsubtitle , IconString.actionRequiredIcon),
          _statCard(TextString.pendingpayment, "8",TextString.pendingpaymentsubtitle , IconString.pendingPaymentIcon),
          _statCard(TextString.overduePayment, "5", TextString.overduePaymentsubtitle, IconString.overdueIcon),
          _statCard(TextString.resubmitrequest, "8",TextString.resubmitrequestsubtitle, IconString.resubmitIcon),
          _statCard(TextString.submitPayment, "8",TextString.submitPaymentsubtitle, IconString.submittedIcon),
          _statCard(TextString.completedPayment, "246",TextString.completedPaymentsubtitle , IconString.completedIcon),
          _statCard(TextString.total, "246",TextString.totalsubtitle , IconString.paymentIconBlack),
        ],
      );
    });
  }
  Widget _statCard(String title, String value, String sub, String icon) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.only(top: 20,left: 20,bottom:0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              icon,
              height: 22,
              width: 22,
            ),
          ),

          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.bodyRegular12(context)
                ),
                const SizedBox(height: 6),
                Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.h2Style(context)
                ),
                const SizedBox(height: 10),
                Text(
                    sub,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.bodySecondRegular10(context)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   // Auto PAyment Cards
  Widget _buildAutoPaymentStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth > 850 ? 3 : (constraints.maxWidth > 480 ? 2 : 1);
      double aspectRatio = constraints.maxWidth > 850 ? 2.2 : 1.5;

      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: aspectRatio,
        children: [
          _autoStatCard(context, "Total Revenue", "1245567", "paid last week",
              IconString.paymentIconBlack,  AppColors.secondaryColor),
          _autoStatCard(context, "Successful Payments", "24", "4 more payment successfully received",
              null, AppColors.secondaryColor, isDot: true, dotColor: AppColors.completedColor),
          _autoStatCard(context, "Failed Payments", "6", "6 more payment doesnot executed on third try",
              null, AppColors.secondaryColor, isDot: true, dotColor: AppColors.primaryColor),
          _autoStatCard(context, "Pending Payments", "50", "50 more payments will be executed further",
              IconString.pendingAuto, AppColors.secondaryColor),
          _autoStatCard(context, "Paused Accounts", "2", "2 more accounts got paused",
              IconString.PausedAccountAuto, AppColors.secondaryColor),
          _autoStatCard(context, "Success Rate", "80%", "3 more percent improve this week",
              IconString.SuccessRateAuto, AppColors.secondaryColor),
        ],
      );
    });
  }
  Widget _autoStatCard(BuildContext context, String title, String value, String sub, String? icon, Color iconBg, {bool isDot = false, Color? dotColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: isDot
                ? _buildGlowingDot(dotColor!)
                : Image.asset(icon!, height: 22, width: 22),
          ),

          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.bodyRegular12(context)
                ),
                const SizedBox(height: 6),
                Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.h2Style(context)
                ),
                const SizedBox(height: 8),
                Text(
                    sub,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TTextTheme.bodySecondRegular10(context)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildGlowingDot(Color color) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.5), blurRadius: 6, spreadRadius: 1)
        ],
        gradient: RadialGradient(
          colors: [Colors.white.withOpacity(0.8), color],
          stops: const [0.1, 1.0],
        ),
      ),
    );
  }

  //  Tabs
  Widget _buildTabs() {
    List<String> tabs = ["Pending", "Overdue", "Submitted", "Resubmit", "Completed"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7))),
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
                child: Text(tab, style: isSelected ? TTextTheme.medium14White(context) : TTextTheme.bodyRegular14tertiary(context)),
              ),
            );
          }).toList(),
        )),
      ),
    );
  }

  //  Table
  Widget _buildTableHeader(PaymentController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 200, child: _headerCell(TextString.header1payment, controller)),
          SizedBox(width: 150, child: _headerCell(TextString.header7payment, controller)),
          SizedBox(width: 235, child: _headerCell(TextString.header2payment, controller)),
          SizedBox(width: 200, child: _headerCell(TextString.header3payment, controller)),
          SizedBox(width: 120, child: _headerCell(TextString.header4payment, controller)),
          SizedBox(width: 130, child: _headerCell(TextString.header5payment, controller, isCenter: true, canSort: false)),
          SizedBox(width: 100, child: _headerCell(TextString.header6payment, controller, isCenter: true, canSort: false)),
        ],
      ),
    );
  }
  Widget _headerCell(String title, PaymentController controller,
      {bool isCenter = false, bool canSort = true}) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort(title) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
                      Icon(Icons.keyboard_arrow_up, size: 12,
                          color: order == 1 ? AppColors.primaryColor : AppColors.textColor),
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: Icon(Icons.keyboard_arrow_down, size: 12,
                            color: order == 2 ? AppColors.primaryColor : AppColors.textColor),
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
  Widget _buildPaymentRow(Map data) {
    String rawStatus = data["status"] ?? "Pending";

    return Container(
      width: 1180,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7), width: 1),
      ),
      child: Row(
        children: [
          _cell(width: 200, child: Text(data["id"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 150, child: Text(data["customerName"] ?? "Jhon Martin", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 240, child: Text(data["duration"] ?? "", style: TTextTheme.tableRegular14black(context))),
          _cell(width: 200, child: Text(data["car"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 120, child: Text("\$${data["amount"]}", style: TTextTheme.bodySemiBold16(context))),
          _cell(width: 130, child: Center(child: _buildStatusChip(rawStatus))),
          SizedBox(
            width: 100,
            child: Center(
              child: SizedBox(
                height: 36,
                width: 110,
                child: OutlinedButton(
                  onPressed: () {
                    context.go('/invoicesDetail', extra: data);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: const BorderSide(color: AppColors.primaryColor),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Icon(Icons.visibility_outlined, size: 16),
                      const SizedBox(width: 6),
                      Text(
                         "View" ,
                        style: TTextTheme.tableRegular14Primary(context),
                      ),
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
  Widget _buildAutoTableHeader(PaymentController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 220, child: _headerCell("Customer", controller)),
          SizedBox(width: 180, child: _headerCell("Car Name", controller)),
          SizedBox(width: 120, child: _headerCell("Registration", controller)),
          SizedBox(width: 220, child: _headerCell("Duration", controller)),
          SizedBox(width: 140, child: _headerCell("Source", controller)),
          SizedBox(width: 100, child: _headerCell("Amount", controller)),
          SizedBox(width: 150, child: _headerCell("Due Date", controller)),
          SizedBox(width: 120, child: _headerCell("Status", controller, isCenter: true)),
          SizedBox(width: 100, child: _headerCell("Attempts", controller, isCenter: true)),
          SizedBox(width: 110, child: _headerCell("Action", controller, isCenter: true, canSort: false)),
        ],
      ),
    );
  }
  Widget _buildAutoPaymentRow(Map data) {
    String rawStatus = data["status"] ?? "Pending";
    return Container(
      width: 1530,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7), width: 1),
      ),
      child: Row(
        children: [
          _cell(width: 220, child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(ImageString.customerUser), 
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data["customerName"] ?? "", style: TTextTheme.bodySemiBold14black(context), overflow: TextOverflow.ellipsis),
                    Text(data["email"] ?? "user@example.com", style: TTextTheme.bodyRegular14(context), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          )),
          _cell(width: 180, child: Text(data["car"] ?? "", style: TTextTheme.tableRegular14black(context), overflow: TextOverflow.ellipsis)),
          _cell(width: 120, child: Text(data["registration"] ?? "1234567890", style: TTextTheme.tableRegular14black(context))),
          _cell(width: 220, child: Text(data["duration"] ?? "", style: TTextTheme.tableRegular14black(context))),
          _cell(width: 140, child: _buildSourceWidget(data["source"])),
          _cell(width: 100, child: Text("\$${data["amount"]}", style: TTextTheme.bodySemiBold14black(context))),
          _cell(width: 150, child: Text(data["dueDate"] ?? "7th April, 2026", style: TTextTheme.tableRegular14black(context))),
          _cell(width: 130, child: Center(child: _buildStatusChip(rawStatus))),
          _cell(width: 100, child: Center(child: Text(data["attempts"] ?? "1/3", style: TTextTheme.tableRegular14black(context)))),
          _cell(width: 110, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => showPausedConfirmationDialog(context),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.pause_circle_outline,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => showCancelConfirmationDialog(context),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                      Icons.cancel_outlined,
                      size: 20,
                      color: AppColors.blackColor
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
  Widget _buildSourceWidget(dynamic sourceValue) {
    String source = sourceValue?.toString() ?? "";
    String icon;
    switch (source) {
      case 'Stripe':
        icon = IconString.stripeICon;
        break;
      case 'Direct Debit':
        icon = IconString.ddIcon;
        break;
      case 'Pay to':
        icon = IconString.paytoIcon;
        break;
      default:
        icon = IconString.stripeICon;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon, height: 18, width: 18),
        const SizedBox(width: 8),
        Text(
          source.isEmpty ? "N/A" : source,
          style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 12),
        ),
      ],
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
      case 'submitted':
        backgroundColor = AppColors.textColor;
        displayStatus = "Submitted";
        break;
      default:
        backgroundColor = Colors.grey;
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
        style: TTextTheme.bodySemiBold14White(context),
      ),
    );
  }

  // Pagination
  Widget _buildPagination() {

    bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

      child: PaginationBarOfPayment(
        isMobile: isMobile, tablePadding: 240,
      ),
    );
  }

   /// Diaogs
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
}