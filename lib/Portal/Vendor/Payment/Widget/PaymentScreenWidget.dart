import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PaginationBarOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

                // Headings
                Text(
                  TextString.titlePayment,
                  style:TTextTheme.h2Style(context),
                ),
                const SizedBox(height: 4),
                Text(
                  TextString.subTitlePayment,
                  style: TTextTheme.bodyRegular16(context),
                ),

                const SizedBox(height: 25),

                _buildTabs(),

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

  /// -------- Extra Widgets ------- ///

  // Cards
  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = constraints.maxWidth > 850
          ? 4
          : (constraints.maxWidth > 480 ? 2 : 1);

      double aspectRatio;
      if (constraints.maxWidth > 850) {
        aspectRatio = 1.8;
      } else if (constraints.maxWidth > 480) {
        aspectRatio = 1.8;
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
          _statCard("Total Revenue", "\$ 12345.99", "Paid Last Week ", IconString.paymentIconModule),
          _statCard("Action Required", "24", "24 more invoices needed to review ", IconString.actionRequiredIcon),
          _statCard("Pending Payment ", "8", "3 more payment pending", IconString.pendingPaymentIcon),
          _statCard("OverDue", "5", "1 more payment date passed", IconString.overdueIcon),
          _statCard("Resubmit Request", "8","3 more resubmit request send", IconString.resubmitIcon),
          _statCard("Submitted", "8", "1 more payment submitted ", IconString.submittedIcon),
          _statCard("Completed Payments", "246", "3 more payment marked as completed", IconString.completedIcon),
          _statCard("Total Payments", "246", "3 more payment received", IconString.paymentIconModule),
        ],
      );
    });
  }
  Widget _statCard(String title, String value, String sub, String icon) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.only(top: 20,left: 20),
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


  // Tabs
  Widget _buildTabs() {
    List<String> tabs = [
      "Pending",
      "Overdue",
      "Submitted",
      "Resubmit",
      "Completed"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color:AppColors.signaturePadColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.sideBoxesColor.withOpacity(0.7),width: 1)
        ),
        child: Obx(() => Row(
          mainAxisSize: MainAxisSize.min,
          children: tabs.map((tab) {
            bool isSelected = controller.selectedTab.value == tab;

            return GestureDetector(
              onTap: () => controller.changeTab(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tab,
                  style: isSelected ? TTextTheme.medium14White(context) : TTextTheme.bodyRegular14tertiary(context),
                ),
              ),
            );
          }).toList(),
        )),
      ),
    );
  }


  // Table Widgets
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
    String status = rawStatus.toLowerCase();
    bool isViewMode = status == 'completed' || status == 'submitted';

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
          _cell(width: 120, child: Text("\$${data["amount"]}", style: TTextTheme.bodySemiBold16(context).copyWith(color: Colors.red))),
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
                      isViewMode
                          ? const Icon(Icons.visibility_outlined, size: 16)
                          : Image.asset(IconString.uploadIcon, height: 16, width: 16),
                      const SizedBox(width: 6),
                      Text(
                        isViewMode ? "View" : "Upload",
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