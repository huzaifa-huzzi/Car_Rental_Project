import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';

class BillingScreenWidget extends StatelessWidget {
  const BillingScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobileOrTablet = width < 900;

    if (isMobileOrTablet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubscriptionInfoCard(context),
          const SizedBox(height: 20),
          _buildDefaultPaymentMethodCard(context),
          const SizedBox(height: 20),
          _buildPaymentMethodSection(context, isCompact: true),
          const SizedBox(height: 20),
          _buildBillingInfoCard(context),
          const SizedBox(height: 20),
          _buildAllInvoicesCard(context),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// LEFT SIDEBAR PANEL (Fixed structural aspect)
        SizedBox(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubscriptionInfoCard(context),
              const SizedBox(height: 20),
              _buildDefaultPaymentMethodCard(context),
            ],
          ),
        ),
        const SizedBox(width: 24),

        /// RIGHT MAIN DASHBOARD CONTENT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaymentMethodSection(context, isCompact: false),
              const SizedBox(height: 24),
              _buildBillingInfoCard(context),
              const SizedBox(height: 24),
              _buildAllInvoicesCard(context),
            ],
          ),
        ),
      ],
    );
  }


   /// ---------- Extra Widget ----------- ///

  // Subscription Information Card
  Widget _buildSubscriptionInfoCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Subscription Information", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text("Company subscription listed here", style: TTextTheme.bodyRegular14Search(context)),
          const SizedBox(height: 16),
          _buildTextRow(context, "Plan", "Monthly", isValueBold: true),
          _buildTextRow(context, "Start Date", "4/03/2026"),
          _buildTextRow(context, "End Date", "4/03/2027"),
          _buildTextRow(context, "Status", "Active", valueColor: AppColors.completedColor, isValueBold: false),
          _buildTextRow(context, "Remaining Days", "365 Days"),
          _buildTextRow(context, "Limit", "Fleet usage 35/50", isValueBold: true),
        ],
      ),
    );
  }

  //  Payment Method
  Widget _buildDefaultPaymentMethodCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Default Payment Method", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text("Primary card for changes", style: TTextTheme.bodyRegular14Search(context)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.Card1Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(IconString.billingCard,height: 26,width: 26,),
                const SizedBox(height: 24),
                Text("••••   ••••   ••••   4242", style: TTextTheme.billingWhite(context)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Card Holder", style: TTextTheme.BillingFour(context)),
                        Text("Jhon Smith", style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 14)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expiry date", style:  TTextTheme.BillingFour(context)),
                        Text("4/06/2028", style:TTextTheme.btnWhiteColor(context).copyWith(fontSize: 14)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // Payment Method Section
  Widget _buildPaymentMethodSection(BuildContext context, {required bool isCompact}) {
    final cardWidth = isCompact ? double.infinity : 260.0;

    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Method", style: TTextTheme.h2Style(context)),
                  const SizedBox(height: 2),
                  Text("Manage your Save card", style: TTextTheme.bodyRegular14Search(context)),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text("Add Card", style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildMiniSavedCard(context, cardWidth, AppColors.Card1Color),
              _buildMiniSavedCard(context, cardWidth, AppColors.Card2Colors),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildMiniSavedCard(BuildContext context, double targetWidth, Color cardColor) {
    return Container(
      width: targetWidth,
      height: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(IconString.billingCard,height: 22,width: 22,),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "... ",
                  style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 24)
                ),
                const SizedBox(width: 14),
                Text(
                  "4242",
                  style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 24)
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Visa",
                style: TTextTheme.titleFour(context).copyWith(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  _buildCardActionBtn(
                    icon: IconString.editIcon,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  _buildCardActionBtn(
                    icon: IconString.deleteIcon,
                    onTap: () {},
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  Widget _buildCardActionBtn({required String icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.white.withOpacity(0.22),
            width: 1,
          ),
        ),
        child: Image.asset(
          icon,
          color: Colors.white,
          height: 16,
          width: 16,
        ),
      ),
    );
  }

  // Billing Info Card
  Widget _buildBillingInfoCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Billing Info", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text("Here is your billing info", style: TTextTheme.bodyRegular14Search(context)),
          const SizedBox(height: 20),
          _buildBillingDetailRow(context, "Phone Number", "+61 2 9876 5432"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.toolBackground, thickness: 1),
          ),
          _buildBillingDetailRow(context, "Address", "Level 5, 120 George Street\nSydney NSW 2000\nAustralia"),
        ],
      ),
    );
  }

  // Invoices Table
  Widget _buildAllInvoicesCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("All Invoices", style: TTextTheme.h2Style(context)),
          const SizedBox(height: 4),
          Text("List of all Invoices", style:  TTextTheme.bodyRegular14Search(context)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildSearchInput(context, hint: "Search by Month", width: 150),
                      const SizedBox(width: 12),
                      _buildFilterDropdown(context, "2026"),
                      const SizedBox(width: 12),
                      _buildSearchInput(context, hint: "Search Company by Name", width: 240, hasIcon: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 700),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(1.2),
                  2: FlexColumnWidth(0.9),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(1.0),
                  5: FlexColumnWidth(0.8),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1.5)),
                    ),
                    children: [
                      _buildTableHeaderCell(context, "Invoice Id"),
                      _buildTableHeaderCell(context, "Month"),
                      _buildTableHeaderCell(context, "Year"),
                      _buildTableHeaderCell(context, "Payment"),
                      _buildTableHeaderCell(context, "Status"),
                      _buildTableHeaderCell(context, "Action"),
                    ],
                  ),
                  ...List.generate(4, (index) => TableRow(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
                    ),
                    children: [
                      _buildTableCell(context, "Abc12345", isBold: true),
                      _buildTableCell(context, "February"),
                      _buildTableCell(context, "2026"),
                      _buildTableCell(context, "\$45.00"),
                      _buildStatusCell(context, "Paid"),
                      _buildActionCell(context),
                    ],
                  )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Refined Custom
  Widget _buildSearchInput(BuildContext context, {required String hint, required double width, bool hasIcon = false}) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.signaturePadColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(left: 14, right: hasIcon ? 4 : 14),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (hasIcon) ...[
            Icon(Icons.search, size: 16, color: AppColors.quadrantalTextColor.withOpacity(0.6)),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextField(
              cursorColor: AppColors.blackColor,
              style: TTextTheme.titleTwo(context).copyWith(fontSize: 13, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TTextTheme.titleFour(context).copyWith(fontSize: 13, color: AppColors.quadrantalTextColor.withOpacity(0.6)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (hasIcon)
            GestureDetector(
              onTap: () {
              },
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Search",
                  style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
        ],
      ),
    );
  }

  //  Custom Dropdown
  Widget _buildFilterDropdown(BuildContext context, String text) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.signaturePadColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(IconString.calendarIcon,height: 18,width: 18,),
          const SizedBox(width: 8),
          Text(text, style: TTextTheme.titleTwo(context).copyWith(fontSize: 13,)),
          const SizedBox(width: 6),
        ],
      ),
    );
  }

  // Action View
  Widget _buildActionCell(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(IconString.viewIcon,height: 15,width: 15,color: Colors.white,),
          ),
        ),
      ),
    );
  }

   // Card Wrapper
  Widget _buildCardWrapper({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.toolBackground),
      ),
      child: child,
    );
  }

   // TextRow
  Widget _buildTextRow(BuildContext context, String label, String value, {Color? valueColor, bool isValueBold = false}) {
    final bool isActiveStatus = value.trim() == "Active";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TTextTheme.bodyRegular14Search(context),
              ),
              Text(
                value,
                style: TTextTheme.titleTwo(context).copyWith(
                  color: isActiveStatus
                      ?  AppColors.completedColor
                      : (valueColor ?? AppColors.blackColor),
                  fontWeight: isActiveStatus ? FontWeight.w400 : FontWeight.bold

                ),
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.toolBackground,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }

   // BillingRow
  Widget _buildBillingDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: TTextTheme.bodyRegular14Search(context)),
        ),
        Expanded(
          child: Text(
            value,
            style: TTextTheme.medium14black(context),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

   // HeaderCell
  Widget _buildTableHeaderCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Text(text, style: TTextTheme.bodyRegular14Search(context)),
    );
  }
 // Tablecell
  Widget _buildTableCell(BuildContext context, String text, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      child: Text(
        text,
        style: isBold
            ? TTextTheme.titleTwo(context).copyWith(fontSize: 13, fontWeight: FontWeight.bold)
            : TTextTheme.titleTwo(context).copyWith(fontSize: 13, fontWeight: FontWeight.normal),
      ),
    );
  }

   // Status Cell
  Widget _buildStatusCell(BuildContext context, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          status,
          style: TTextTheme.titleTwo(context).copyWith( color:AppColors.completedColor),
        ),
      ),
    );
  }
}