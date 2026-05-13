import 'package:car_rental_project/Portal/Vendor/Payment/ReusableWidget/HeaderWebPaymentWidget.dart';
import 'package:car_rental_project/Portal/Vendor/Payment/paymentController.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicesDetailAutoWidget extends StatelessWidget {
  final Map invoiceData;
  const InvoicesDetailAutoWidget({super.key, required this.invoiceData});

  @override
  Widget build(BuildContext context) {
    final isWeb = AppSizes.isWeb(context);
    final isTab = AppSizes.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWebPaymentWidget(
                  mainTitle: 'Payment',
                  showSmallTitle: true,
                  smallTitle: 'Payment / Payment Detail',
                  showProfile: isWeb || isTab,
                  showNotification: true,
                  showSettings: true,
                  showBack: true,
                ),
                const SizedBox(height: 40),
                InvoicesDetailWidget2(data: invoiceData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InvoicesDetailWidget2 extends StatelessWidget {
  final Map data;
  InvoicesDetailWidget2({super.key, required this.data});

  final controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 900;

    return Column(
      children: [
        _buildPaymentInfoCard(context),
        const SizedBox(height: 20),

        isWeb
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 40),
      ],
    );
  }

   /// -------- Extra Widget ------ ///
  //  Payment Information
  Widget _buildPaymentInfoCard(BuildContext context) {
    String status = (data["status"] ?? "Pending").toString();

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
                  Text(TextString.autoPaymentTitle, style: TTextTheme.h2Style(context)),
                  Text(TextString.autoPaymentSubtitle, style: TTextTheme.bodyRegular16(context)),
                ],
              ),
              _buildStatusChip(status, context),
            ],
          ),
          const SizedBox(height: 32),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.autoPaymentTitle1, data["id"] ?? "In-2026-004"),
            _buildReadOnlyField(context,TextString.autoPaymentTitle2 , data["customerName"] ?? "Adam Jhon"),
            _buildReadOnlyField(context, "Phone Number", data["phone"] ?? "12345667"),
          ]),
          const SizedBox(height: 20),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context,TextString.autoPaymentTitle3 , data["source"] ?? "Stripe"),
            _buildReadOnlyField(context,TextString.autoPaymentTitle4 , "\$${data["amount"] ?? "1425"}", isPrice: true),
            _buildReadOnlyField(context,TextString.autoPaymentTitle5 , data["dueDate"] ?? "12 March, 2026"),
          ]),
        ],
      ),
    );
  }

   // Car Detail Card
  Widget _buildCarDetailCard(BuildContext context) {
    return _buildBaseCard(
      context,
      title: TextString.autoDetailTitle,
      subtitle: TextString.autoDetailSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context, TextString.autoDetailTitle1, data["car"] ?? "Mazada CX-5(2017)"),
            _buildReadOnlyField(context, TextString.autoDetailTitle2, "Sedan"),
          ]),
          const SizedBox(height: 16),
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context,TextString.autoDetailTitle3 , "1234567890"),
            _buildReadOnlyField(context,TextString.autoDetailTitle4, "Automatic"),
          ]),
        ],
      ),
    );
  }

  Widget _buildRentalCard(BuildContext context) {
    return _buildBaseCard(
      context,
      title: TextString.autoRentalDetailTitle,
      subtitle: TextString.autoRentalDetailSubtitle,
      child: Column(
        children: [
          _buildResponsiveRow(context, [
            _buildReadOnlyField(context,TextString.fromDate, data["fromDate"] ?? "March 7, 2026"),
            _buildReadOnlyField(context, TextString.toDate, data["toDate"] ?? "March 14, 2026"),
          ]),
          const SizedBox(height: 16),
          _buildReadOnlyField(context, TextString.duration2, data["duration"] ?? "7 days"),
        ],
      ),
    );
  }
  Widget _buildBaseCard(BuildContext context, {required String title, required String subtitle, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TTextTheme.h2Style(context)),
          Text(subtitle, style: TTextTheme.bodyRegular16(context)),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
  Widget _buildReadOnlyField(BuildContext context, String label, String value, {bool isPrice = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.bodyRegular12(context)),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground.withOpacity(0.5)),
          ),
          child: Text(
            value,
            style: isPrice
                ? TTextTheme.bodySemiBold16(context).copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold)
                : TTextTheme.bodyRegular16black(context),
          ),
        ),
      ],
    );
  }
  Widget _buildResponsiveRow(BuildContext context, List<Widget> children) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) {
      return Column(children: children.map((c) => Padding(padding: const EdgeInsets.only(bottom: 16), child: c)).toList());
    }
    return Row(children: children.map((c) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: c))).toList());
  }
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