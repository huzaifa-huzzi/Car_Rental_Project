import 'package:car_rental_project/Portal/Vendor/Billing/BillingController.dart';
import 'package:car_rental_project/Portal/Vendor/Billing/ResuableWidget/HeaderWebBillingWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillingDetailScreen extends StatelessWidget {
  BillingDetailScreen({super.key});

  final controller = Get.put(BillingController());

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = AppSizes.horizontalPadding(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundOfScreenColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppSizes.isWeb(context)) ...[
                HeaderWebBillingWidget(
                  mainTitle: 'Billing',
                  showSmallTitle: true,
                  smallTitle: 'Billing/Billing Details',
                  showProfile: true,
                  showBack: true,
                  showNotification: true,
                  showSettings: true,
                  showSearch: true,
                ),
                const SizedBox(height: 24),
              ],
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.005),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth > 850 ? 40 : (screenWidth < 360 ? 12 : 20),
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.completedColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:  Text(
                              "Paid",
                              style: TTextTheme.btnWhiteColor(context),
                            ),
                          ),
                          _buildActionBtn(context, text: "Download PDF", icon: IconString.billingPdf),
                          _buildActionBtn(context, text: "Send Email", icon: IconString.billingEmail),
                          _buildActionBtn(context, text: "Print", icon: IconString.printIcon),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildBrandVsInvoiceDetails(context, screenWidth),
                    const SizedBox(height: 24),

                     Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
                    const SizedBox(height: 20),
                    const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground ),
                    const SizedBox(height: 32),

                    _buildPartiesAddressGrid(context, screenWidth),
                    const SizedBox(height: 32),

                    const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
                    const SizedBox(height: 32),

                    _buildPricingAndSummaryBox(context, screenWidth),
                    const SizedBox(height: 40),

                    _buildPaymentAndFooterSection(context, screenWidth),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

   /// --------- Extra Widget - -------- ///
  // 1. BRAND DETAILS
  Widget _buildBrandVsInvoiceDetails(BuildContext context, double screenWidth) {
    final brandBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(IconString.symbol),
            const SizedBox(width: 8),
            Text(
              "SoftSnip",
              style:  TTextTheme.h6Style(context),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          "Original For Recipient",
          style: TTextTheme.medium12quadrantal(context)
        ),
      ],
    );

    final taxInvoiceDetailsBlock = Column(
      crossAxisAlignment: screenWidth > 750 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "TAX INVOICE",
          style: TTextTheme.h2Style(context)
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 14,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Date: ",
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
                Text(
                  "05/12/2024",
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color:  AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Invoice No: ",
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color:  AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
                Text(
                  "INV 00001",
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color:  AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
              ],
            ),
          ],
        ),
      ],
    );

    if (screenWidth > 750) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [brandBlock, taxInvoiceDetailsBlock],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          brandBlock,
          const SizedBox(height: 24),
          taxInvoiceDetailsBlock,
        ],
      );
    }
  }

  Widget _buildActionBtn(BuildContext context, {required String text, required String icon}) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(icon,color: AppColors.blackColor,),
      label: Text(
        text,
        style: TTextTheme.medium12(context),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        side:  BorderSide(color: AppColors.signaturePadColor, width: 1),
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  // parent Address Grid
  Widget _buildPartiesAddressGrid(BuildContext context, double screenWidth) {
    final targetInvoiceTo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Invoice To :",
          style: TTextTheme.titleDriver(context),
        ),
        const SizedBox(height: 8),
        Text(
          "Walter Roberson",
          style: TTextTheme.bodyRegular14(context),
        ),
        const SizedBox(height: 4),
        Text(
          "92 the Avenue, Alexander Heights 6064.",
          style: TTextTheme.bodyRegular14(context),
        ),
      ],
    );

    final targetPayTo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pay To :",
          style: TTextTheme.titleDriver(context)),
        const SizedBox(height: 8),
        Text(
          "Lowell H. Dominguez",
          style: TTextTheme.bodyRegular14(context),
        ),
        const SizedBox(height: 4),
        Text(
          "84 Spilman Street, London United Kingdom\ndomlowell@gmail.com",
          style: TTextTheme.bodyRegular14(context),
        ),
      ],
    );

    if (screenWidth > 650) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: targetInvoiceTo),
          const SizedBox(width: 48),
          Expanded(child: targetPayTo),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          targetInvoiceTo,
          const SizedBox(height: 28),
          targetPayTo,
        ],
      );
    }
  }

  // 4. PRICING TABLE BOX
  Widget _buildPricingAndSummaryBox(BuildContext context, double screenWidth) {
    final isDesktop = screenWidth > 768;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.toolBackground, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.backgroundOfScreenColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text("Item", style: TTextTheme.medium12(context)),
                Text("Price", style: TTextTheme.medium12(context)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("Active Vehicle", style: TTextTheme.tableRegular14black(context)),
                      SizedBox(height: 6),
                      Text("Rate per Car", style: TTextTheme.tableRegular14black(context)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text("20.00", style: TTextTheme.medium14black(context)),
                    SizedBox(height: 6),
                    Text(r"$8.00", style: TTextTheme.medium14black(context)),
                  ],
                ),
              ],
            ),
          ),
           Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
          Padding(
            padding: const EdgeInsets.all(16),
            child: isDesktop
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _buildImportantNote(context)),
                const SizedBox(width: 40),
                Expanded(flex: 4, child: _buildTaxCalculations(context)),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImportantNote(context),
                const SizedBox(height: 24),
                _buildTaxCalculations(context),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color:AppColors.backgroundOfScreenColor,
            child: screenWidth > 400
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  "Total Items / Qty : 4 / 4.00",
                  style: TTextTheme.bodyRegular14(context),
                ),
                Row(
                  children:  [
                    Text("Total", style: TTextTheme.tableSemiBold18Black(context)),
                    SizedBox(width: 24),
                    Text(r"$180.00", style: TTextTheme.tableSemiBold18Black(context)),
                  ],
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Text(
                  "Total Items / Qty : 4 / 4.00",
                  style: TTextTheme.bodyRegular14(context),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text("Total", style: TTextTheme.tableSemiBold18Black(context)),
                    Text(r"$180.00", style: TTextTheme.tableSemiBold18Black(context)),
                  ],
                ),
              ],
            ),
          ),
           Divider(height: 1, thickness: 1, color: AppColors.toolBackground),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              "Total amount ( in words): One Hundred Eighty Dollars Only",
              style:  TTextTheme.bodyRegular14(context)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNote(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text("Important Note:", style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)) ),
        SizedBox(height: 4),
        Text(
          "Payments are verified after receipt. Subscription renewals are activated once the payment has been successfully confirmed.",
          style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.blackColor),
        ),
      ],
    );
  }

  Widget _buildTaxCalculations(BuildContext context) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1)},
      children: [
        TableRow(
          children: [
             Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("Taxable Amount", textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(r"$20.00", textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
          ],
        ),
        TableRow(
          children: [
             Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text("Discount 0%", textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 4),
              child: Text(r"+ $0.00", textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
          ],
        ),
      ],
    );
  }

  //  PAYMENT SECTION
  Widget _buildPaymentAndFooterSection(BuildContext context, double screenWidth) {
    final isDesktop = screenWidth > 650;

    final paymentBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
         Text("Payment Info:", style: TTextTheme.tableSemiBold18Black(context)),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: "Debit Card : ",
            style: TTextTheme.tableRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
            children: [
              TextSpan(
                text: "465 ************645",
                style: TTextTheme.bodyRegular14(context)
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(height: 4),
        Text.rich(
          TextSpan(
            text: "Amount : ",
            style:  TTextTheme.tableRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
            children: [
              TextSpan(
                text: r"$1,815",
                style:  TTextTheme.bodyRegular14(context)
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );

    final signatureBlock = Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
         Text("From Soft Snip", style: TTextTheme.medium12quadrantal(context)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child:  Text(
            "James Paulo",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: AppColors.secondTextColor,
            ),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              paymentBlock,
              signatureBlock,
            ],
          )
        else ...[
          paymentBlock,
          const SizedBox(height: 24),
          signatureBlock,
        ],
        const SizedBox(height: 24),
        const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
        const SizedBox(height: 20),

         Text("Terms & Conditions :", style: TTextTheme.tableSemiBold18Black(context)),
        const SizedBox(height: 8),
         Text(
          "1. Subscription fees are non-refundable once payment has been successfully verified and the subscription has been activated.\n"
              "2. Customers are responsible for ensuring all billing information and payment references are accurate before submitting a payment.",
          style: TTextTheme.bodyRegular14Search(context)
        ),
        const SizedBox(height: 32),
        const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
         Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              "Thanks for your Business",
              style:  TTextTheme.bodyRegular14Search(context),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
      ],
    );
  }
}