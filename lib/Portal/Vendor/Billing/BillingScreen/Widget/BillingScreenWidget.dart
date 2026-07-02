import 'package:car_rental_project/Portal/Vendor/Billing/BillingController.dart';
import 'package:car_rental_project/Portal/Vendor/Billing/ResuableWidget/PrimaryBtnOfBilling.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:get/get.dart';

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
        /// LEFT SIDEBAR PANEL
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
    final screenWidth = MediaQuery.of(context).size.width;

    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          screenWidth < 400
              ? Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              _buildHeaderTexts(context),
              _buildAddCardButton(context),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildHeaderTexts(context)),
              const SizedBox(width: 10),
              _buildAddCardButton(context),
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
  Widget _buildHeaderTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method", style: TTextTheme.h2Style(context)),
        const SizedBox(height: 2),
        Text("Manage your Save card", style: TTextTheme.bodyRegular14Search(context)),
      ],
    );
  }
  Widget _buildAddCardButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text("Add Card", style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 12)),
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
          Image.asset(IconString.billingCard, height: 22, width: 22,),
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
                    onTap: () {
                      final BillingController billingController = Get.put(BillingController());
                      showEditCardFormDialog(context, controller: billingController);
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildCardActionBtn(
                    icon: IconString.deleteIcon,
                    onTap: () {
                      showDeleteCardDialog(
                        context,
                        onConfirm: () {
                          showSuccessDeleteDialog(context);
                        },
                      );
                    },
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


   /// Delete Dialog
  void showDeleteCardDialog(BuildContext context, {required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        // Choti screens par padding manage karne ke liye 90% width di hai
        final dialogWidth = screenWidth > 600 ? 450.0 : screenWidth * 0.90;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            width: dialogWidth,
            padding: const EdgeInsets.all(20), // Padding thodi optimize ki hai choti screen ke liye
            child: Stack(
              children: [
                // Cross close button ko top par rakha hai safely
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.quadrantalTextColor.withOpacity(0.1), // Opacity thodi kam ki taake smooth lage
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.close, size: 14, color: AppColors.secondTextColor),
                    ),
                  ),
                ),
                // Main Content
                Padding(
                  // Right side par 30px padding di taake content kabhi bhi close cross icon ke neche na ghuse
                  padding: const EdgeInsets.only(right: 30, top: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delete Card",
                                  style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Are you sure you want to delete Card?",
                                  style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onConfirm();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primaryColor,),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Save", style: TTextTheme.btnSavePrimary(context).copyWith(fontSize: 13)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Cancel", style: TTextTheme.btnCancel(context).copyWith(color: Colors.white, fontSize: 13)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showSuccessDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final dialogWidth = screenWidth > 600 ? 450.0 : screenWidth * 0.90;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            width: dialogWidth,
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.quadrantalTextColor.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.close, size: 14, color: AppColors.secondTextColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 5),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Card Deleted Successfully",
                                  style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    "Congratulation! card has deleted successfully",
                                    style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

   /// Edit Button Dialogs
  Widget _buildSearchableDropdown(
      BuildContext context,
      String label,
      RxString selected, {
        required String id,
        required BillingController controller,
        required String hintSearchText,
      }) {
    final TextEditingController searchController = TextEditingController();

    return Obx(() {
      bool isOpen = controller.openedDropdown2.value == id;
      String errorMsg = controller.dropdownErrors[id] ?? "";
      bool hasError = errorMsg.isNotEmpty;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TTextTheme.titleTwo(context)),
          const SizedBox(height: 6),
          LayoutBuilder(builder: (context, constraints) {
            return PopupMenuButton<String>(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
                maxHeight: 380,
              ),
              offset: const Offset(0, 52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              elevation: 4,
              onOpened: () {
                controller.openedDropdown2.value = id;
                controller.searchCarText.value = "";
                searchController.clear();
              },
              onCanceled: () {
                controller.openedDropdown2.value = "";
                controller.searchCarText.value = "";
              },
              onSelected: (val) {
                selected.value = val;
                if (controller.dropdownErrors.containsKey(id)) {
                  controller.dropdownErrors[id] = "";
                }
                controller.openedDropdown2.value = "";
                controller.searchCarText.value = "";
              },
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: hasError ? AppColors.primaryColor : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selected.value.isEmpty ? "Select $label" : selected.value,
                        style: TTextTheme.pOne(context).copyWith(
                          color: selected.value.isEmpty ? AppColors.quadrantalTextColor.withOpacity(0.7) : AppColors.blackColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: AppColors.blackColor,
                      size: 22,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    enabled: false,
                    child: Obx(() {
                      var items = controller.getFilteredItems(id);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.3)),
                            ),
                            child: TextFormField(
                              controller: searchController,
                              cursorColor: AppColors.blackColor,
                              autofocus: true,
                              onChanged: (val) {
                                controller.searchCarText.value = val;
                              },
                              style: TTextTheme.titleinputTextField(context),
                              decoration: InputDecoration(
                                hintText: hintSearchText,
                                hintStyle: TTextTheme.bodyRegular14Search(context),
                                prefixIcon: Icon(Icons.search, color: AppColors.primaryColor, size: 18),
                                filled: true,
                                fillColor: AppColors.backgroundOfScreenColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 220),
                            child: items.isEmpty
                                ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(child: Text("No match found")),
                            )
                                : ListView.builder(
                              shrinkWrap: true,
                              itemCount: items.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                bool isSelected = selected.value == item;

                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(item);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                                    child: Row(
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 150),
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                            border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: isSelected
                                              ? const Center(
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          )
                                              : null,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          item,
                                          style: TTextTheme.medium14(context)
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ];
              },
            );
          }),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(errorMsg, style: TTextTheme.ErrorStyle(context)),
            ),
        ],
      );
    });
  }
  void showEditCardFormDialog(BuildContext context, {required BillingController controller}) {
    controller.clearAllFields();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;
        final dialogWidth = screenWidth > 600 ? 550.0 : screenWidth * 0.94;

        return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: screenWidth > 600 ? 40.0 : 12.0,
              vertical: 24.0
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: dialogWidth,
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.85,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "Edit Payment Method",
                            style: TTextTheme.h2Style(context)
                        ),
                        const SizedBox(height: 2),
                        Text(
                            "Save new Card Here",
                            style: TTextTheme.bodyRegular14Search(context)
                        ),
                        const SizedBox(height: 16),
                        Text("Card Holder", style: TTextTheme.titleTwo(context)),
                        const SizedBox(height: 6),
                        _buildModalTextField(context, controller: controller.nameController, hint: "Enter Name"),
                        const SizedBox(height: 14),
                        Text("Card Number", style: TTextTheme.titleTwo(context)),
                        const SizedBox(height: 6),
                        _buildModalTextField(context, controller: controller.numberController, hint: "Enter Number"),
                        const SizedBox(height: 14),
                        Text("CVC Code", style: TTextTheme.titleTwo(context)),
                        const SizedBox(height: 6),
                        _buildModalTextField(context, controller: controller.cvcController, hint: "424242"),
                        const SizedBox(height: 14),
                        screenWidth < 480
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSearchableDropdown(context, "Select Month (Expiry Date)", controller.selectedMonth, id: "month", controller: controller, hintSearchText: "Search Month"),
                            const SizedBox(height: 14),
                            _buildSearchableDropdown(context, "Select Year", controller.selectedYear, id: "year", controller: controller, hintSearchText: "Search Year"),
                          ],
                        )
                            : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildSearchableDropdown(context, "Select Month (Expiry Date)", controller.selectedMonth, id: "month", controller: controller, hintSearchText: "Search Month")),
                            const SizedBox(width: 14),
                            Expanded(child: _buildSearchableDropdown(context, "Select Year", controller.selectedYear, id: "year", controller: controller, hintSearchText: "Search Year")),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Obx(() => Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: controller.isDefaultPayment.value,
                                activeColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                onChanged: (val) {
                                  controller.isDefaultPayment.value = val ?? false;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Set as default payment method",
                                style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey[300]!),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text("Cancel", style: TTextTheme.btnTwo(context).copyWith(color: AppColors.blackColor, fontSize: 13)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryBtnOfBilling(
                          text: "Save Card",
                          height: 42,
                          icon: Image.asset(IconString.uploadIcon,height: 16,width: 16,),
                          isIconLeft: true,
                          onTap: () {
                            Navigator.pop(context);
                            showConfirmEditDialog(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// TextField
  Widget _buildModalTextField(BuildContext context, {required TextEditingController controller, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        cursorColor: AppColors.blackColor,
        controller: controller,
        style: TTextTheme.titleinputTextField(context),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TTextTheme.bodyRegular14Search(context),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: InputBorder.none,
        ),
      ),
    );
  }
  void showConfirmEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final dialogWidth = screenWidth > 600 ? 450.0 : screenWidth * 0.90;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            width: dialogWidth,
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.quadrantalTextColor.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.close, size: 14, color: AppColors.secondTextColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit Card",
                                  style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Are you sure you want to edit Card?",
                                  style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                showSuccessEditDialog(context);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primaryColor),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Save", style: TTextTheme.btnSavePrimary(context).copyWith(fontSize: 13)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text("Cancel", style: TTextTheme.btnCancel(context).copyWith(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void showSuccessEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final dialogWidth = screenWidth > 600 ? 450.0 : screenWidth * 0.90;

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            width: dialogWidth,
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.quadrantalTextColor.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.close, size: 14, color: AppColors.secondTextColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30, top: 5),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Card edited Successfully",
                                  style: TTextTheme.h2Style(context),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Congratulation! card detail has edited successfully",
                                  style: TTextTheme.bodyRegular14Search(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}