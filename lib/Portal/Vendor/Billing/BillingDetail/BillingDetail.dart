import 'package:car_rental_project/Portal/Vendor/Billing/BillingController.dart';
import 'package:car_rental_project/Portal/Vendor/Billing/ResuableWidget/HeaderWebBillingWidget.dart';
import 'package:car_rental_project/Resources/AppSizes.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
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
                              TextString.billingInvoicesTableEleven,
                              style: TTextTheme.btnWhiteColor(context),
                            ),
                          ),
                          _buildActionBtn(context, text:TextString.billingDetailOne , icon: IconString.billingPdf),
                          _buildActionBtn(context, text:TextString.billingDetailTwo , icon: IconString.billingEmail),
                          _buildActionBtn(context, text:TextString.billingDetailThree , icon: IconString.printIcon),
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
              TextString.billingDetailRecipientOne,
              style:  TTextTheme.h6Style(context),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
            TextString.billingDetailRecipientTwo,
          style: TTextTheme.medium12quadrantal(context)
        ),
      ],
    );

    final taxInvoiceDetailsBlock = Column(
      crossAxisAlignment: screenWidth > 750 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
        TextString.billingDetailRecipientThree,
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
    TextString.billingDetailRecipientFour ,
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
                Text(
    TextString.billingDetailRecipientFive,
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color:  AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
    TextString.billingDetailRecipientSix,
                  style: TTextTheme.bodyRegular14Search(context).copyWith(color:  AppColors.quadrantalTextColor.withOpacity(0.7)),
                ),
                Text(
                  TextString.billingDetailRecipientSeven,
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
         TextString.billingAddressTitleOne,
          style: TTextTheme.titleDriver(context),
        ),
        const SizedBox(height: 8),
        Text(
          TextString.billingAddressTitleOne,
          style: TTextTheme.bodyRegular14(context),
        ),
        const SizedBox(height: 4),
        Text(
          TextString.billingAddressTitleThree,
          style: TTextTheme.bodyRegular14(context),
        ),
      ],
    );

    final targetPayTo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        TextString.billingAddressTitleFour,
          style: TTextTheme.titleDriver(context)),
        const SizedBox(height: 8),
        Text(
        TextString.billingAddressTitleFive,
          style: TTextTheme.bodyRegular14(context),
        ),
        const SizedBox(height: 4),
        Text(
          TextString.billingAddressTitleSix,
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
                Text(TextString.item, style: TTextTheme.medium12(context)),
                Text(TextString.billingPrice, style: TTextTheme.medium12(context)),
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
                      Text(TextString.ActiveVehicleOne, style: TTextTheme.tableRegular14black(context)),
                      SizedBox(height: 6),
                      Text(TextString.ActiveVehicleTwo, style: TTextTheme.tableRegular14black(context)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    Text(TextString.ActiveVehicleThree, style: TTextTheme.medium14black(context)),
                    SizedBox(height: 6),
                    Text(TextString.ActiveVehicleFour, style: TTextTheme.medium14black(context)),
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
                 TextString.billingTotalQuantityOne,
                  style: TTextTheme.bodyRegular14(context),
                ),
                Row(
                  children:  [
                    Text(TextString.billingTotalQuantityTwo, style: TTextTheme.tableSemiBold18Black(context)),
                    SizedBox(width: 24),
                    Text(TextString.billingTotalQuantityThree, style: TTextTheme.tableSemiBold18Black(context)),
                  ],
                ),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Text(
                   TextString.billingTotalQuantityOne,
                  style: TTextTheme.bodyRegular14(context),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(TextString.billingTotalQuantityTwo, style: TTextTheme.tableSemiBold18Black(context)),
                    Text(TextString.billingTotalQuantityThree, style: TTextTheme.tableSemiBold18Black(context)),
                  ],
                ),
              ],
            ),
          ),
           Divider(height: 1, thickness: 1, color: AppColors.toolBackground),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              TextString.totalAmount,
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
        Text(TextString.ImportantNoteOne, style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)) ),
        SizedBox(height: 4),
        Text(
          TextString.ImportantNoteTwo,
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
              child: Text(TextString.taxableAmountTitleOne, textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(TextString.taxableAmountTitleTwo, textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
          ],
        ),
        TableRow(
          children: [
             Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(TextString.taxableAmountTitleThree, textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 4),
              child: Text(TextString.taxableAmountTitleFour, textAlign: TextAlign.right, style: TTextTheme.medium14black(context)),
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
         Text(TextString.billingInfotitleOne, style: TTextTheme.tableSemiBold18Black(context)),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text:TextString.billingInfotitleTwo ,
            style: TTextTheme.tableRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
            children: [
              TextSpan(
                text:TextString.billingInfotitleThree ,
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
            text:TextString.billingInfotitleFour ,
            style:  TTextTheme.tableRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withOpacity(0.7)),
            children: [
              TextSpan(
                text:TextString.billingInfotitleFive ,
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
         Text(TextString.SignatureOne, style: TTextTheme.medium12quadrantal(context)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child:  Text(
          TextString.SignatureTwo,
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

         Text(TextString.TermAndCondition, style: TTextTheme.tableSemiBold18Black(context)),
        const SizedBox(height: 8),
         Text(
    TextString.TermAndConditionOne,
          style: TTextTheme.bodyRegular14Search(context)
        ),
        const SizedBox(height: 32),
        const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
         Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              TextString.TermAndConditionTwo,
              style:  TTextTheme.bodyRegular14Search(context),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1.2, color: AppColors.toolBackground),
      ],
    );
  }
}

