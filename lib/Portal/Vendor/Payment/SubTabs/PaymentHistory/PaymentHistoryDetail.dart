import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';



class PaymentHistoryDetail extends StatelessWidget {
  final Map<String, dynamic> data;

  const PaymentHistoryDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 900;
    String status = (data["paymentStatus"] ?? data["status"] ?? "pending")
        .toString()
        .trim()
        .toLowerCase();

    final controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWebPaymentWidget(
              showBack: true,
              onBackPressed: () {
                context.go('/PaymentHistory');
              },
              showSmallTitle: true,
              smallTitle: TextString.paymentDetailsPath,
              mainTitle: TextString.paymentDetail,
              showSettings: true,
              showNotification: true,
              showProfile: true,
            ),

            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 12 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPaymentInfoCard(context, status),

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
                  if (status == "completed") ...[
                    const SizedBox(height: 20),
                    _buildPaymentReceiptSection(context, controller),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------ Extra Widget ------------------- ///

  // Payment Info Card
  Widget _buildPaymentInfoCard(BuildContext context, String currentStatus) {
    String invoiceId = data["id"] ?? "In-2026-004";
    String fromDate = data["fromDate"] ?? "March 7, 2026";
    String toDate = data["toDate"] ?? "March 14, 2026";
    String amount = data["amount"] ?? "1425";
    String dueDate = data["dueDate"] ?? "12 March, 2026";
    bool isCompleted = currentStatus == "completed";
    String submissionDate = isCompleted
        ? (data["submissionDate"] ?? data["paidDate"] ?? "12 March, 2026")
        : "-";
    String subNote = data["subNote"] ?? TextString.defaultSubNote;

    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
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
              Text(TextString.paymentInformation, style: TTextTheme.h2Style(context)),
              const SizedBox(height: 2),
              Text(TextString.allDetailsAboutPayment, style: TTextTheme.bodyRegular16(context)),
              const SizedBox(height: 12),
              _buildStatusChip(currentStatus, context),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.paymentInformation, style: TTextTheme.h2Style(context)),
                  const SizedBox(height: 2),
                  Text(TextString.allDetailsAboutPayment, style: TTextTheme.bodyRegular16(context)),
                ],
              ),
              _buildStatusChip(currentStatus, context),
            ],
          ),
          const SizedBox(height: 24),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.invoiceId, invoiceId),
            _buildReadOnlyField(context, TextString.fromDate, fromDate),
            _buildReadOnlyField(context, TextString.toDate, toDate),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.paymentAmount, "\$$amount", isPrice: true),
            _buildReadOnlyField(context, TextString.dueDate, dueDate),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildReadOnlyField(context, TextString.submissionDate, submissionDate),
                if (isCompleted) ...[
                  const SizedBox(height: 4),
                  Text(
                    subNote,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.activeColor2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ]),
        ],
      ),
    );
  }

  // Car Detail Card
  Widget _buildCarDetailCard(BuildContext context) {
    return _buildCard(
      context,
      title: TextString.carDetail,
      subtitle: TextString.carDetailSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.carName, data["carName"] ?? data["car"] ?? "Mazda CX-5(2017)"),
            _buildReadOnlyField(context, TextString.type, data["carType"] ?? "Sedan"),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.registration, data["registration"] ?? data["regNo"] ?? TextString.defaultRegistration),
            _buildReadOnlyField(context, TextString.transmission, data["transmission"] ?? "Automatic"),
          ]),
        ],
      ),
    );
  }

  // Customer Detail card
  Widget _buildCustomerDetailCard(BuildContext context) {
    return _buildCard(
      context,
      title: TextString.customerDetail,
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

  // Receipt Section
  Widget _buildPaymentReceiptSection(BuildContext context, PaymentController controller) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
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
              Text(TextString.screenShot, style: TTextTheme.h2Style(context)),
              const SizedBox(height: 2),
              Text(TextString.screenShotHere, style: TTextTheme.bodyRegular16(context)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    TextString.downloadReceipt,
                    style: TTextTheme.bodyRegular14(context).copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TextString.screenShot, style: TTextTheme.h2Style(context)),
                  const SizedBox(height: 2),
                  Text(TextString.screenShotHere, style: TTextTheme.bodyRegular16(context)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  TextString.downloadReceipt,
                  style: TTextTheme.bodyRegular14(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: AppColors.backgroundOfPickupsWidget,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: isMobile ? 260 : 300,
                    height: 350,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
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
                    width: isMobile ? 260 : 300,
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

  // Build Card
  Widget _buildCard(BuildContext context, {required String title, required String subtitle, required Widget child}) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
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

  // Read Only Field
  Widget _buildReadOnlyField(BuildContext context, String label, String value, {bool isPrice = false}) {
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

  // Responsive Row
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

  // Status Chip
  Widget _buildStatusChip(String status, BuildContext context) {
    Color backgroundColor;
    String displayStatus = status;

    switch (status.toLowerCase().trim()) {
      case 'completed':
        backgroundColor = AppColors.completedColor;
        displayStatus = TextString.statusCompleted;
        break;
      case 'overdue':
        backgroundColor = AppColors.overdueColor;
        displayStatus = TextString.statusOverdue;
        break;
      case 'pending':
        backgroundColor = AppColors.pendingColor;
        displayStatus = TextString.statusPending;
        break;
      default:
        backgroundColor = AppColors.activeColor2;
        displayStatus = status.isNotEmpty ? "${status[0].toUpperCase()}${status.substring(1)}" : "";
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
}
