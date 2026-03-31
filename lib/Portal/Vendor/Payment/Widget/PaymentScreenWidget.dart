import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PaginationBarOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/Widget/ChartWidget.dart';
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
          _buildStatsGrid(context),
          const SizedBox(height: 20),
          ChartWidget(),
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
                    if (isMobile) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeaderText(),
                          const SizedBox(height: 16),
                          _buildAddPaymentButton(isMobile),
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeaderText(),
                          _buildAddPaymentButton(isMobile),
                        ],
                      );
                    }
                  },
                ),

                const SizedBox(height: 25),
                _buildTabs(),
                const SizedBox(height: 20),
                _buildFiltersRow(),

                const SizedBox(height: 30),

                // Table Area
                LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 1180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTableHeader(controller),
                            const SizedBox(height: 8),
                            Obx(() {
                              if (controller.displayedCarList.isEmpty) {
                                return const SizedBox(height: 200, child: Center(child: Text("No Data Found")));
                              }
                              return Column(
                                children: controller.displayedCarList.map((data) => _buildPaymentRow(data)).toList(),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                _buildPagination(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// --- Extra Widgets ---
  // Filters
  Widget _buildFiltersRow() {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      bool isMobile = width < 450;
      double fieldHeight = 40;

      return Align(
        alignment: isMobile ? Alignment.centerLeft : Alignment.centerRight,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.start : WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildCustomerDropdown(
                context,
                "cust_drop",
                controller.selectedCustomerValue,
                isMobile,
                fieldHeight
            ),
            Container(
              width: isMobile ? double.infinity : 320,
              height: fieldHeight,
              decoration: BoxDecoration(
                color: AppColors.signaturePadColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                        contentPadding: EdgeInsets.only(bottom: 4),
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
                      child:  Text("Search", style: TTextTheme.searchText(context)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: isMobile ? double.infinity : null,
              height: fieldHeight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.signaturePadColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(IconString.filterIcon, height: 18,width: 18,),
                  const SizedBox(width: 8),
                  Text("Filter", style: TTextTheme.btncustomer(context)),
                  const Icon(Icons.keyboard_arrow_down, size: 18),
                ],
              ),
            ),
          ],
        ),
      );
    });
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
        context.push('/AddPayment', extra: {"hideMobileAppBar": true});
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
          _statCard("Total Revenue", "\$ 12345.99", "Paid Last Week ", IconString.paymentIconBlack),
          _statCard("Action Required", "24", "24 more invoices needed to review ", IconString.actionRequiredIcon),
          _statCard("Pending Payment ", "8", "3 more payment pending", IconString.pendingPaymentIcon),
          _statCard("OverDue", "5", "1 more payment date passed", IconString.overdueIcon),
          _statCard("Resubmit Request", "8","3 more resubmit request send", IconString.resubmitIcon),
          _statCard("Submitted", "8", "1 more payment submitted ", IconString.submittedIcon),
          _statCard("Completed Payments", "246", "3 more payment marked as completed", IconString.completedIcon),
          _statCard("Total Payments", "246", "3 more payment received", IconString.paymentIconBlack),
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
          SizedBox(width: 150, child: _headerCell("Customer Name", controller)),
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
                  onPressed: () {},
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
}