import 'package:car_rental_project/Portal/Vendor/Billing/BillingController.dart';
import 'package:car_rental_project/Portal/Vendor/Billing/ResuableWidget/PrimaryBtnOfBilling.dart';
import 'package:car_rental_project/Resources/IconStrings.dart';
import 'package:car_rental_project/Resources/TextString.dart';
import 'package:flutter/material.dart';
import 'package:car_rental_project/Resources/Colors.dart';
import 'package:car_rental_project/Resources/TextTheme.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class BillingScreenWidget extends StatelessWidget {
  BillingScreenWidget({super.key});

  final BillingController controller = Get.put(BillingController());

  @override
  Widget build(BuildContext context) {
    final double currentWidth = MediaQuery
        .of(context)
        .size
        .width;
    final bool isMobileOrTablet = currentWidth < 950;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildCustomTabButtons(context),
            ],
          ),
          const SizedBox(height: 24),
          isMobileOrTablet
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        ],
      ),
    );
  }


   /// ---------- Extra Widgets -------- ///

   // Layouts
  Widget _buildMobileLayout(BuildContext context) {
    return Obx(() {
      final bool isOverview = controller.selectedTabIndex.value == 0;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOverview) ...[
            _buildSubscriptionInfoCard(context),
            const SizedBox(height: 20),
            _buildDefaultPaymentMethodCard(context),
            const SizedBox(height: 24),
            _buildAllInvoicesCard(context),
          ] else ...[
            _buildPaymentMethodSection(context, isCompact: true),
            const SizedBox(height: 20),
            _buildBillingInfoCard(context),
          ],
        ],
      );
    });
  }
  Widget _buildDesktopLayout(BuildContext context) {
    return Obx(() {
      final bool isOverview = controller.selectedTabIndex.value == 0;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isOverview)
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
          if (isOverview) const SizedBox(width: 24),
          Expanded(
            child: isOverview
                ? _buildAllInvoicesCard(context)
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPaymentMethodSection(context, isCompact: false),
                const SizedBox(height: 24),
                _buildBillingInfoCard(context),
              ],
            ),
          ),
        ],
      );
    });
  }

   // Tabs
  Widget _buildCustomTabButtons(BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildIndividualTabToggle(
            context,
            title: TextString.billingTabOne,
            isSelected: controller.selectedTabIndex.value == 0,
            onTap: () => controller.selectedTabIndex.value = 0,
          ),
          _buildIndividualTabToggle(
            context,
            title:TextString.billingTabTwo ,
            isSelected: controller.selectedTabIndex.value == 1,
            onTap: () => controller.selectedTabIndex.value = 1,
          ),
        ],
      );
    });
  }
  Widget _buildIndividualTabToggle(BuildContext context, {required String title, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        alignment: Alignment.center,
        // Fixed compact responsive padding settings
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? (AppColors.primaryColor) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : (AppColors.unavailableEnd ?? const Color(0xFFCBD5E1)),
            width: 1.2,
          ),
        ),
        child: Text(
          title,
          maxLines: 1,
          style: isSelected
              ? TTextTheme.bodyRegular12(context).copyWith(color: Colors.white, fontSize: 12)
              : TTextTheme.bodyRegular12(context).copyWith(color: AppColors.secondTextColor, fontSize: 12),
        ),
      ),
    );
  }

   // Subscription Card
  Widget _buildSubscriptionInfoCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.billingSubscriptionOne, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text(TextString.billingSubscriptionTwo, style: TTextTheme.bodyRegular14Search(context)),
          const SizedBox(height: 16),
          _buildTextRow(context,TextString.billingSubscriptionThree , "Monthly", isValueBold: true),
          _buildTextRow(context,TextString.billingSubscriptionFour , "4/03/2026"),
          _buildTextRow(context,TextString.billingSubscriptionFive , "4/03/2027"),
          _buildTextRow(context,TextString.billingSubscriptionSix , "Active", valueColor: AppColors.completedColor, isValueBold: false),
          _buildTextRow(context,TextString.billingSubscriptionSeven , "365 Days"),
          _buildTextRow(context,TextString.billingSubscriptionEight, "50", isValueBold: true),
        ],
      ),
    );
  }
}


   /// ------------------ Extra Widgets ----------- ///

 // Payment Cards
  Widget _buildDefaultPaymentMethodCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.billingPaymentOne, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text(TextString.billingPaymentTwo, style: TTextTheme.bodyRegular14Search(context)),
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
                Image.asset(IconString.billingCard, height: 26, width: 26),
                const SizedBox(height: 24),
                Text(TextString.billingPaymentThree, style: TTextTheme.billingWhite(context)),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.billingPaymentFour, style: TTextTheme.BillingFour(context)),
                        Text(TextString.billingPaymentFive, style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 14)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TextString.billingPaymentSix, style: TTextTheme.BillingFour(context)),
                        Text(TextString.billingPaymentSeven, style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 14)),
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
  Widget _buildPaymentMethodSection(BuildContext context, {required bool isCompact}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = isCompact
        ? double.infinity
        : (screenWidth > 1200 ? 320.0 : (screenWidth > 950 ? 240.0 : 260.0));

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
              _buildMiniSavedCard(context, cardWidth, AppColors.Card1Color ,BillingController()),
              _buildMiniSavedCard(context, cardWidth, AppColors.Card2Colors ,BillingController()),
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
        Text(TextString.billingPaymentTitle, style: TTextTheme.h2Style(context)),
        const SizedBox(height: 2),
        Text(TextString.billingPaymentSubtitle, style: TTextTheme.bodyRegular14Search(context)),
      ],
    );
  }

  Widget _buildAddCardButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddCardFormDialog(context, controller: BillingController());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(TextString.AddCard, style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 12)),
      ),
    );
  }

  Widget _buildMiniSavedCard(BuildContext context, double targetWidth, Color cardColor,BillingController controller) {
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
          Image.asset(IconString.billingCard, height: 22, width: 22),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(TextString.dots, style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 24)),
                const SizedBox(width: 14),
                Text(TextString.Numbers, style: TTextTheme.btnWhiteColor(context).copyWith(fontSize: 24)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               TextString.visaCard,
                style: TTextTheme.titleFour(context).copyWith(color: Colors.white70),
              ),
              Row(
                children: [
                  _buildCardActionBtn(
                    icon: IconString.editIcon,
                    onTap: () => showEditCardFormDialog(context, controller: controller),
                  ),
                  const SizedBox(width: 10),
                  _buildCardActionBtn(
                    icon: IconString.deleteIcon,
                    onTap: () {
                      showDeleteCardDialog(context, onConfirm: () {
                        showSuccessDeleteDialog(context);
                      });
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


    // Cards
  Widget _buildCardActionBtn({required String icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white.withOpacity(0.22), width: 1),
        ),
        child: Image.asset(icon, color: Colors.white, height: 16, width: 16),
      ),
    );
  }

  Widget _buildBillingInfoCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.billingInfoOne, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 2),
          Text(TextString.billingInfoTwo, style: TTextTheme.bodyRegular14Search(context)),
          const SizedBox(height: 20),
          _buildBillingDetailRow(context,TextString.billingInfoThree , TextString.billingInfoFour),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.toolBackground, thickness: 1),
          ),
          _buildBillingDetailRow(context,TextString.billingInfoFive ,TextString.billingInfoSix ),
        ],
      ),
    );
  }

  Widget _buildAllInvoicesCard(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TextString.billingInvoicesTitle, style: TTextTheme.h2Style(context)),
          const SizedBox(height: 4),
          Text(TextString.billingInvoicesSubtitle, style: TTextTheme.bodyRegular14Search(context)),
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
                      _buildSearchInput(context, hint:TextString.billingInvoicesSubtitleTwo , width: 230, hasIcon: true),
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
                      _buildTableHeaderCell(context,TextString.billingInvoicesTableOne ),
                      _buildTableHeaderCell(context,TextString.billingInvoicesTableTwo),
                      _buildTableHeaderCell(context,TextString.billingInvoicesTableThree ),
                      _buildTableHeaderCell(context,TextString.billingInvoicesTableFour ),
                      _buildTableHeaderCell(context,TextString.billingInvoicesTableFive ),
                      _buildTableHeaderCell(context,TextString.billingInvoicesTableSix ),
                    ],
                  ),
                  ...List.generate(4, (index) => TableRow(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1)),
                    ),
                    children: [
                      _buildTableCell(context,TextString.billingInvoicesTableSeven , isBold: true),
                      _buildTableCell(context,TextString.billingInvoicesTableEight ),
                      _buildTableCell(context,TextString.billingInvoicesTableNine),
                      _buildTableCell(context,TextString.billingInvoicesTableTen ),
                      _buildStatusCell(context,TextString.billingInvoicesTableEleven),
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

  Widget _buildSearchInput(BuildContext context, {required String hint, required double width, bool hasIcon = false}) {
  final double currentScreenWidth = MediaQuery.of(context).size.width;
  final bool isWeb = currentScreenWidth >= 950;
  final double adaptiveWidth = isWeb ? 380.0 : width;

  return Container(
    width: adaptiveWidth,
    height: 40,
    decoration: BoxDecoration(
      color: AppColors.signaturePadColor ,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.only(left: 14, right: hasIcon ? 4 : 14),
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        if (hasIcon) ...[
          Icon(Icons.search, size: 16, color: (AppColors.quadrantalTextColor ).withOpacity(0.6)),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: TextField(
            cursorColor: AppColors.blackColor,
            style: TTextTheme.titleTwo(context).copyWith(fontSize: 13, fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TTextTheme.titleFour(context).copyWith(fontSize: 13, color: (AppColors.quadrantalTextColor).withOpacity(0.6)),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        if (hasIcon)
          GestureDetector(
            onTap: () {},
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
                style: TTextTheme.btnWhiteColor(context).copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ),
      ],
    ),
  );
}
  Widget _buildActionCell(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            context.go('/billingsDetails');
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.asset(IconString.viewIcon, height: 15, width: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

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

  Widget _buildTextRow(BuildContext context, String label, String value, {Color? valueColor, bool isValueBold = false}) {
    final bool isActiveStatus = value.trim() == "Active";

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TTextTheme.bodyRegular14Search(context)),
              Text(
                value,
                style: TTextTheme.titleTwo(context).copyWith(
                    color: isActiveStatus ? AppColors.completedColor : (valueColor ?? AppColors.blackColor),
                    fontWeight: isActiveStatus ? FontWeight.w400 : FontWeight.bold),
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

  Widget _buildTableHeaderCell(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Text(text, style: TTextTheme.bodyRegular14Search(context)),
    );
  }

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

  Widget _buildStatusCell(BuildContext context, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          status,
          style: TTextTheme.titleTwo(context).copyWith(color: AppColors.completedColor),
        ),
      ),
    );
  }


   // Searchable Dropdowns
  Widget _buildSearchableDropdown(
      BuildContext context,
      String label,
      RxString selected, {
        required String id,
        required BillingController controller,
        required String hintSearchText,
        required double parentWidth,
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
          PopupMenuButton<String>(
            constraints: BoxConstraints(
              minWidth: parentWidth,
              maxWidth: parentWidth,
              maxHeight: 340,
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
                        color: selected.value.isEmpty
                            ? (AppColors.quadrantalTextColor).withOpacity(0.7)
                            : AppColors.blackColor,
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
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: parentWidth - 32,
                      child: Obx(() {
                        var items = controller.getFilteredItems(id);

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 40,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.3)),
                              ),
                              child: TextFormField(
                                controller: searchController,
                                cursorColor: AppColors.blackColor,
                                autofocus: false,
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
                            const SizedBox(height: 4),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                maxHeight: 160,
                              ),
                              child: items.isEmpty
                                  ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(child: Text("No match found")),
                              )
                                  : ListView.builder(
                                shrinkWrap: true,
                                itemCount: items.length,
                                padding: EdgeInsets.zero,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = items[index];
                                  bool isSelected = selected.value == item;

                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop(item);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                                      child: Row(
                                        children: [
                                          AnimatedContainer(
                                            duration: const Duration(milliseconds: 150),
                                            width: 16,
                                            height: 16,
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
                                                size: 12,
                                              ),
                                            )
                                                : null,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: TTextTheme.medium14(context),
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                  ),
                ),
              ];
            },
          ),
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(errorMsg, style: TTextTheme.ErrorStyle(context)),
            ),
        ],
      );
    });
  }


   // Edit Dialog
void showEditCardFormDialog(BuildContext context, {required BillingController controller}) {
  controller.clearAllFields();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final dialogWidth = screenWidth > 600 ? 550.0 : screenWidth * 0.94;

      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: screenWidth > 600 ? 40 : 12,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: dialogWidth,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       TextString.EditDialogOne,
                        style: TTextTheme.h2Style(context),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        TextString.EditDialogTwo,
                        style: TTextTheme.bodyRegular14Search(context),
                      ),
                      const SizedBox(height: 20),

                      Text(TextString.EditDialogThree, style: TTextTheme.titleTwo(context)),
                      const SizedBox(height: 6),
                      _buildModalTextField(context, controller: controller.nameController, hint: "Enter Name"),
                      const SizedBox(height: 14),

                      Text(TextString.EditDialogFour, style: TTextTheme.titleTwo(context)),
                      const SizedBox(height: 6),
                      _buildModalTextField(context, controller: controller.numberController, hint: "Enter Number"),
                      const SizedBox(height: 14),

                      Text(TextString.EditDialogFive, style: TTextTheme.titleTwo(context)),
                      const SizedBox(height: 6),
                      _buildModalTextField(context, controller: controller.cvcController, hint: "424242"),
                      const SizedBox(height: 14),

                      Builder(
                        builder: (context) {
                          final bool isSmallForm = dialogWidth < 500;
                          final double dropdownCalculatedWidth = isSmallForm ? dialogWidth - 40 : (dialogWidth - 58) / 2;

                          if (isSmallForm) {
                            return Column(
                              children: [
                                _buildSearchableDropdown(
                                  context,
                                  TextString.EditDialogSix,
                                  controller.selectedMonth,
                                  id: "month",
                                  controller: controller,
                                  hintSearchText: "Search Month",
                                  parentWidth: dropdownCalculatedWidth,
                                ),
                                const SizedBox(height: 16),
                                _buildSearchableDropdown(
                                  context,
                                  TextString.EditDialogSeven,
                                  controller.selectedYear,
                                  id: "year",
                                  controller: controller,
                                  hintSearchText: "Search Year",
                                  parentWidth: dropdownCalculatedWidth,
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildSearchableDropdown(
                                    context,
                                    TextString.EditDialogSix,
                                    controller.selectedMonth,
                                    id: "month",
                                    controller: controller,
                                    hintSearchText: "Search Month",
                                    parentWidth: dropdownCalculatedWidth,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: _buildSearchableDropdown(
                                    context,
                                    TextString.EditDialogSeven,
                                    controller.selectedYear,
                                    id: "year",
                                    controller: controller,
                                    hintSearchText: "Search Year",
                                    parentWidth: dropdownCalculatedWidth,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
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
                                TextString.EditDialogEight,
                              style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.tertiaryTextColor.withOpacity(0.7)),
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
                          icon: Image.asset(IconString.uploadIcon, height: 16, width: 16, color: Colors.white),
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
        ),
      );
    },
  );
}

    //  Add Dialog
  void showAddCardFormDialog(BuildContext context, {required BillingController controller}) {
  controller.clearAllFields();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final screenWidth = MediaQuery.of(context).size.width;
      final dialogWidth = screenWidth > 600 ? 550.0 : screenWidth * 0.94;

      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(
          horizontal: screenWidth > 600 ? 40 : 12,
          vertical: 24,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: dialogWidth,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextString.EditDialogNine,
                        style: TTextTheme.h2Style(context),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        TextString.EditDialogTen,
                        style: TTextTheme.bodyRegular14Search(context),
                      ),
                      const SizedBox(height: 20),

                      Text(TextString.EditDialogThree, style: TTextTheme.titleTwo(context)),
                      const SizedBox(height: 6),
                      _buildModalTextField(context, controller: controller.nameController, hint: "Enter Name"),
                      const SizedBox(height: 14),

                      Text(TextString.EditDialogFour, style: TTextTheme.titleTwo(context)),
                      const SizedBox(height: 6),
                      _buildModalTextField(context, controller: controller.numberController, hint: "Enter Number"),
                      const SizedBox(height: 14),

                      Text(TextString.EditDialogFive, style: TTextTheme.titleTwo(context)),
                      const SizedBox(height: 6),
                      _buildModalTextField(context, controller: controller.cvcController, hint: "424242"),
                      const SizedBox(height: 14),

                      Builder(
                        builder: (context) {
                          final bool isSmallForm = dialogWidth < 500;
                          final double dropdownCalculatedWidth = isSmallForm ? dialogWidth - 40 : (dialogWidth - 58) / 2;

                          if (isSmallForm) {
                            return Column(
                              children: [
                                _buildSearchableDropdown(
                                  context,
                                  TextString.EditDialogSix,
                                  controller.selectedMonth,
                                  id: "month",
                                  controller: controller,
                                  hintSearchText: "Search Month",
                                  parentWidth: dropdownCalculatedWidth,
                                ),
                                const SizedBox(height: 16),
                                _buildSearchableDropdown(
                                  context,
                                  TextString.EditDialogSeven,
                                  controller.selectedYear,
                                  id: "year",
                                  controller: controller,
                                  hintSearchText: "Search Year",
                                  parentWidth: dropdownCalculatedWidth,
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildSearchableDropdown(
                                    context,
                                    TextString.EditDialogSix,
                                    controller.selectedMonth,
                                    id: "month",
                                    controller: controller,
                                    hintSearchText: "Search Month",
                                    parentWidth: dropdownCalculatedWidth,
                                  ),
                                ),
                                const SizedBox(width: 18),
                                Expanded(
                                  child: _buildSearchableDropdown(
                                    context,
                                    TextString.EditDialogSeven,
                                    controller.selectedYear,
                                    id: "year",
                                    controller: controller,
                                    hintSearchText: "Search Year",
                                    parentWidth: dropdownCalculatedWidth,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
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
                              TextString.EditDialogEight,
                              style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 12),
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
                          icon: Image.asset(IconString.uploadIcon, height: 16, width: 16, color: Colors.white),
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
        ),
      );
    },
  );
}

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


   // Delete Dialogs
  void showDeleteCardDialog(BuildContext context, {required VoidCallback onConfirm}) {
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
                        color: (AppColors.quadrantalTextColor).withOpacity(0.1),
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
                                  TextString.DeleteDialogTitle,
                                  style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  TextString.DeleteDialogSubtitle,
                                  style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onConfirm();
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
                        color: (AppColors.quadrantalTextColor).withOpacity(0.1),
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
                                  TextString.DeletionSuccessTitle,
                                  style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(TextString.DeletionSuccessSubtitle, style: TTextTheme.bodyRegular14Search(context).copyWith(fontSize: 13)),
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

   // Edit dialogs
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
                        color: (AppColors.quadrantalTextColor).withOpacity(0.1),
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
                                  TextString.EditCardTitle,
                                  style: TTextTheme.h2Style(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  TextString.EditCardSubtitle,
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
                        color: (AppColors.quadrantalTextColor ?? Colors.grey).withOpacity(0.1),
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
                                Text(TextString.EditSuccesTitle, style: TTextTheme.h2Style(context)),
                                const SizedBox(height: 4),
                                Text(TextString.EditSuccesSubtitle, style: TTextTheme.bodyRegular14Search(context)),
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