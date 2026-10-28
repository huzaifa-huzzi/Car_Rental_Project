import 'package:car_rental_project/Portal/Vendor/Invoice/InvoiceController.dart';
import 'package:car_rental_project/Portal/Vendor/Invoice/ReusableWidget/HeaderWebInvoiceWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Resources/Colors.dart' show AppColors;
import '../../../../Resources/IconStrings.dart' show IconString;
import 'package:go_router/go_router.dart';

class InvoiceDetailScreen extends StatefulWidget {
  const InvoiceDetailScreen({super.key});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  final InvoiceController controller = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    final bool isWeb = AppSizes.isWeb(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.horizontalPadding(context),
            vertical: isWeb ? 24.0 : 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, top: 10),
                child: HeaderWebInvoiceWidget(
                  mainTitle: TextString.invoiceDetailTitle,
                  smallTitle: TextString.invoiceDetailSmallTitle,
                  showSmallTitle: true,
                  showBack: true,
                  showProfile: true,
                  showNotification: true,
                  showSettings: true,
                ),
              ),

              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  bool isDesktop = constraints.maxWidth >= 1024;
                  return isDesktop
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 7,
                        child: _buildInvoiceSlipCard(context),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 4,
                        child: _buildActionButtonsCard(context),
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      _buildInvoiceSlipCard(context),
                      const SizedBox(height: 20),
                      _buildActionButtonsCard(context),
                    ],
                  );
                },
              ),
              SizedBox(height: isWeb ? 60.0 : 40.0),
            ],
          ),
        ),
      ),
    );
  }

  /// ----------- Extra Widget --------------- ///

  // Invoice Slip Card
  Widget _buildInvoiceSlipCard(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSmallScreen
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(IconString.symbol, height: 20, width: 20),
                  const SizedBox(width: 8),
                  Text(
                    TextString.brandName,
                    style: TTextTheme.h2Style(context).copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                TextString.taxInvoiceLabel,
                style: TTextTheme.h2Style(context).copyWith(fontSize: 16, letterSpacing: 0.5),
              ),
              const SizedBox(height: 4),
              Text(TextString.invoiceDate, style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.fieldsBackground)),
              Text(TextString.invoiceNo, style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.fieldsBackground)),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryColor, width: 6),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    TextString.brandName,
                    style: TTextTheme.h2Style(context).copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    TextString.taxInvoiceLabel,
                    style: TTextTheme.h2Style(context).copyWith(fontSize: 18, letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(TextString.invoiceDate, style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.secondTextColor)),
                      const SizedBox(width: 12),
                      Text(TextString.invoiceNo, style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.secondTextColor)),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            TextString.originalForRecipient,
            style: TTextTheme.bodyRegular12(context).copyWith(color: AppColors.secondTextColor),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: AppColors.fieldsBackground, height: 1),
          ),
          isSmallScreen
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddressSection(context, TextString.invoiceTo, TextString.invoiceToName, TextString.invoiceToAddress),
              const SizedBox(height: 16),
              _buildAddressSection(context, TextString.payTo, TextString.payToName, TextString.payToAddress),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildAddressSection(context, TextString.invoiceTo, TextString.invoiceToName, TextString.invoiceToAddress),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAddressSection(context, TextString.payTo, TextString.payToName, TextString.payToAddress),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.fieldsBackground, height: 1),
          ),
          isSmallScreen
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVehicleSection(context),
              const SizedBox(height: 16),
              _buildDateSection(context),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildVehicleSection(context)),
              const SizedBox(width: 12),
              Expanded(child: _buildDateSection(context)),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: AppColors.fieldsBackground, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(TextString.descriptionHeader, style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.secondTextColor)),
                    const SizedBox(height: 8),
                    Text(
                      TextString.descriptionValue,
                      style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(TextString.amountHeaderLabel, style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.secondTextColor)),
                  const SizedBox(height: 8),
                  Text(
                    TextString.amountValue,
                    style: TTextTheme.bodySemiBold16(context).copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Address Section
  Widget _buildAddressSection(BuildContext context, String title, String name, String details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.secondTextColor)),
        const SizedBox(height: 6),
        Text(name, style: TTextTheme.bodySemiBold14black(context)),
        const SizedBox(height: 4),
        Text(
          details,
          style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.black87),
        ),
      ],
    );
  }

  // Vehicle Section
  Widget _buildVehicleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.vehicleHeader, style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.secondTextColor)),
        const SizedBox(height: 6),
        Text(TextString.vehicleModel, style: TTextTheme.bodySemiBold14black(context)),
        const SizedBox(height: 4),
        Text(
          TextString.vehicleReg,
          style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildDateSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.dateHeaderLabel, style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.secondTextColor)),
        const SizedBox(height: 6),
        Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(TextString.pickUpDateLabel, style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.secondTextColor)),
            ),
            Text(TextString.pickUpDateValue, style: TTextTheme.bodySemiBold14black(context)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(TextString.returnDateLabel, style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.secondTextColor)),
            ),
            Text(TextString.returnDateValue, style: TTextTheme.bodySemiBold14black(context)),
          ],
        ),
      ],
    );
  }

  // ActionButton
  Widget _buildActionButtonsCard(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            TextString.previewNotice,
            style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.secondTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                TextString.editDraft,
                style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                TextString.finalizeInvoice,
                style: TTextTheme.bodySemiBold14White(context),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                TextString.printAction,
                style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                TextString.downloadPdf,
                style: TTextTheme.bodySemiBold14black(context).copyWith(color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}