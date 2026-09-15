import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/CustomPaymentButton.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Resources/Colors.dart' show AppColors;



class InvoicesDetailWidget extends StatelessWidget {
  final Map data;
  InvoicesDetailWidget({super.key, required this.data});

  final controller = Get.find<PaymentController>();

  final RxBool isWriteReasonVisible = false.obs;
  final TextEditingController reasonTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 900;
    String status = (data["status"] ?? "").toString().toLowerCase();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPaymentInfoCard(context),

          const SizedBox(height: 20),
          isWeb
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildCarDetailCard(context)),
              const SizedBox(width: 20),
              Expanded(child: _buildCustomerDetailCard(context)),
            ],
          )
              : Column(
            children: [
              _buildCarDetailCard(context),
              const SizedBox(height: 20),
              _buildCustomerDetailCard(context),
            ],
          ),
          if (status == "failed") ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () {
                  isWriteReasonVisible.value = !isWriteReasonVisible.value;
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.6)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text(
                  TextString.requestToUpdateCard,
                  style: TTextTheme.bodyRegular14(context).copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
          if (status == "failed") ...[
            const SizedBox(height: 20),
            _buildFailedReasonSection(context),
            Obx(() => isWriteReasonVisible.value
                ? Column(
              children: [
                const SizedBox(height: 20),
                _buildWriteReasonSection(context),
              ],
            )
                : const SizedBox.shrink()),
          ],

          const SizedBox(height: 20),
          if (status != "failed" && status != "completed" && status != "submitted") ...[
            Align(
              alignment: Alignment.centerRight,
              child: PrimaryBtnOfPayment(
                text: TextString.markAsComplete,
                width: 180,
                height: 45,
                onTap: () => showCompletionDialog(context),
              ),
            ),
            const SizedBox(height: 20),
          ],

          _buildOtherPaymentsTable(context),

          const SizedBox(height: 20),

          _buildPaymentReceiptSection(context),
          const SizedBox(height: 15),
          if (status != "submitted") ...[
            const SizedBox(height: 15),
            _buildResubmitReasonSection(context),
            const SizedBox(height: 15),
            _buildResubmitReasonCard(context),
          ],
        ],
      ),
    );
  }


  /// ---------------- Extra Widget ---------------------- ///

   // Custom Dialog
  void _buildCustomDialog({
    required BuildContext context,
    required String emoji,
    required String title,
    required String subtitle,
    bool isConfirmation = false,
    VoidCallback? onSave,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isSmallScreen = screenWidth < 360;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(dialogContext).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.quadrantalTextColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.tertiaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: isSmallScreen ? 40 : 48,
                        height: isSmallScreen ? 40 : 48,
                        decoration: BoxDecoration(
                          color: AppColors.emojiBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            emoji,
                            style: TextStyle(fontSize: isSmallScreen ? 18 : 22),
                          ),
                        ),
                      ),
                      SizedBox(width: isSmallScreen ? 12 : 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TTextTheme.h13Style(dialogContext),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              subtitle,
                              style: TTextTheme.staffSuccessDialogSubtitle(dialogContext),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (isConfirmation) ...[
                    SizedBox(height: isSmallScreen ? 18 : 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final buttonWidth = (constraints.maxWidth - 12) / 2;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: buttonWidth,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: AppColors.primaryColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                  if (onSave != null) onSave();
                                },
                                child: Text(
                                  TextString.save,
                                  style: TTextTheme.btnSavePrimary(dialogContext),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: buttonWidth,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                child: Text(
                                  TextString.cancel,
                                  style: TTextTheme.btnSave(dialogContext),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Dialogs
  void showResubmitConfirmationDialog(BuildContext context, {String? invoiceId}) {
    final String id = invoiceId ?? "In-2026-004";
    _buildCustomDialog(
      context: context,
      emoji: "🤨",
      title: TextString.resubmitTitle,
      subtitle: TextString.resubmitSubTitle(id),
      isConfirmation: true,
      onSave: () => showResubmitSuccessDialog(context),
    );
  }
  void showResubmitSuccessDialog(BuildContext context) {
    _buildCustomDialog(
      context: context,
      emoji: "👍",
      title: TextString.resubmitSuccessTitle,
      subtitle: TextString.resubmitSuccessSubTitle,
      isConfirmation: false,
    );
  }
  void showCompletionDialog(BuildContext context, {String? invoiceId}) {
    final String id = invoiceId ?? "In-2026-004";
    _buildCustomDialog(
      context: context,
      emoji: "🤨",
      title: TextString.completionTitle,
      subtitle: TextString.completionSubTitle(id),
      isConfirmation: true,
      onSave: () => showCompletionSuccessDialog(context),
    );
  }
  void showCompletionSuccessDialog(BuildContext context) {
    _buildCustomDialog(
      context: context,
      emoji: "👍",
      title: TextString.completionSuccessTitle,
      subtitle: TextString.completionSuccessSubTitle,
      isConfirmation: false,
    );
  }

  /// ---------- Extra Widget ----------------- ///

  Widget _buildPaymentInfoCard(BuildContext context) {
    String status = (data["status"] ?? "overdue").toString().toLowerCase();
    String invoiceId = data["id"] ?? "In-2026-004";
    String fromDate = data["fromDate"] ?? "March 7,2026";
    String toDate = data["toDate"] ?? "March 14,2026";
    String amount = data["amount"] ?? "1425";
    String dueDate = data["dueDate"] ?? "12 March, 2026";

    bool isMobile = MediaQuery.of(context).size.width < 500;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.paymentInfoTitle, style: TTextTheme.h2Style(context)),
                  const SizedBox(height: 2),
                  Text(TextString.paymentInfoSubtitle, style: TTextTheme.bodyRegular16(context)),
                ],
              ),
              _buildStatusChip(status, context),
            ],
          ),
          const SizedBox(height: 24),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.invoiceId, invoiceId),
            _buildReadOnlyField(context, TextString.fromDate, fromDate),
            if (!isMobile) _buildReadOnlyField(context, TextString.toDate, toDate),
          ]),
          if (isMobile) ...[
            const SizedBox(height: 16),
            _buildReadOnlyField(context, TextString.toDate, toDate),
          ],
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.paymentAmount, "\$$amount", isPrice: true),
            _buildReadOnlyField(context, TextString.dueDate, dueDate),
            if (!isMobile) const SizedBox(),
          ]),
        ],
      ),
    );
  }

  Widget _buildCarDetailCard(BuildContext context) {
    return _buildCard(
      context,
      title: TextString.carDetailTitle,
      subtitle: TextString.carDetailSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.carName, data["car"] ?? "Mazda CX-5 (2017)"),
            _buildReadOnlyField(context, TextString.type, data["carType"] ?? "Sedan"),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.registration, data["regNo"] ?? "ABC 1234"),
            _buildReadOnlyField(context, TextString.transmission, data["transmission"] ?? "Automatic"),
          ]),
        ],
      ),
    );
  }

  Widget _buildCustomerDetailCard(BuildContext context) {
    return _buildCard(
      context,
      title: TextString.customerDetailTitle,
      subtitle: TextString.customerDetailSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.customerName, data["customerName"] ?? "Adam Jhones"),
            _buildReadOnlyField(context, TextString.phoneNumber, data["phone"] ?? "+61430042030"),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.email, data["email"] ?? "adam@gmail.com"),
            _buildReadOnlyField(context, TextString.licenseNumber, data["licenseNo"] ?? "#12345667"),
          ]),
        ],
      ),
    );
  }

  Widget _buildFailedReasonSection(BuildContext context) {
    String defaultReason =
         TextString.failedText;
    String reasonText = data["failedReason"] ?? defaultReason;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.reasonForRequest,
            style: TTextTheme.h2Style(context).copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            reasonText,
            style: TTextTheme.bodyRegular16black(context).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildWriteReasonSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TextString.writeReason,
          style: TTextTheme.bodySemiBold14black(context),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.sideBoxesColor.withValues(alpha: 0.7)),
          ),
          child: TextField(
            cursorColor: AppColors.textColor,
            controller: reasonTextController,
            maxLines: 4,
            style: TTextTheme.bodyRegular14(context),
            decoration: InputDecoration(
              hintText: TextString.writeHere,
              hintStyle: TTextTheme.bodyRegular14(context).copyWith(
                color: AppColors.tertiaryTextColor,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            onPressed: () => showResubmitConfirmationDialog(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.6)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              TextString.requestResubmit,
              style: TTextTheme.bodyRegular14(context).copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherPaymentsTable(BuildContext context) {
    String customerName = data["customerName"] ?? "Adam Jhones";
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
                padding: const EdgeInsets.only(top: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      size: 13,
                      color: order == 1 ? AppColors.primaryColor : AppColors.quadrantalTextColor,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -7),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 13,
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

  Widget _buildSimplePaymentRow(Map rowData, BuildContext context) {
    String currentTabStatus = controller.selectedTab.value;
    String rawStatus = (currentTabStatus.isNotEmpty && currentTabStatus != "All")
        ? currentTabStatus
        : (rowData["status"] ?? "Pending");

    return Container(
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
              rowData["regNo"] ?? "ABC 1234",
              style: TTextTheme.bodySemiBold14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 150,
            child: Text(
              rowData["customerName"] ?? "Jhon Martin",
              style: TTextTheme.bodySemiBold14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 200,
            child: Text(
              rowData["duration"] ?? "Mar 7, 2026 - Mar 14, 2026",
              style: TTextTheme.tableRegular14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 180,
            child: Text(
              rowData["car"] ?? "Toyota Corolla 2022 Altis",
              style: TTextTheme.tableRegular14black(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _cell(
            width: 110,
            child: Text(
              "\$${rowData["amount"] ?? "245"}",
              style: TTextTheme.bodySemiBold16(context).copyWith(color: AppColors.primaryColor),
            ),
          ),
          _cell(
            width: 150,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (rowData["paymentTypeIcon"] != null) ...[
                  Image.asset(rowData["paymentTypeIcon"], width: 16, height: 16),
                  const SizedBox(width: 6),
                ],
                Flexible(
                  child: Text(
                    rowData["paymentType"] ?? "Pay to",
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
              rowData["previousOverdue"] ?? "2 Week",
              style: TTextTheme.tableRegular14black(context),
            ),
          ),
          _cell(
            width: 110,
            child: Center(
              child: Text(
                rowData["rating"] ?? "80%",
                style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.activeColor2),
              ),
            ),
          ),
          _cell(
            width: 130,
            child: Center(
              child: _buildStatusChip(rawStatus, context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cell({required double width, required Widget child}) {
    return SizedBox(width: width, child: child);
  }

  Widget _buildCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required Widget child,
      }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text(subtitle, style: TTextTheme.bodyRegular16(context)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildReadOnlyField(
      BuildContext context,
      String label,
      String value, {
        bool isPrice = false,
      }) {
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
                ? TTextTheme.bodySemiBold16(context).copyWith(color: AppColors.primaryColor)
                : TTextTheme.bodyRegular16black(context),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveRow(BuildContext context, List<Widget> children) {
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
          padding: const EdgeInsets.only(right: 12),
          child: e,
        ),
      ))
          .toList(),
    );
  }

  Widget _buildStatusChip(String status, BuildContext context) {
    Color backgroundColor;
    String displayStatus = status;

    switch (status.toLowerCase()) {
      case 'all':
        backgroundColor = AppColors.quadrantalTextColor;
        displayStatus = "All";
        break;
      case 'overdue':
        backgroundColor = AppColors.overdueColor;
        displayStatus = "Overdue";
        break;
      case 'pending':
        backgroundColor = AppColors.pendingColor;
        displayStatus = "Pending";
        break;
      case 'completed':
        backgroundColor = AppColors.completedColor;
        displayStatus = "Completed";
        break;
      case 'resubmit':
        backgroundColor = AppColors.reviewColor;
        displayStatus = "Resubmit";
        break;
      case 'submitted':
        backgroundColor = AppColors.textColor;
        displayStatus = "Submitted";
        break;
      case 'failed':
        backgroundColor = AppColors.primaryColor;
        displayStatus = "Failed";
        break;
      default:
        backgroundColor = AppColors.tertiaryTextColor;
        displayStatus = status.isNotEmpty
            ? "${status[0].toUpperCase()}${status.substring(1)}"
            : "";
    }

    return Container(
      constraints: const BoxConstraints(minWidth: 85),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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

  Widget _buildPaymentReceiptSection(BuildContext context) {
    String status = (data["status"] ?? "").toString().toLowerCase();
    bool shouldShow = status == "submitted" || status == "resubmit" || status == "completed";

    if (!shouldShow) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.fieldUploadInvoices, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text(TextString.fieldUploadSubtitleInvoices, style: TTextTheme.bodyRegular16(context)),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfPickupsWidget,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 350,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.white,
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
                              child: Image.asset(
                                ImageString.receipt,
                                fit: BoxFit.contain,
                              ),
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
                                      color: Colors.black.withValues(alpha: 0.5),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.zoom_in_outlined,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(IconString.receiptIcon, height: 20),
                          const SizedBox(width: 8),
                          Text(
                            TextString.receipt,
                            style: TTextTheme.bodyRegular12black(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
            Flexible(
              child: InteractiveViewer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(ImageString.receipt, fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResubmitReasonSection(BuildContext context) {
    final String status = (data["status"] ?? "").toString().toLowerCase();

    if (status == "submitted" || status != "resubmit") {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.reason, style: TTextTheme.bodyRegular14(context)),
        const SizedBox(height: 8),
        TextField(
          focusNode: controller.reasonFocusNode,
          maxLines: 4,
          cursorColor: AppColors.blackColor,
          style: TTextTheme.textFieldWrittenText(context),
          decoration: InputDecoration(
            hintText: TextString.writeHere,
            hintStyle: TTextTheme.bodyRegular16(context),
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.toolBackground),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: CustomButtonPayment(
            text: TextString.requestResubmit,
            width: 180,
            height: 45,
            allowbackgrooundColor: false,
            textColor: AppColors.primaryColor,
            borderColor: AppColors.primaryColor,
            onTap: () => showResubmitConfirmationDialog(context),
          ),
        ),
      ],
    );
  }
  Widget _buildResubmitReasonCard(BuildContext context) {
    String status = (data["status"] ?? "").toString().toLowerCase();
    if (status == "submitted" || status != "resubmit") {
      return const SizedBox.shrink();
    }

    String reason = data["resubmitReason"] ?? TextString.reasonBox;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextString.reasonOfResubmit,
            style: TTextTheme.h2PrimaryStyle(context),
          ),
          const SizedBox(height: 12),
          Text(reason, style: TTextTheme.bodyRegular16black(context)),
        ],
      ),
    );
  }
}