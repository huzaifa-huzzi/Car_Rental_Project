import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


class InvoiceTableWidget extends StatelessWidget {
  final Map data;
  InvoiceTableWidget({super.key, required this.data});

  final controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, top: 10),
            child: HeaderWebPaymentWidget(
              mainTitle: 'Payment Detail',
              showSmallTitle: true,
              smallTitle: 'Payment / Payment Details',
              showBack: true,
              showProfile: true,
              showNotification: true,
              showSettings: true,
              onBackPressed: () {
                context.go('/Payment');
              },
            ),
          ),
          _buildOtherPaymentsTable(context),
        ],
      ),
    );
  }

  /// ------------ Extra Widget -------------- ///

  // Table Main Container
  Widget _buildOtherPaymentsTable(BuildContext context) {
    String customerName = data["customerName"] ?? "Jhon Martin";
    const double tableWidth = 1450.0;

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
                const TextSpan(text: TextString.otherPayment),
                TextSpan(
                  text: " ($customerName)",
                  style: TTextTheme.h2PrimaryStyle(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            TextString.listOfPayment,
            style: TTextTheme.bodyRegular16(context),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: tableWidth,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      _cell(width: 110, child: _headerCell(TextString.regNo, context)),
                      _cell(width: 150, child: _headerCell(TextString.header7payment, context)),
                      _cell(width: 200, child: _headerCell(TextString.duration, context)),
                      _cell(width: 180, child: _headerCell(TextString.header3payment, context)),
                      _cell(width: 110, child: _headerCell(TextString.header4payment, context)),
                      _cell(width: 150, child: _headerCell(TextString.paymentType, context)),
                      _cell(width: 150, child: _headerCell(TextString.previousOverdue, context)),
                      _cell(width: 110, child: _headerCell(TextString.rating, context, isCenter: true)),
                      _cell(width: 130, child: _headerCell(TextString.header5payment, context, isCenter: true, canSort: false)),
                    ],
                  ),
                ),
                Obx(() => Column(
                  children: controller.otherPaymentsListinvoices.map((row) {
                    return SizedBox(
                      width: tableWidth,
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

  // Header Cell
  Widget _headerCell(
      String title,
      BuildContext context, {
        bool isCenter = false,
        bool canSort = true,
      }) {
    return InkWell(
      onTap: canSort ? () => controller.toggleSort3(title) : null,
      child: Row(
        mainAxisAlignment: isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
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
                      color: order == 1
                          ? AppColors.primaryColor
                          : AppColors.quadrantalTextColor,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -9),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 14,
                        color: order == 2
                            ? AppColors.primaryColor
                            : AppColors.quadrantalTextColor,
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

  // Data Mapping Row
  Widget _buildSimplePaymentRow(Map data, BuildContext context) {
    String rawStatus = data["status"] ?? "Pending";

    return Container(
      width: 1450,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundOfTableContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.sideBoxesColor.withValues(alpha: 0.7),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _cell(
            width: 110,
            child: Text(
              data["regNo"] ?? "ABC 1234",
              style: TTextTheme.bodySemiBold14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 150,
            child: Text(
              data["customerName"] ?? "Jhon Martin",
              style: TTextTheme.bodySemiBold14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 200,
            child: Text(
              data["duration"] ?? "Mar 7, 2026 - Mar 14, 2026",
              style: TTextTheme.tableRegular14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 180,
            child: Text(
              data["car"] ?? "Toyota Corolla 2022 Altis",
              style: TTextTheme.tableRegular14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 110,
            child: Text(
              "\$${data["amount"] ?? "245"}",
              style: TTextTheme.bodySemiBold16(context).copyWith(
                color: AppColors.primaryColor,
              ),
            ),
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
            ),
          ),
          _cell(
            width: 150,
            child: Text(
              data["previousOverdue"] ?? "2 Week",
              style: TTextTheme.tableRegular14black(context),
            ),
          ),
          _cell(
            width: 110,
            child: Center(
              child: Text(
                data["rating"] ?? "80%",
                style: TTextTheme.bodySemiBold14black(context).copyWith(
                  color: AppColors.activeColor2,
                ),
              ),
            ),
          ),
          _cell(
            width: 130,
            child: Center(child: _buildStatusChip(rawStatus, context)),
          ),
        ],
      ),
    );
  }
  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }

  // Dynamic Status Chip
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
        backgroundColor = AppColors.tertiaryTextColor;
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
}