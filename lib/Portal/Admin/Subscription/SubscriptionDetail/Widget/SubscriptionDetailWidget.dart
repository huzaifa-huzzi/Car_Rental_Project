import 'package:car_rental_project/Portal/Admin/Subscription/SubscriptionController.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/ImageString.dart';
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
          title: "General Information",
          subtitle: "Basic detail about the company",
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyLogoField(context, "Company Logo"),
                _buildReadOnlyField(context, "Company Name", "Soft Snip"),
                _buildReadOnlyField(context, "Account Status", "Active"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, "Phone Number", "1234567-8"),
                _buildReadOnlyField(context, "Email Address", "aussie@gmail.com"),
                _buildReadOnlyField(context, "Email Status", "Verified"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, "Address", "123 Hay Street"),
                _buildReadOnlyField(context, "Tax Number", "TAX-SA-98712"),
                _buildReadOnlyField(context, "Joining Date", "4/03/2026"),
              ]),
            ],
          ),
        ),

        const SizedBox(height: 25),
        _buildSectionCard(
          context,
          title: "Subscription Information",
          subtitle: "Company subscription listed here",
          child: Column(
            children: [
              _buildResponsiveRow(isMobile, [
                _buildReadOnlyField(context, "Plan", "Monthly"),
                _buildReadOnlyField(context, "Start Date", "4/03/2026"),
                _buildReadOnlyField(context, "End Date", "4/03/2027"),
              ]),
              const SizedBox(height: 20),
              _buildResponsiveRow(isMobile, [
                _buildDynamicStatusField(context, "Status"),
                _buildReadOnlyField(context, "Remaining Days", "365 Days"),
                _buildReadOnlyField(context, "Limit", "Fleet usage 35/50"),
              ]),
            ],
          ),
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
        Text(label, style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13, color: Colors.grey.shade700)),
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
        Text(label, style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13, color: Colors.grey.shade700)),
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
            style: TTextTheme.tableRegular14black(context).copyWith(fontSize: 13, color: Colors.grey.shade700)
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
            Text(subtitle, style: TTextTheme.bodyRegular14(context).copyWith(color: Colors.grey.shade500)),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}
