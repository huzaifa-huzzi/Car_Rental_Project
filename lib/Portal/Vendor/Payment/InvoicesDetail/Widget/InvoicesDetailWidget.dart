import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/CustomPaymentButton.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/PrimaryBtnOfPayment.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
          _buildPaymentReceiptSection(context),
          const SizedBox(height: 15),
          _buildResubmitReasonSection(context),
          const SizedBox(height: 15),
          _buildResubmitReasonCard(context),
        ],
      ),
    );
  }

  /// ----------- Extra Widgets --------- ///

  // payment info
  Widget _buildPaymentInfoCard(BuildContext context) {
    String getSafe(dynamic value, {String fallback = ""}) {
      return value == null || value.toString().isEmpty
          ? fallback
          : value.toString();
    }

    String status = getSafe(data["status"], fallback: "pending").toLowerCase();

    bool showSubmissionDetails = status == "submitted" ||
        status == "resubmit" ||
        status == "completed";

    bool isResubmit = status == "resubmit";
    bool isMobile = MediaQuery.of(context).size.width < 450;
    String submissionType = getSafe(data["submissionType"], fallback: "OnTime");
    String submissionDate = isResubmit
        ? getSafe(data["resubmitAt"], fallback: getSafe(data["submissionDate"], fallback: "12 March, 2026"))
        : getSafe(data["submissionDate"], fallback: "12 March, 2026");

    String invoiceId = getSafe(data["id"], fallback: "In-2026-004");
    String customerName = getSafe(data["customerName"], fallback: "Adam John");
    String phone = getSafe(data["phone"], fallback: "12345678");
    String amount = getSafe(data["amount"], fallback: "1425");
    String dueDate = getSafe(data["dueDate"], fallback: "12 March, 2026");

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TextString.titlePaymentInvoices, style: TTextTheme.h2Style(context)),
              Text(TextString.titlePaymentAddInvoices, style: TTextTheme.bodyRegular16(context)),
              const SizedBox(height: 12),
              _buildStatusChip(status, context),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.titlePaymentInvoices, style: TTextTheme.h2Style(context)),
                  Text(TextString.titlePaymentAddInvoices, style: TTextTheme.bodyRegular16(context)),
                ],
              ),
              _buildStatusChip(status, context),
            ],
          ),

          const SizedBox(height: 24),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.field1, invoiceId),
            _buildReadOnlyField(context, TextString.field2, customerName),
            _buildReadOnlyField(context, TextString.field3, phone),
          ]),

          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.field4, "\$$amount", isPrice: true),
            _buildReadOnlyField(context, TextString.field5, dueDate),
            if (showSubmissionDetails)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildReadOnlyField(context, TextString.field6, submissionDate),
                  if (submissionType != "OnTime") ...[
                    const SizedBox(height: 4),
                    _buildSubmissionStatusText(context, type: submissionType),
                  ],
                ],
              )
            else
              const SizedBox(),
          ]),
        ],
      ),
    );
  }
  Widget _buildSubmissionStatusText(BuildContext context,
      {required String type}) {
    bool isLate = type == "Late";

    return Text(
      isLate
          ? TextString.before2Days
          : TextString.after2Days,
      style: isLate ? TTextTheme.bodyRegular14Primary(context) : TTextTheme.bodyRegular14Green(context),
    );
  }


   // Image Section
  Widget _buildPaymentReceiptSection(BuildContext context) {

    String status = (data["status"] ?? "").toString().toLowerCase();
    bool shouldShow = status == "submitted" ||
        status == "resubmit" ||
        status == "completed";

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




   // Submitted
  Widget _buildResubmitReasonSection(BuildContext context) {
    final String status = (data["status"] ?? "").toString().toLowerCase();
    if (status != "submitted") return const SizedBox.shrink();
    bool isGapMoreThanTwoDays = false;
    try {
      DateFormat format = DateFormat("dd MMMM, yyyy");
      DateTime dueDate = format.parse(data["dueDate"] ?? "");
      DateTime submissionDate = format.parse(data["submissionDate"] ?? "");

      int diff = submissionDate.difference(dueDate).inDays.abs();
      isGapMoreThanTwoDays = diff >= 2;
    } catch (e) {
      isGapMoreThanTwoDays = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isGapMoreThanTwoDays) ...[
          Text(TextString.reason, style: TTextTheme.bodyRegular14(context)),
          const SizedBox(height: 8),

          Obx(() => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: controller.isReasonFocused.value
                  ? [BoxShadow(color: AppColors.fieldsBackground.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))]
                  : [],
            ),
            child: TextField(
              focusNode: controller.reasonFocusNode,
              maxLines: 4,
              cursorColor: AppColors.blackColor,
              style: TTextTheme.textFieldWrittenText(context),
              decoration: InputDecoration(
                hintText: TextString.writeHere,
                hintStyle: TTextTheme.bodyRegular16(context),
                fillColor: Colors.white,
                filled: true,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: AppColors.toolBackground),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.toolBackground),
                ),
              ),
            ),
          )),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: CustomButtonPayment(
              text: "Request Resubmit",
              width: 180,
              height: 45,
              allowbackgrooundColor: false,
              textColor: AppColors.primaryColor,
              borderColor: AppColors.primaryColor,
              onTap: () => showResubmitConfirmationDialog(context),
            ),
          ),
        ],
        if (isGapMoreThanTwoDays)
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryBtnOfPayment(
              text: "Mark as Complete",
              width: 180,
              height: 45,
              onTap: () => showCompletionDialog(context),
            ),
          ),
      ],
    );
  }

  // ResubmitReasonCard
  Widget _buildResubmitReasonCard(BuildContext context) {
    String status = (data["status"] ?? "").toString().toLowerCase();
    if (status != "resubmit") return const SizedBox.shrink();
    String reason = data["resubmitReason"] ??
        TextString.reasonBox;

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
          Text(
            reason,
            style:TTextTheme.bodyRegular16black(context)
          ),
        ],
      ),
    );
  }

  // Car Detail
  Widget _buildCarDetailCard(BuildContext context) {
    return _buildCard(
      context,
      title: TextString.carDetailInvoices,
      subtitle: TextString.carDetailSubtitleInvoices,
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.carField1,
                data["car"] ?? "Mazda CX-5 (2017)"),
            _buildReadOnlyField(context, TextString.carField4, "Sedan"),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.carField2, "Abc12345"),
            _buildReadOnlyField(context, TextString.carField3, "Automatic"),
          ]),
        ],
      ),
    );
  }

  // car Rental
  Widget _buildRentalCard(BuildContext context) {
    String status = (data["status"] ?? "").toString().toLowerCase();
    bool isSubmitted = status == "submitted";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.RentDetailTitlepayment, style: TTextTheme.h2Style(context)),
          Text(TextString.RentDetailTitleSubtitle, style: TTextTheme.bodyRegular16(context)),

          const SizedBox(height: 24),

          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.rentField1, data["fromDate"] ?? "March 7, 2026"),
            _buildReadOnlyField(context, TextString.rentField2, data["toDate"] ?? "March 14, 2026"),
          ]),

          const SizedBox(height: 16),

          Row(
            children: [
              if (isSubmitted) ...[
                Expanded(
                  child: _buildReadOnlyField(context, TextString.submittedDate, data["submittedDate"] ?? "March 7, 2026"),
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: _buildReadOnlyField(
                  context,
                  TextString.duration,
                  data["duration"] ?? "7 days",
                ),
              ),
            ],
          ),
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
                ? TTextTheme.bodySemiBold16(context) : TTextTheme.bodyRegular16black(context)),
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

  // Simple Dialogs
  void showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool shouldStackButtons = screenWidth < 380;

        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("🤨", style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              TextString.paymentAsCompleted,
                              style: TTextTheme.h2Style(context)
                          ),
                          const SizedBox(height: 6),
                          Text(
                              TextString.paymentAsCompletedSubtitle,
                              style:TTextTheme.bodyRegular16(context)
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
                        child:  Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                shouldStackButtons
                    ? Column(
                  children: [
                    _buildButton(context, "Save", isOutlined: true, isFullWidth: true),
                    const SizedBox(height: 12),
                    _buildButton(context, "Cancel", isOutlined: false, isFullWidth: true),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildButton(context, "Save", isOutlined: true, isFullWidth: false),
                    const SizedBox(width: 12),
                    _buildButton(context, "Cancel", isOutlined: false, isFullWidth: false),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildButton(BuildContext context, String text, {required bool isOutlined, required bool isFullWidth}) {
    return SizedBox(
      width: isFullWidth ? double.infinity : 110,
      height: 48,
      child: isOutlined
          ? OutlinedButton(
        onPressed: (){
          Navigator.pop(context);
          showSuccessDialog(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primaryColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: TTextTheme.resendText(context)),
      )
          : ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style:TTextTheme.btnWhiteColor2(context)),
      ),
    );
  }
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
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
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emojiBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("👍", style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            TextString.markedSuccessFully,
                            style:TTextTheme.h2Style(context),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            TextString.markedSuccessFullySubtitle,
                            style:TTextTheme.bodyRegular16(context)
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
                        child: const Icon(Icons.close, size: 16, color: AppColors.blackColor),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
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

   // Resubmit Dialog
  void showResubmitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool shouldStackButtons = screenWidth < 380;

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
                        child: const Text("🤨", style: TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TextString.paymentAsCompletedinvoices,
                              style: TTextTheme.h2Style(context),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              TextString.paymentAsCompletedSubtitleInvoices,
                              style: TTextTheme.bodyRegular16(context),
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
                  const SizedBox(height: 32),
                  // Buttons Section
                  shouldStackButtons
                      ? Column(
                    children: [
                      _buildResubmitButton(context, "Save", isOutlined: true, isFullWidth: true),
                      const SizedBox(height: 12),
                      _buildResubmitButton(context, "Cancel", isOutlined: false, isFullWidth: true),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildResubmitButton(context, "Save", isOutlined: true, isFullWidth: false),
                      const SizedBox(width: 12),
                      _buildResubmitButton(context, "Cancel", isOutlined: false, isFullWidth: false),
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
  Widget _buildResubmitButton(BuildContext context, String text, {required bool isOutlined, required bool isFullWidth}) {
    const Color resubmitRed = AppColors.primaryColor;

    return SizedBox(
      width: isFullWidth ? double.infinity : 110,
      height: 48,
      child: isOutlined
          ? OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
          showResubmitSuccessDialog(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: resubmitRed, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: TTextTheme.resendText(context).copyWith(color: resubmitRed)),
      )
          : ElevatedButton(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: resubmitRed,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: TTextTheme.btnWhiteColor2(context)),
      ),
    );
  }
  void showResubmitSuccessDialog(BuildContext context) {
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
                        child: const Text("👍", style: TextStyle(fontSize: 24)),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                TextString.markedSuccessFullyInvoices,
                                style: TTextTheme.h2Style(context)
                            ),
                            const SizedBox(height: 8),
                            Text(
                                TextString.markedSuccessFullySubtitleInvoices,
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
