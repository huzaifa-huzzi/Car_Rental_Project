import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionDetailWidget extends StatefulWidget {
  const SubscriptionDetailWidget({super.key});

  @override
  State<SubscriptionDetailWidget> createState() => _SubscriptionDetailWidgetState();
}

class _SubscriptionDetailWidgetState extends State<SubscriptionDetailWidget> {
  final controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionCard(
          context,
          title: TextString.SubscriptionTitle44,
          subtitle: TextString.SubscriptionTitle45,
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyLogoField(context,TextString.SubscriptionTitle46),
                _buildReadOnlyField(context,TextString.SubscriptionTitle47 ,TextString.SubscriptionTitle48),
                _buildReadOnlyField(context,TextString.SubscriptionTitle49 ,TextString.SubscriptionTitle50 ),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context,TextString.SubscriptionTitle51 ,TextString.SubscriptionTitle52 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle53 ,TextString.SubscriptionTitle54 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle55,TextString.SubscriptionTitle56 ),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context,TextString.SubscriptionTitle57 ,TextString.SubscriptionTitle58 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle59 ,TextString.SubscriptionTitle60 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle61,TextString.SubscriptionTitle62 ),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 25),
        _buildSectionCard(
          context,
          title:TextString.SubscriptionTitle63,
          subtitle:TextString.SubscriptionTitle64 ,
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context,TextString.SubscriptionTitle65 ,TextString.SubscriptionTitle66 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle67 ,TextString.SubscriptionTitle68 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle69 ,TextString.SubscriptionTitle70 ),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildDynamicStatusField(context,TextString.SubscriptionTitle71 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle72 ,TextString.SubscriptionTitle73 ),
                _buildReadOnlyField(context,TextString.SubscriptionTitle74,TextString.SubscriptionTitle75 ),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 25),
        _buildSectionCard(
          context,
          title:TextString.SubscriptionTitle76 ,
          subtitle:TextString.SubscriptionTitle77 ,
          child: _buildInvoiceBreakdownContent(context, isMobile),
        ),
      ],
    );
  }


   /// ----------- Extra widget --------- ///

  //  Rows Engine Builder
  Widget _buildResponsiveRow(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        children: children.map((c) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: c,
        )).toList(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((c) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: c,
        ),
      )).toList(),
    );
  }

  // Logo ReadOnly Box Panel
  Widget _buildReadOnlyLogoField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13, color: AppColors.quadrantalTextColor.withValues(alpha: 0.7))),
        const SizedBox(height: 8),
        Container(
          height: 44,
          alignment: Alignment.centerLeft,
          child: Image.asset(
            ImageString.plushlogoAdmin,
            height: 36,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  //  ReadOnly Text Field Layout
  Widget _buildReadOnlyField(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13, color: AppColors.quadrantalTextColor.withValues(alpha: 0.7))),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground),
          ),
          child: Text(
            value,
            style: TTextTheme.titleinputTextField(context).copyWith(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Dynamic status
  Widget _buildDynamicStatusField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
            style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13, color: AppColors.quadrantalTextColor.withValues(alpha: 0.7))
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.toolBackground),
          ),
          child: Obx(() {
            String statusText = controller.accountStatus.value.isEmpty
                ? "Active"
                : controller.accountStatus.value;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: controller.getDetailStatusColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusText,
                style:TTextTheme.medium14White(context).copyWith(color: controller.getDetailStatusTextColor())
              ),
            );
          }),
        ),
      ],
    );
  }

  //  Section Architecture Container Card
  Widget _buildSectionCard(BuildContext context, {required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.toolBackground),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TTextTheme.h2Style(context).copyWith(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(subtitle, style: TTextTheme.bodyRegular14(context).copyWith(color: AppColors.quadrantalTextColor.withValues(alpha: 0.7))),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
  Widget _buildInvoiceBreakdownContent(BuildContext context, bool isMobile) {
    Widget invoiceMeta = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(TextString.SubscriptionTitle78, style: TTextTheme.bodyRegular14(context)),
        const SizedBox(height: 4),
        Text(TextString.SubscriptionTitle79, style: TTextTheme.hPickupStyle(context)),
        const SizedBox(height: 2),
        Text(TextString.SubscriptionTitle80, style: TTextTheme.bodyRegular14(context)),
      ],
    );
    Widget actionButtons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.completedColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(TextString.SubscriptionTitle81, style: TTextTheme.medium14White(context).copyWith(fontSize: 12)),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Image.asset(IconString.downloadIcon, height: 14,width: 14, color: Colors.white),
          label: Text(TextString.SubscriptionTitle82, style: TTextTheme.medium12White(context)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 420) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  invoiceMeta,
                  const SizedBox(height: 16),
                  actionButtons,
                ],
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  invoiceMeta,
                  actionButtons,
                ],
              );
            }
          },
        ),

        const SizedBox(height: 20),
        const Divider(color: AppColors.toolBackground, thickness: 1),
        const SizedBox(height: 12),
        _buildBreakdownItem(context, label:TextString.SubscriptionTitle83 , value: "20.00", isBold: true),
        const SizedBox(height: 12),
        _buildBreakdownItem(context, label:TextString.SubscriptionTitle84 , value: "\$8.00", isBold: true),

        const SizedBox(height: 16),
        const Divider(color: AppColors.toolBackground, thickness: 1),
        const SizedBox(height: 16),
        _buildBreakdownItem(context, label:TextString.SubscriptionTitle85, value: "\$160.00", styleColor: AppColors.quadrantalTextColor.withValues(alpha: 0.7)),
        const SizedBox(height: 12),
        _buildBreakdownItem(context, label:TextString.SubscriptionTitle86 , value: "\$8.00", styleColor: AppColors.quadrantalTextColor.withValues(alpha: 0.7)),

        const SizedBox(height: 16),
        const Divider(color: AppColors.toolBackground, thickness: 1),
        const SizedBox(height: 16),
        _buildBreakdownItem(
            context,
            label:TextString.SubscriptionTitle87 ,
            value: "\$168.00",
            isBold: true,
            styleColor: AppColors.primaryColor,
            fontSize: 16
        ),
      ],
    );
  }

 // breakdown list
  Widget _buildBreakdownItem(
      BuildContext context, {
        required String label,
        required String value,
        bool isBold = false,
        Color? styleColor,
        double fontSize = 13
      }) {
    final baseStyle = isBold
        ? TTextTheme.bodySemiBold14black(context)
        : TTextTheme.tableRegular14black(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            label,
            style: baseStyle.copyWith(
                fontSize: fontSize,
                color: isBold ? AppColors.blackColor: AppColors.quadrantalTextColor.withValues(alpha: 0.7)
            )
        ),
        Text(
            value,
            style: baseStyle.copyWith(
                fontSize: fontSize,
                color: styleColor ?? AppColors.blackColor
            )
        ),
      ],
    );
  }
}
